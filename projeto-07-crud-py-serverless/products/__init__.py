import logging
from flask import Flask, jsonify, request
from flask_mongoengine import MongoEngine
import azure.functions as func

app = Flask(__name__)

app.config['JSONIFY_PRETTYPRINT_REGULAR'] = True
app.config['JSON_SORT_KEYS'] = False

app.config['MONGODB_SETTINGS'] = {"host": "mongodb+srv://userk:03086803@clusterk.lnn6e.mongodb.net/"
                                          "ProductsAPI?retryWrites=true&w=majority"}

db = MongoEngine(app)


class Products(db.Document):
    id = db.IntField(primary_key=True)
    name = db.StringField(required=True)
    description = db.DictField()
    price = db.FloatField()


@app.route('/products', methods=['GET'])
def get_product():
    products = Products.objects()
    if products.first() is None:
        return jsonify({'Error': 'No products found on DB.'}), 404
    else:
        result = [{"ProductID": product.id,
                   "Name": product.name,
                   "Description": product.description,
                   "Price": product.price} for product in products]
        return jsonify(result)


@app.route('/products/id', methods=['GET'])
def get_id_list():
    products = Products.objects()
    result = [{"Name": product.name,
               "ID": product.id} for product in products]
    return jsonify(result)


@app.route('/products/<id>', methods=['GET'])
def get_specific_product(id):
    specific_product = Products.objects(id=id)
    if specific_product.first() is None:
        return jsonify({"Error": "Product does not exist"})
    else:
        result = [{"Name": specific_product.first().name,
                   "Description": specific_product.first().description,
                   "Price": specific_product.first().price}]
        return jsonify(result)


@app.route('/products', methods=['POST'])
def insert_product():
    name = request.json['name']
    id = request.json['id']
    description = request.json['description']
    price = request.json['price']
    if Products.objects(id=id).first() is None:
        products = Products(name=name, id=id, description=description, price=price)
        products.save()
        return jsonify({"Status": {'Successful': f'ProductID {id} was successfully added!'}})
    else:
        return jsonify({"Status": {'Error': 'ProductID already exists.'}})


@app.route('/products/<id>', methods=['PUT'])
def update_product(id):
    if Products.objects(id=id):
        name = request.json['name']
        description = request.json['description']
        price = request.json['price']
        products = Products.objects(id=id)
        products.update(name=name, description=description, price=price)
        return jsonify({"Status": {'Successful': f'ProductID {id} was successfully updated!'}})
    else:
        return jsonify({"Status": {'Error': 'Insert a valid ProductID.'}})


@app.route('/products/<id>', methods=['DELETE'])
def delete_product(id):
    if Products.objects(id=id).first():
        products = Products.objects(id=id)
        products.delete()
        return jsonify({"Status": {'Successful': f'ProductID {id} was successfully deleted!'}})
    else:
        return jsonify({"Status": {'Error': 'Insert a valid ProductID.'}})


@app.route('/products', methods=['DELETE'])
def delete_product_error():
    return jsonify({'Error': 'Insert /id on the URL'})


def main(req: func.HttpRequest) -> func.HttpResponse:
    url = req.params['url']
    with app.test_client() as app1:
        if req.method == 'GET':
            resposta = app1.get(url).data
            logging.info('Python HTTP trigger GET')
        elif req.method == 'POST':
            resposta = app1.post(url, json=req.get_json()).data
            logging.info('Python HTTP trigger POST')
        elif req.method == 'PUT':
            resposta = app1.put(url, json=req.get_json()).data
            logging.info('Python HTTP trigger PUT')
        elif req.method == 'DELETE':
            resposta = app1.delete(url).data
            logging.info('Python HTTP trigger DELETE')
        else:
            pass

    return func.HttpResponse(resposta.decode())
