const mongoose = require('mongoose');
const Products = require('../productsModel');

module.exports = async function (context, req) {
    mongoose.connect('mongodb+srv://userk:03086803@clusterk.lnn6e.mongodb.net/NodeAPIserverless')
    await Products.findById(req.params.id).exec().then(
        prod => context.res.status(200).json({
            id: prod._id,
            name: prod.name,
            price: prod.price,
            description: prod.description

    })).catch(error => context.res.status(400).json({
        message: error
    }));
}