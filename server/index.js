const express = require('express');
const mongoose=require ('mongoose')
const authrouter = require('./routes/auth.js');
const adminRouter = require('./routes/admin.js');
const ProductRouter = require('./routes/product.js');
const PORT=3000;
const app=express();

const DB="mongodb+srv://ujj:mongo12@cluster0.gaa5fjg.mongodb.net/?retryWrites=true&w=majority"

//INIT
app.use(express.json());
app.use(authrouter);
app.use(adminRouter);
app.use(ProductRouter);
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
