const User = require("../models/user");
const jwt = require('jsonwebtoken');
const donevn = require("dotenv");
donevn.config();

//Generate JWT Token
const generateToken = (id) =>{
    return jwt.sign({id}, process.env.JWT_SECRET, {expiresIn:'30d'});
}

//Register a new user

exports.registerUser = async(req, res) =>{
    const {username, email, password} = req.body;
    try{
        const userExist = await User.findOne({ email });
        if(userExist){
            return res.status(400).json({message:"User already exists"});
        }
        //Create new users
         await User.create({ username, email, password});
        res.status(201).json({
            message:'Registration successful, please login to account'
        });

    }catch(error){
        res.status(500).json( {message:error.message} )
    }
}

exports.loginUser = async(req, res) =>{
    const { email, password } = req.body;
    try{
        const user = await User.findOne( {email} );
        if(user && (await user.matchPassword(password))){
            res.status(200).json({
                _id:user._id,
                username:user.username,
                email:user.email,
                token:generateToken(user._id)
            });
        }else{
            res.status(401).json({ message:'Invalid email or password'});
        }
    }catch(error){
        res.status(500).json({ message:error.message})
    }
}