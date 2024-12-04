const mongoose = require("mongoose");
const donevn = require("dotenv");
donevn.config();

const connectDB = async() =>{
    try{
        await mongoose.connect(process.env.MONGO_URL, {});
        console.log('Mongoose Db connected successfully');
    }catch (error){
        console.log('Mongoose connection failed:', error.message);
        process.exit(1);
    }
}
module.exports = connectDB;
