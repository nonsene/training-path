const mongoose = require('mongoose');
const Product = require('../productsModel');

module.exports = async function (context, req) {
    mongoose.connect('mongodb+srv://userk:03086803@clusterk.lnn6e.mongodb.net/NodeAPIserverless')
    await Product.findOneAndDelete(req.params.id)
        .then(
            product => context.res.status(200).json({
            message: "Product deleted",
            _id: product._id,
            name: product.name,
            description: product.description,
            price: product.price
        }))
    
        .catch(error => context.res.status(400).json({
            message: error
        }));
}