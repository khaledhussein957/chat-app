import Group from "../model/groupModel.js";
import groupMessage from "../model/groupMessageModel.js";

import { getReceiverSocketId, io } from "../socket/socket.js";

export const createGroup = async (req, res) => {
    try {
        const user = req.userId;
        const { name, description, members } = req.body;

        if (!name || !members) {
            return res.status(400).json({ message: "Please fill all fields" });
        }

        // check if members less than 2 users
        if (!Array.isArray(members) || members.length < 2) {
            return res.status(400).json({ message: "Please add at least 2 members" });
        }

        if (!user) {
            return res.status(400).json({ message: "Invalid admin user" });
        }


        const newGroup = new Group({
            name,
            description,
            members,
            admin: user
        });

        await newGroup.save();

        return res.status(201).json({ message: "Group created successfully" });

    } catch (error) {
        console.log("Error in createGroup: ", error.message);
        return res.status(500).json({ message: "Error creating group" });
    }
};

export const getGroups = async (req, res) => {
    try {

        const user = req.userId;

        const groups = await Group.find({ members: user }).populate("members", "name email");

        return res.status(200).json({ groups });


    } catch (error) {
        console.log("error in getGroups", error.members);
        return res.status(400).json({ message: "Error getting groups" });

    }
};

export const updateGroup = async (req, res) => {
    try {
        const { name, description, membersToAdd, membersToRemove } = req.body;
        const group = await Group.findById(req.params.id);

        if (!group) {
            return res.status(404).json({ message: "Group not found" });
        }

        // Add members to the group and only user can add members
        if (membersToAdd && membersToAdd.length > 0 && group.admin.toString() === req.userId) {
            group.members.addToSet(...membersToAdd);
        } else {
            return res.status(403).json({ message: "You are not authorized to add members to this group" });
        }

        // Remove members from the group
        if (membersToRemove && membersToRemove.length > 0 && group.admin.toString() === req.userId) {
            group.members.pull(...membersToRemove);
        } else {
            return res.status(403).json({ message: "You are not authorized to remove members from this group" });
        }

        // Update group name and description
        group.name = name || group.name;
        group.description = description || group.description;

        await group.save();

        return res.status(200).json({ message: "Group updated successfully" });

    } catch (error) {
        console.log("Error in updateGroup: ", error.message);
        return res.status(400).json({ message: "Error updating group" });
    }
};

export const deleteGroup = async (req, res) => {
    try {
        const user = req.userId;
        const group = await Group.findById(req.params.id);

        if (!group) {
            return res.status(404).json({ message: "Group not found" });
        }

        // Check if the user is authorized to delete the group
        if (group.admin.toString() !== user) {
            return res.status(403).json({ message: "You are not authorized to delete this group" });
        }

        await Group.findByIdAndDelete(req.params.id);

        return res.status(200).json({ message: "Group deleted successfully" });

    } catch (error) {
        console.log("Error in deleteGroup: ", error.message);
        return res.status(400).json({ message: "Error deleting group" });
    }
};

export const sendMessage = async (req, res) => {
    try {
        const user = req.userId;
        const groupId = req.params.id;
        const { message } = req.body;

        if (!message) {
            return res.status(400).json({ message: "Please enter a message" });
        }

        const group = await Group.findById(groupId).populate("members", "name email");

        if (!group) {
            return res.status(404).json({ message: "Group not found" });
        }

        // Check if the user is a member of the group
        if (!group.members.some(member => member._id.toString() === user)) {
            return res.status(403).json({ message: "You are not a member of this group" });
        }

        const newMessage = new groupMessage({
            groupId: group,
            sender: user,
            message,
        });

        await newMessage.save();

        return res.status(201).json({ message: "Message sent successfully" });
    } catch (error) {
        console.log("Error in sendMessage: ", error.message);
        return res.status(400).json({ message: "Error sending message" });
    }
};

export const getGroupMessages = async (req, res) => {
    try {
        const user = req.userId;
        const groupId = req.params.id;

        const group = await Group.findById(groupId).populate("members", "name email");

        if (!group) {
            return res.status(404).json({ message: "Group not found" });
        }

        // Check if the user is a member of the group
        if (!group.members.some(member => member._id.toString() === user)) {
            return res.status(403).json({ message: "You are not a member of this group" });
        }

        const messages = await groupMessage.find({ groupId }).populate("sender", "name email");

        return res.status(200).json({ messages });
    } catch (error) {
        console.log("Error in getGroupMessages: ", error.message);
        return res.status(400).json({ message: "Error getting messages" });
    }
}