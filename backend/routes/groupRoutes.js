import express from 'express';

import jwtAuth from '../middleware/Auth.js';

import { createGroup, deleteGroup, getGroupMessages, getGroups, sendMessage, updateGroup } from '../controller/groupController.js';

const router = express.Router();

router.post('/', jwtAuth, createGroup); // create a group

router.post('/:id', jwtAuth, sendMessage); // send message to a group

router.get('/', jwtAuth, getGroups); // get all groups

router.get('/:id', jwtAuth, getGroupMessages); // getGroupMessages

router.put('/update/:id', jwtAuth, updateGroup); // update a group

router.delete('/delete/:id', jwtAuth, deleteGroup); // delete a group



export default router;