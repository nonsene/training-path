from flask import Flask, jsonify
from flask_mongoengine import MongoEngine
# Init app
app = Flask(__name__)

# App config
app.config['JSONIFY_PRETTYPRINT_REGULAR'] = True
app.config['JSON_SORT_KEYS'] = False
app.config['MONGODB_SETTINGS'] = {"host": "mongodb+srv://userk:03086803@clusterk.lnn6e.mongodb.net/"
                                          "MongoDBtraining?retryWrites=true&w=majority"}
db = MongoEngine(app)


class User(db.Document):
    user = db.StringField(required=True)
    repository = db.DictField()


@app.route('/user', methods=['GET'])
def get_user():
    user = User.objects()
    return jsonify(user)


@app.route('/user/<username>', methods=['GET'])
def get_specific_user(username):
    if User.objects(user=username):
        specific_user = User.objects(user=username)
        return jsonify(specific_user)
    else:
        return 'User does not exist in the DB. Use user/username with a correct username to proceed'


if __name__ == "__main__":
    app.run(debug=False)
