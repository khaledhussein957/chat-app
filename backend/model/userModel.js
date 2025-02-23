import mongoose from "mongoose";

const userSchema = new mongoose.Schema(
	{
		email: {
			type: String,
			required: true,
			unique: true,
		},
		password: {
			type: String,
			required: true,
		},
		name: {
			type: String,
			required: true,
		},
		image: {
			type: String,
			default: "",
		},
		bio: {
			type: String,
			default: "",
		},
		following: [
			{
				type: mongoose.Schema.Types.ObjectId,
				ref: 'User'
			}
		],
		lastLogin: {
			type: Date,
			default: Date.now,
		},
		// isVerified: {
		// 	type: Boolean,
		// 	default: false,
		// },
		// resetPasswordToken: String,
		// resetPasswordExpiresAt: Date,
		// verificationToken: String,
		// verificationTokenExpiresAt: Date,
	},
	{ timestamps: true }
);

export const User = mongoose.model("User", userSchema);