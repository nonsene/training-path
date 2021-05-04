import requests
from function import insert_values, check_username, delete_values, select
from time import sleep


username = input('Enter username: ')

url = f'https://api.github.com/users/{username}/repos'

web_page = requests.get(url)
web_page_json = web_page.json()

status = web_page.status_code
consult = check_username(username)

if status == 200:
    if consult[0] is True:
        print('\nUser found!\n\n\nSaving the new list of repositories.\n\n')
        delete_values(username)
        print("Here's a list of repositories that you're saving in your DB:\n\n")
        for i in web_page_json:
            insert_values(username, i['name'])
            print('->' + i['name'])
    else:
        print('\nUser not found!\n\n\nCreating the new list of repositories.\n\n')
        print("Here's a list of repositories that you're saving in your DB:\n\n")
        for i in web_page_json:
            insert_values(username, i['name'])
            print('->' + i['name'])

    count = 0

    while count == 0:
        ans = input('\n\nDo you want to show your repositories list saved on your DB? (y/n)')
        if ans.lower() == 'y':
            lista = select()
            for r in lista:
                print(f'{r[0]}:{r[1]}')
            count = 1
            print('\n\nThanks for using!\n\n...Shuting down...')
            sleep(2)

        elif ans.lower() == 'n':
            print('\n\nThanks for using!\n\n...Shuting down...')
            sleep(2)
            exit()
        else:
            print('\n\nInvalid insert.\n\nTry again')

else:
    print('\nUser not available.')
