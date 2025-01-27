import express from "express";

import { deleteProfile, updateProfile, followUser, unFollowUser, fetchAllUser, profile } from "../controller/userController.js";

import jwtAuth from "../middleware/Auth.js";

const router = express.Router();

router.post("/follow/:id" , jwtAuth, followUser); // follow user
router.post("/unfollow/:id" , jwtAuth, unFollowUser); // unfollow user

router.get("/me", jwtAuth, profile); // fetch user profile
router.get("/", jwtAuth, fetchAllUser); // fetch all the user

router.put("/update-profile", jwtAuth, updateProfile); // update profiel
router.delete("/delete-account", jwtAuth, deleteProfile); // delete profile

export default router;