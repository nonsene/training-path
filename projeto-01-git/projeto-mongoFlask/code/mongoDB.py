from mongoengine import *
import requests
from time import sleep
class User(Document):
    user = StringField(required=True)
    repository = DictField()


username = input('Enter username:')
username = username.lower()

url = f'https://api.github.com/users/{username}/repos'
web_page = requests.get(url)
web_page_json = web_page.json()
status = web_page.status_code


connect(host='mongodb+srv://userk:03086803@clusterk.lnn6e.mongodb.net/MongoDBtraining?retryWrites=true&w=majority')


if status == 200:
    if User.objects(user=username).first() is None:
        print('\nValid user!\n\n...Creating entity...')
        sleep(2)
        dict1 = {}
        repositories = [a["name"] for a in web_page_json]

        for i in range(len(repositories)):
            dict1.update({f"reponame_{i}": repositories[i]})

        user = User(user=username, repository=dict1).save()
        print('\nDone!')
    else:
        print('\nValid user!\n\n...Creating entity...')
        obj = User.objects(user=username).first()
        obj.delete()
        dict1 = {}
        repositories = [a["name"] for a in web_page_json]

        for i in range(len(repositories)):
            dict1.update({f"reponame_{i}": repositories[i]})

        user = User(user=username, repository=dict1).save()
        sleep(2)
        print('\nDone!')
else:
    print('User not found!')