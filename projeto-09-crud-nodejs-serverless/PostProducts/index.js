const mongoose = require('mongoose');
const Product = require('../productsModel');

module.exports = async function (context, req, res) {
    mongoose.connect('mongodb+srv://userk:03086803@clusterk.lnn6e.mongodb.net/NodeAPIserverless',{
    })
    const product = new Product({
        _id: new mongoose.Types.ObjectId(),
        name: req.body.name,
        description: req.body.description,
        price: req.body.price
    });
    await product.save()
        .then(
            product => context.res.status(200).json({
            _id: product._id,
            name: product.name,
            description: product.description,
            price: product.price,
            url: req.originalUrl 
        }))
    
        .catch(error => context.res.status(400).json({
            message: "error"
        }));
}