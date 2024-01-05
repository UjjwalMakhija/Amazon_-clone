const express = require('express')

const User= require('../models/user')
const bcryptjs=require('bcryptjs');
const jwt =require('jsonwebtoken');

//middleware
const auth = require("../middlewares/auth");
const authrouter = express.Router();
authrouter.post('/api/signup',async (req,res)=>{
   try{
      const {name,email,password}=req.body;
      const existing =await User.findOne({email});
      if(existing){
         return res.status(400).json({msg:"User already exists"});
      }
     const hashedpass= await bcryptjs.hash(password,8);
      let  user = new User({
        email,
        password:hashedpass,
        name,
     })
     user=await user.save();
     res.json(user);
     

   }
   catch(e){
      res.status(500).json({error:e.message})
      
      
   }

})

//signin

authrouter.post('/api/signin',async (req,res)=>{

   try{
      const {email,password}=req.body;
      const existing1 =await User.findOne({email});
      if(!existing1){
         return res.status(400).json({msg:"User with this Email does not exist "})
      }
     const ismatch= await bcryptjs.compare(password,existing1.password);
     if(!ismatch){
      return res.status(400).json({msg:"Incorrect password"})

     }
     const token = jwt.sign({id:existing1._id},"passwordkey");
     res.json({token,...existing1._doc})
   }
   catch(e){
      res.status(500).json({error:e.message})
   }
})
authrouter.post('/tokenIsValid',async (req,res)=>{

   try{
     
    const token =req.header('x-auth-token');
    if(!token){
      return res.json(false);
    }
    const verify = jwt.verify(token,'passwordkey')
    if(!verify) return res.json(false);
    const user =await User.findById(verify.id);
    if(!user) return res.json(false);
    return res.json(true); 
   }
   catch(e){
      res.status(500).json({error:e.message})
   }
})

authrouter.get('/',auth,async(req,res)=>{
   const user = await User.findById(req.user);
   res.json({...user._doc, token :req.token});
})
module.exports = authrouter  