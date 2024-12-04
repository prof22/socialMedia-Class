const express = require('express');
const {addComment, getCommentsbyPost, toggleCommentLikes }  = require('../controllers/commentController');
const { protect } = require('../middleware/middleware');
const commentRouter = express.Router();

commentRouter.post('/', protect, addComment);
commentRouter.put('/:id/like', protect,  toggleCommentLikes);
commentRouter.get('/:postId', protect, getCommentsbyPost);

module.exports = commentRouter;