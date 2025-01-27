import mongoose from "mongoose";

const groupMessageSchema = mongoose.Schema({
    groupId: {
        type: mongoose.Schema.Types.ObjectId,
        required: true,
        ref: "Group"
    },
    sender: {
        type: mongoose.Schema.Types.ObjectId,
        required: true,
        ref: "User"
    },
    message: {
        type: String,
        required: true
    },
}, { timestamps: true });

const GroupMessage = mongoose.model("GroupMessage", groupMessageSchema);

export default GroupMessage;