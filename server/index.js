const express = require('express');
const mongoose=require ('mongoose')
const authrouter = require('./routes/auth.js');
const adminRouter = require('./routes/admin.js');
const ProductRouter = require('./routes/product.js');
const userRouter = require('./routes/user.js');
const PORT=3000;
const app=express();

const DB=""

//INIT
app.use(express.json());
app.use(authrouter);
app.use(adminRouter);
app.use(ProductRouter);
app.use(userRouter);
mongoose
.connect(DB)
.then(()=>{
    console.log('Succesfully connected')
})
.catch((e)=>{
    console.log(e);
})
app.listen(PORT,"0.0.0.0",()=>{
    console.log(`Connected port ${PORT} `);
})
