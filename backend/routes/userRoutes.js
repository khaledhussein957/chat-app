import express from "express";

import { deleteProfile, forgotPassword, login, logout, resetPassword, signup, updateProfile, verifyEmail } from "../controller/userController.js";

import jwtAuth from "../middleware/Auth.js";

const router = express.Router();

router.put("/update-profile", jwtAuth, updateProfile);
router.delete("/delete-account", jwtAuth, deleteProfile);

export default router;