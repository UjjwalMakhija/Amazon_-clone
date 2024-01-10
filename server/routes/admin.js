const express = require('express');
const  adminRouter = express.Router();

// const bcryptjs=require('bcryptjs');
// const jwt =require('jsonwebtoken');
const admin = require('../middlewares/admin');
const {Product } = require('../models/product');
const Order = require('../models/order');
const authrouter = require('./auth');

adminRouter.post('/admin/add-product',admin ,async(req,res)=>{
    try {
        const { name, description, images, quantity, price, category } = req.body;
        let product = new Product({
          name,
          description,
          images,
          quantity,
          price,
          category,
        });
        product = await product.save();
        res.json(product);
      } catch (e) {
        res.status(500).json({ error: e.message });
      }
    

})

adminRouter.get("/admin/get-products", admin, async (req, res) => {
  try {
    const products = await Product.find({});
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});
adminRouter.get("/admin/get-orders", admin, async (req, res) => {
  try {
    const orders = await Order.find({});
    res.json(orders);
  } catch (e) { 
    res.status(500).json({ error: e.message });
  }
});



authrouter.post('/admin/delete-product',admin,async(req,res)=>{
  try{
    const {id} = req.body;
    let product = await Product.findByIdAndDelete(id);
    res.json(product);
  }
  catch(e){
    res.status(500).json({error:e.message})
  }
})
authrouter.post('/admin/change-order-status',admin,async(req,res)=>{
  try{
    const {id,status} = req.body;
    let order = await Order.findById(id);
    order.status =status;
    order = await order.save();
    res.json(order);
  }
  catch(e){
    res.status(500).json({error:e.message})
  }
})

//analytics
adminRouter.get("/admin/analytics", admin, async (req, res) => {
  try {
    const orders = await Order.find({});
    let totalearnings =0;
    for(let i =0;i<orders.length;i++){
      for(let j =0;j<orders[i].products.length;j++){
        totalearnings+=orders[i].products[j].quantity*orders[i].products[j].product.price;
      }

    }

    let mobileearnings = await fetchCategorywiseProduct('Mobiles');
    let Essentialsearnings = await fetchCategorywiseProduct('Essentials');
    let Appliancesarnings = await fetchCategorywiseProduct('Appliancess');
    let Booksearnings = await fetchCategorywiseProduct('Books');
    let Fashionearnings = await fetchCategorywiseProduct('Fashion');
    let earnings ={
      totalearnings,
      mobileearnings,
      Essentialsearnings,
      Appliancesarnings,
      Booksearnings,
      Fashionearnings,
    }
    res.json(earnings);
  } catch (e) {
    console.log(e);
    res.status(500).json({ error: e.message });
  }
});

 async function fetchCategorywiseProduct(category){
  let earnings =0;
  let categoryorder = await Order.find({
    'products.product.category':category,
  });
  for(let i =0;i<categoryorder.length;i++){
    for(let j =0;j<categoryorder[i].products.length;j++){
      earnings+=categoryorder[i].products[j].quantity*categoryorder[i].products[j].product.price;
    }

  }
  return earnings;
 }
module.exports=adminRouter