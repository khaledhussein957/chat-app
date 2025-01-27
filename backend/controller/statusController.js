import Status from "../model/statusModel.js";

import cloudinary from "../config/cloudinary.js";

export const createStatus = async (req, res) => {
    try {

        const user = req.userId;
        if (!user) return res.status(400).json({ message: "User not found" });

        const { content, image } = req.body;
        if (!content) return res.status(400).json({ message: "Content is required" });

        // check if user uploaded an image
        let imageUrl = "";
        if (image) {
            const result = await cloudinary.uploader.upload(image);
            imageUrl = result.secure_url;
        }

        const newStatus = new Status({
            user,
            content,
            image: imageUrl || user.image,
        });

        await newStatus.save();

        res.status(201).json({ message: "Status created successfully" });
 
    } catch (error) {
        console.log("Error in createStatus: ", error.message);
        res.status(500).json({ message: error.message });        
    }
};

export const getStatus = async (req, res) => {
    try {
        const user = req.userId;
        if (!user) return res.status(400).json({ message: "User not found" });

        const statuses = await Status.find({ user: user._id }).sort({ createdAt: -1 });

        if (!statuses) return res.status(404).json({ message: "Status not found" });

        res.status(200).json({ statuses });
    } catch (error) {
        console.log("Error in getStatus: ", error.message);
        res.status(500).json({ message: error.message });
    }
};

export const getStatusByUser = async (req, res) => {
    try {
        const { id } = req.params;

        const statuses = await Status.find({ user: id }).sort({ createdAt: -1 });

        if (!statuses) return res.status(404).json({ message: "Status not found" });

        res.status(200).json({ statuses });
    } catch (error) {
        console.log("Error in getStatusByUser: ", error.message);
        res.status(500).json({ message: error.message });
    }
};

export const deleteStatus = async (req, res) => {
    try {
        const { id } = req.params;
        const user = req.userId;
        if (!user) return res.status(400).json({ message: "User not found" });

        // delete selected status
        const delStatus = await Status.findByIdAndDelete(id);

        // delete from cloudinary
        if (delStatus.image) {
            await cloudinary.uploader.destroy(delStatus.image.split("/").pop().split(".")[0]);
        }

        if (!delStatus) return res.status(404).json({ message: "Status not found" });

        res.status(200).json({ message: "Status deleted successfully" });
    } catch (error) {
        console.log("Error in deleteStatus: ", error.message);
        res.status(500).json({ message: error.message });
    }
};