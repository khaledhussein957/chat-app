import Conversation from "../model/conversationModel.js";
import Message from "../model/messeageModel.js";

import { getReceiverSocketId, io } from "../socket/socket.js";

export const sendMessage = async (req, res) => {
    try {

        const user = req.userId;
        const receiverId = req.params.id;

        const { content } = req.body;
        if (!content) {
            return res.status(400).json({ message: "Content is required" });
        }

        let conversation = await Conversation.findOne({
            participants: { $all: [user._id, receiverId] },
        });

        if (!conversation) {
            conversation = await Conversation.create({
                participants: [user._id, receiverId],
            });
        }

        const newMessage = new Message({
            sender: user,
            receiver: receiverId,
            content,
            chat: conversation._id,
        });

        await newMessage.save();
        
        conversation.messages.push(newMessage._id);
        await conversation.save();

        // SOCKET IO FUNCTIONALITY WILL GO HERE
        const receiverSocketId = getReceiverSocketId(receiverId);
        if (receiverSocketId) {
            // io.to(<socket_id>).emit() used to send events to specific client
            io.to(receiverSocketId).emit("newMessage", newMessage);
        }

        res.status(201).json(newMessage);
    } catch (error) {
        console.log("Error in sendMessage", error.message);
        res.status(500).json({ message: "Internal server error" });
    }
};

export const getMessages = async (req, res) => {
    try {
        const user = req.userId;
        const receiverId = req.params.id;

        const conversation = await Conversation.findOne({
            participants: { $all: [user._id, receiverId] },
        }).populate({ path: "messages", populate: { path: "sender" } });

        if (!conversation) {
            return res.status(200).json({ messages: [] });
        }

        res.status(200).json(conversation.messages);
    } catch (error) {
        console.log("Error in getMessages", error.message);
        res.status(500).json({ message: "Internal server error" });
    }
};

export const deleteMessage = async (req, res) => {
    try {
        const messageId = req.params.id;

        const message = await Message.findByIdAndDelete(messageId);

        if (!message) {
            return res.status(404).json({ message: "Message not found" });
        }

        // also delete the message from conversation
        const conversation = await Conversation.findByIdAndDelete(message.chat);
        conversation.messages = conversation.messages.filter(
            (msg) => msg.toString() !== messageId
        );

        res.status(200).json({ message: "Message deleted successfully" });
    } catch (error) {
        console.log("Error in deleteMessage", error.message);
        res.status(500).json({ message: "Internal server error" });
    }
};