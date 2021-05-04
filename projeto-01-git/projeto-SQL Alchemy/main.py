from datetime import date

from alchemyclass import User
from orm import Session, engine, Base
import requests
from time import sleep

Base.metadata.create_all(engine)

session = Session()

username = input('Enter a username to search: ')

url = f'https://api.github.com/users/{username}/repos'

web_page = requests.get(url)
web_page_json = web_page.json()

status = web_page.status_code

query = session.query(User).filter(User.username == username)

if status == 200:
    if query.first() is None:
        print('\n\nUser not exists... Creating a new one!\n\n')
        sleep(2)
        for i in web_page_json:
            print(i['name'])
            insert_ = User(username, i['name'], date.today())
            session.add(insert_)
        print('\nAdding this repositories ^')
        sleep(2)
        session.commit()
    else:
        print("\n\nUser already exists... Modifying the old one if it's the case!\n\n")
        sleep(2)
        query.delete()
        for i in web_page_json:
            print(i['name'])
            insert_ = User(username, i['name'], date.today())
            session.add(insert_)
        print('\nAdding this repositories ^')
        session.commit()
        sleep(2)
