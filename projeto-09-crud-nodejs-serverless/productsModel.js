const mongoose = require('mongoose');

const productSchema = mongoose.Schema({
    _id: mongoose.Types.ObjectId,
    name: String,
    price: Number,
    description: {}
});

module.exports = mongoose.model('Products', productSchema, 'products');