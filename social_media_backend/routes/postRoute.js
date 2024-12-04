const express = require('express');
const {createPost, getAllPost } = require("../controllers/postController");
const {  protect } = require('../middleware/middleware');

const postRouter = express.Router();

//Only authenticated user can create post
postRouter.post('/', protect, createPost);
postRouter.get('/', protect, getAllPost);




module.exports = postRouter;