const express = require("express");
const connectDB = require("./config/db");
const route = require('./routes/route');
const postRouter = require("./routes/postRoute");
const commentRouter = require("./routes/commentRoutes");

//define the port number the server will listen to

const PORT = 3000;

//create an instance of express application which is our starting point

const app = express();
connectDB();
app.use(express.json());
app.use('/api/auth', route);
app.use('/api/posts', postRouter);
app.use('/api/comment', commentRouter);

app.listen(PORT, "0.0.0.0", function(){
    console.log(`Server is running on port ${PORT}`);
});