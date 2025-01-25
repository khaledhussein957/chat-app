import express from "express";

import { deleteProfile, forgotPassword, login, logout, resetPassword, signup, updateProfile, verifyEmail } from "../controller/userController.js";

import jwtAuth from "../middleware/Auth.js";

const router = express.Router();

router.post("/signup", signup);
router.post("/login", login);
router.post("/logout", jwtAuth, logout);

router.post("/verify-email", verifyEmail);
router.post("/forgot-password", forgotPassword);

router.post("/reset-password/:token", resetPassword);

router.put("/update-profile", jwtAuth, updateProfile);
router.delete("/delete-account", jwtAuth, deleteProfile);

export default router;