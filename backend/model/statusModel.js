import mongoose from "mongoose";

const statusSchema = new mongoose.Schema({
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
    },
    content: {
        type: String,
        required: true,
    },
    image: {
        type: String,
    },
    createdAt: {
        type: Date,
        default: Date.now,
    },
    expiresAt: {
        type: Date,
        default: Date.now() + 24 * 60 * 60 * 1000, // expires in 24 hours
    },
});

const Status = mongoose.model("Status", statusSchema);

export default Status;