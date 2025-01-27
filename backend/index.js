import express from "express";
import dotenv from "dotenv";
import cookieParser from "cookie-parser";


import connectDB from "./config/connectDB.js";

import authRoutes from "./routes/authRoutes.js";
import userRoutes from "./routes/userRoutes.js";
import statusRoutes from "./routes/statusRoutes.js";

dotenv.config();

const app = express();

const PORT = process.env.PORT || 5000;

app.use(express.json());
app.use(cookieParser());

app.use("/api/auth", authRoutes);
app.use("/api/user", userRoutes);
app.use("/api/status", statusRoutes);


app.listen(PORT, () => {
    console.log("server running on localhost:" + PORT);
    connectDB();
});