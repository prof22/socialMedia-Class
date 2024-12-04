const Post = require("../models/post");


//Create a new post with image urls

exports.createPost = async(req, res) =>{
    try{
        const { content, images} = req.body; //expect images to be an array of Urls
        const createdBy = req.user.id // auth users

        //Create new post with content  and image urls and user id

        const newPost = new Post({content, images,createdBy});
        await newPost.save();
        res.status(201).json(newPost);
    }catch(error){
        res.status(500).json({message:error.message});
    }
}

//Get all Post

exports.getAllPost =async(req, res) =>{
    try{    
        const posts = await Post.find().populate('createdBy', 'username email');
        res.status(200).json({posts:posts});
    }catch(error){
        res.status(500).json({message:error.message});
    }
}