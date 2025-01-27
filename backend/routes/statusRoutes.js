import express from 'express';

import jwtAuth from '../middleware/Auth.js';

import { createStatus, deleteStatus, getStatus, getStatusByUser } from '../controller/statusController.js';


const router = express.Router();

router.post('/', jwtAuth, createStatus);

router.get('/', jwtAuth, getStatus);

router.get('/:id', jwtAuth, getStatusByUser);

router.delete('/:id', jwtAuth, deleteStatus);

export default router;