import jwt from "jsonwebtoken";
import bcryptjs from "bcryptjs";
import crypto from "crypto";

import { User } from "../model/userModel.js";

import sendVerificationEmail from "../utils/sendVerificationEmail.js";
import sendWelcomeEmail from "../utils/sendWelcomeEmail.js"
import sendPasswordResetEmail from "../utils/sendPasswordResetEmail.js";
import sendResetSuccessEmail from "../utils/sendResetSuccessEmail.js";

import cloudinary from "../config/cloudinary.js";

export const signup = async (req, res) => {
    const { email, password, name } = req.body;

	try {
		if (!email || !password || !name) {
            console.log(`All fields are required`);
            return res.status(400).json({ success: false, message: "All fields are required" });
		}

		const userAlreadyExists = await User.findOne({ email });

		if (userAlreadyExists) {
            console.log(`User already exists`);
			return res.status(400).json({ success: false, message: "User already exists" });
		}

		const hashedPassword = await bcryptjs.hash(password, 10); // 10 is the salt rounds

        const verificationToken = Math.floor(100000 + Math.random() * 900000).toString(); // 6-digit verification token


		const user = new User({
			email,
			password: hashedPassword,
			name,
			verificationToken,
			verificationTokenExpiresAt: Date.now() + 24 * 60 * 60 * 1000, // 24 hours
		});

		await user.save();

        await sendVerificationEmail(email, verificationToken);
        
		res.status(201).json({
			success: true,
			message: "User created successfully",
		});

    } catch (error) {
        console.log(error.message);
        res.status(500).json({ success: false, message: error.message });
    }
};

export const login = async (req, res) => {
    const { email, password } = req.body;
	try {
		const user = await User.findOne({ email });
		if (!user) {
			return res.status(400).json({ success: false, message: "Invalid credentials" });
		}
		const isPasswordValid = await bcryptjs.compare(password, user.password);
		if (!isPasswordValid) {
			return res.status(400).json({ success: false, message: "Invalid credentials" });
		}

        // check is user if verifyed
        if (!user.isVerified) {
            return res.status(400).json({ success: false, message: "Please verify your email" });
        }

		// generate token
		const token = jwt.sign({ userId: user._id }, process.env.JWT_SECRET, {
			expiresIn: "7d",
		});


		res.cookie("token", token, {
			httpOnly: true,
			secure: process.env.NODE_ENV === "production",
			sameSite: "strict",
			maxAge: 7 * 24 * 60 * 60 * 1000,

		});

		user.lastLogin = new Date();
		await user.save();

		res.status(200).json({
			success: true,
			message: "Logged in successfully",
		});

		console.log(`User ${user.name} logged in successfully`);
	} catch (error) {
		console.log("Error in login ", error);
		res.status(400).json({ success: false, message: error.message });
	}
};

export const logout = async (req, res) => {
    try {

        res.clearCookie("token");

        res.status(200).json({
            success: true,
            message: "Logged out successfully",
        });
        
    } catch (error) {
        console.log("Error in logout ", error);
        res.status(400).json({ success: false, message: error.message });        
    }
};

export const verifyEmail = async (req, res) => {
    const { code } = req.body;
	try {
		const user = await User.findOne({
			verificationToken: code,
			verificationTokenExpiresAt: { $gt: Date.now() },
		});

		if (!user) {
			return res.status(400).json({ success: false, message: "Invalid or expired verification code" });
		}

		user.isVerified = true;
		user.verificationToken = undefined;
		user.verificationTokenExpiresAt = undefined;
		await user.save();

		await sendWelcomeEmail(user.email, user.name);

		res.status(200).json({
			success: true,
			message: "Email verified successfully",
			user: {
				...user._doc,
				password: undefined,
			},
		});

		console.log(`User ${user.name} verified email successfully`);
	} catch (error) {
		console.log("error in verifyEmail ", error);
		res.status(500).json({ success: false, message: "Server error" });
	}
};

