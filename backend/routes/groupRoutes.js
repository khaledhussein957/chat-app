import express from 'express';

import jwtAuth from '../middleware/Auth.js';

import { createGroup, deleteGroup, getGroups, updateGroup } from '../controller/groupController.js';

const router = express.Router();

router.post('/', jwtAuth, createGroup); // create a group

router.get('/', jwtAuth, getGroups); // get all groups

router.put('/update/:id', jwtAuth, updateGroup); // update a group

router.delete('/delete/:id', jwtAuth, deleteGroup); // delete a group



export default router;