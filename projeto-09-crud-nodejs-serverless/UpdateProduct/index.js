const mongoose = require('mongoose');
const Product = require('../productsModel');

module.exports = async function (context, req) {
    mongoose.connect('mongodb+srv://userk:03086803@clusterk.lnn6e.mongodb.net/NodeAPIserverless',{
    })
    const product = new Product({
        name: req.body.name,
        description: req.body.description,
        price: req.body.price
    });
    await Product.where({_id: req.params.id}).updateOne(product)
        .then(
            product => context.res.status(200).json({Message:"Product updated", 
            url: req.originalUrl
        }))
    
        .catch(error => context.res.status(400).json({
            message: "error"
        }));
}