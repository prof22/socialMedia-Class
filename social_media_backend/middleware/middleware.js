const jwt = require("jsonwebtoken");
const User = require('../models/user');
const donevn = require("dotenv");
donevn.config();

const protect = async(req, res, next) =>{
    let token;

    //check if token is provided in the header
    if(req.headers.authorization && req.headers.authorization.startsWith("Bearer")){
        try{
            token = req.headers.authorization.split(' ')[1];
            //Decode the token and get user ID;
            const decoded = jwt.verify(token, process.env.JWT_SECRET);
            req.user = await User.findById(decoded.id).select("-password");
            next() // pass control to the next middleware
        }catch (error){
            res.status(401).json({message: "You are not authorized"});
        }
    }
    if(!token){
        res.status(401).json({message: "You are not authorized, invalid user"});
    }
}

module.exports = { protect }