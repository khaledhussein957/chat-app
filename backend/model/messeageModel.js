import mongoose from "mongoose"

const messageSchema = mongoose.Schema({
    sender: {
        type: mongoose.Schema.Types.ObjectId,
        required: true,
        ref: "User"
    },
    receiver: {
        type: mongoose.Schema.Types.ObjectId,
        required: true,
        ref: "User"
    },
    content: {
        type: String,
        required: true
    },
    chat: {
        type: mongoose.Schema.Types.ObjectId,
        required: true,
        ref: "Chat"
    },
}, 
{
    timestamps: true
});

const Message = mongoose.model("Message", messageSchema);

export default Message;