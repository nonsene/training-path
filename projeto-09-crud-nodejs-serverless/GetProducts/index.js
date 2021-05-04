const mongoose = require('mongoose');
const Products = require('../productsModel');

module.exports = async function (context, req) {
    mongoose.connect('mongodb+srv://userk:03086803@clusterk.lnn6e.mongodb.net/NodeAPIserverless')
    await Products.find()
    .select('_id name price description').exec()
    .then(products => context.res.json({products}))
    .catch(err => context.res.status(400).json({message: err}));
}