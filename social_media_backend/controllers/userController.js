const User = require("../models/user");
const Post = require('../models/post');

exports.getLoggedInUser = async(req,res)=>{
    const loggedInUserId = req.user.id;

    try{
        const user = await User.findById(loggedInUserId).select('-password');
         if(!user){
            return res.status(404).json({message:'user not found'});
         }

         res.status(200).json(user);
    }catch(error){
        res.status(500).json({message:'Server Error', error});
    }
}

exports.getUsers = async(req, res) =>{
    try{
        const loggedInUserId = req.user.id;
        const user = await User.find({id:{loggedInUserId}}).select('-password');
         if(!user){
            return res.status(404).json({message:'user not found'});
         }
         res.status(200).json(user);
    }catch(error){
        res.status(500).json({message:'Server Error', error});
    }
}

exports.updateProfile = async(req, res) =>{
    try{
        const {bio, profilePicture, firstname, lastname} = req.body;
        const user = await User.findByIdAndUpdate(
            req.user.id,
            {bio, profilePicture, firstname, lastname},
            {new:true}
        );
        return json(user);

       }catch(error){
        res.status(500).json({message:'Server Error', error});
    }
}

exports.getProfile = async(req, res)=>{
    try{
        const user = await User.findById(req.user.id).populate('followers following', 'username').select('-password');
        if(!user){
           return res.status(404).json({message:'user not found'});
        }
        const posts = await Post.find({createdBy:req.user.id}).populate('createdBy', 'username email');
        res.status(200).json({user:user, posts:posts});
    }catch(error){
     res.status(500).json({message:'Server Error', error});
 }
}
exports.followUser = async(req, res)=>{
    try{
    const {userId, followId} = req.params;
    if(userId === followId){
        return res.status(400).json({error:'You cannot follow yourself'});
     }

     const user = await User.findById(userId);
     const followUser = await User.findById(followId);

     //Check if the user is already following the other user
     if(user.following.include(followId)){
        return res.status(400).json({error:'You are already following this user'});
     }
     user.following.push(followId);
     followUser.followers.push(userId);
     await user.save();
     await followUser.save();

     res.status(200).json({message:'Followed Successfully'});

     }catch(error){
     res.status(500).json({message:'Server Error', error});
 }
}

exports.unfollowUser = async(req, res)=>{
    try{
        const {userId, followId} = req.params;

        const user = await User.findById(userId);
        const followUser = await User.findById(followId);

         //Check if the user is already following the other user
     if(!user.following.include(followId)){
        return res.status(400).json({error:'You are already not following this user'});
     }
     //remove the following list and follower list
     user.following = user.following.filter(id=>id.toString() !== followId);
     followUser.followers =  followUser.followers.filter(id=>id.toString() !== userId);

     await user.save();
     await followUser.save();

     res.status(200).json({message:'Unfollowed Successfully'});

    }catch(error){
     res.status(500).json({message:'Server Error', error});
 }
}

exports.getFollowers = async(req, res)=>{
    try{
        if(!req.user || !req.user.id){
            return res.status(400).json({error:"user not Authenicated"});
        }
     const   user = await User.findById(req.user.id).populate('followers', 'username email').select('-password');
        if(!user){
            return res.status(404).json({message:'user not found'});
        }
        res.status(200).json({following:user.followers});
    }catch(error){
     res.status(500).json({message:'Server Error', error});
 }
}

exports.getFollowing = async(req, res)=>{
    try{
        if(!req.user || !req.user.id){
            return res.status(400).json({error:"user not Authenicated"});
        }
     const   user = await User.findById(req.user.id).populate('following', 'username email').select('-password');
        if(!user){
            return res.status(404).json({message:'user not found'});
        }
        res.status(200).json({following:user.following});
    }catch(error){
     res.status(500).json({message:'Server Error', error});
 }
}

exports.getPostByUser = async(req, res)=>{
    try{
        const posts = await Post.find({createdBy: req.user.id})
        .populate('likes', 'username')
        .sort({createdAt: -1});

        if(!posts){
            return res.status(404).json({message:'user not found'});
        }
        res.status(200).json(posts);
    }catch(error){
     res.status(500).json({message:'Server Error', error});
 }
}

exports.getUsersPost = async(req, res)=>{
    try{
        const { userId} = req.params
        const user = await User.findById(userId).select('-password');
        if(!user){
           return res.status(404).json({message:'user not found'});
        }
        const posts = await Post.find({createdBy:userId}).populate('createdBy', 'username email');
        res.status(200).json({user:user, posts:posts});
    }catch(error){
     res.status(500).json({message:'Server Error', error});
 }
}