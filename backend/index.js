import express from "express";
import dotenv from "dotenv";

import connectDB from "./config/connectDB.js";

import userRoutes from "./routes/userRoutes.js";
import cookieParser from "cookie-parser";

dotenv.config();

const app = express();

const PORT = process.env.PORT || 5000;

app.use(express.json());
app.use(cookieParser());

app.use("/api/auth", userRoutes);


app.listen(PORT, () => {
    console.log("server running on localhost:" + PORT);
    connectDB();
});