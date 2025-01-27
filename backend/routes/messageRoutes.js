import express from "express";

import jwtAuth from "../middleware/Auth.js";

import { deleteMessage, getMessages, sendMessage } from "../controller/messageController.js";

const router = express.Router();

router.post("/:id", jwtAuth, sendMessage);

router.get("/:id", jwtAuth, getMessages);

router.delete("/:id", jwtAuth, deleteMessage);

export default router;