export const forgotPassword = async (req, res) => {
    const { email } = req.body;
	try {
		const user = await User.findOne({ email });

		if (!user) {
			return res.status(400).json({ success: false, message: "User not found" });
		}

		// Generate reset token
		const resetToken = crypto.randomBytes(20).toString("hex");
		const resetTokenExpiresAt = Date.now() + 1 * 60 * 60 * 1000; // 1 hour

		user.resetPasswordToken = resetToken;
		user.resetPasswordExpiresAt = resetTokenExpiresAt;

		await user.save();

		// send email
		await sendPasswordResetEmail(user.email, `${process.env.CLIENT_URL}/reset-password/${resetToken}`);

		console.log(`${process.env.CLIENT_URL}/reset-password/${resetToken}`);

		res.status(200).json({ success: true, message: "Password reset link sent to your email" });
	} catch (error) {
		console.log("Error in forgotPassword ", error);
		res.status(400).json({ success: false, message: error.message });
	}
};

export const resetPassword = async (req, res) => {
    try {
		const { token } = req.params;
		const { password } = req.body;

		const user = await User.findOne({
			resetPasswordToken: token,
			resetPasswordExpiresAt: { $gt: Date.now() },
		});

		if (!user) {
			return res.status(400).json({ success: false, message: "Invalid or expired reset token" });
		}

		// update password
		const hashedPassword = await bcryptjs.hash(password, 10);

		user.password = hashedPassword;
		user.resetPasswordToken = undefined;
		user.resetPasswordExpiresAt = undefined;
		await user.save();

		await sendResetSuccessEmail(user.email);

		res.status(200).json({ success: true, message: "Password reset successful" });
	} catch (error) {
		console.log("Error in resetPassword ", error);
		res.status(400).json({ success: false, message: error.message });
	}
};

export const updateProfile = async (req, res) => {
    const userID = req.userId;
    const { name, bio, currentPassword, newPassword, image } = req.body;

    try {
        const user = await User.findById(userID);
        if (!user) {
            return res.status(404).json({ message: "User  not found" });
        }


        // Check if the current password is correct
        if (currentPassword) {
            const isMatch = await bcryptjs.compare(currentPassword, user.password);
            if (!isMatch) {
                return res.status(400).json({ message: "Current password is incorrect" });
            }
        } else {
            return res.status(400).json({ message: "Current password is required" });
        }

        // check is user if verifyed
        if (!user.isVerified) {
            return res.status(400).json({ success: false, message: "Please verify your email" });
        }

        // Update user name
        user.name = name || user.name;

        // Update user bio
        user.bio = bio || user.bio;


        if (newPassword) {
            const hashedPassword = await bcryptjs.hash(newPassword, 10);
            user.password = hashedPassword || user.password; // Update the password
        }


        if (image) {
            // Delete the old image from Cloudinary if it exists
            if (user.image) {
                await cloudinary.uploader.destroy(user.image.split("/").pop().split(".")[0]);
            }

            // Upload the new image to Cloudinary
            const uploadedResponse = await cloudinary.uploader.upload(image);
            user.image = uploadedResponse.secure_url; // Update the image URL
        }

        await user.save();

        // Remove the password from the response for security
        user.password = null;

        // Send a success response
        res.status(200).json({ message: "User  updated successfully", user });

    } catch (error) {
        console.log("Error in updateUser  ", error);
        res.status(400).json({ message: error.message });
    }
};

export const deleteProfile = async (req, res) => {
    const userID = req.userId;
    try {
        const user = await User.findByIdAndDelete(userID);
        if (!user) {
            return res.status(404).json({ message: "User not found" });
        }

        if (user.image) {
            await cloudinary.uploader.destroy(user.image.split("/").pop().split(".")[0]);
        };

        res.clearCookie("token");

        console.log("User deleted successfully");
        res.status(200).json({ message: "User deleted successfully" });
    } catch (error) {

        console.log("Error in deleteUser ", error);
        res.status(400).json({ message: error.message });
    }
};