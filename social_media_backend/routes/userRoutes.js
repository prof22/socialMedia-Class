const express = require('express');
const {getLoggedInUser, getUsers, updateProfile, getProfile, followUser, unfollowUser,getFollowers, getFollowing, getPostByUser, getUsersPost } = require("../controllers/userController");
const {  protect } = require('../middleware/middleware');

const userRouter = express.Router();

userRouter.get('/', protect, getUsers);
userRouter.put('/profile', protect, updateProfile);
userRouter.get('/loggedIn', protect, getLoggedInUser);
userRouter.get('/me/post', protect, getPostByUser);
userRouter.get('/user/:userId/post', protect, getUsersPost);
userRouter.get('/following', protect, getFollowing);
userRouter.get('/followers', protect, getFollowers);
userRouter.put('/follow/:userId/:followId', protect, followUser);
userRouter.put('/follow/:userId/:followId', protect, followUser);
userRouter.put('/unfollow/:userId/:followId', protect, unfollowUser);
userRouter.get('/profileDetails', protect, getProfile);

module.exports = userRouter;
