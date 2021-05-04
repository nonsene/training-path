import requests

user = input('Digite o nome de usuário: ')

#Utilizar a url personalizada com o usuário que foi digitado a partir de um format
url = (f'https://api.github.com/users/{user}/repos')

#Usar o get para baixar os dados da página inserida 
web_page = requests.get(url)

#Decodificar os dados para json, para tratamento deles
web_page_json = web_page.json()

#criação de uma lista apenas para casos específicos quando há necessidade de ser utilizada
repository_list = []

#criando uma váriavel para testar a disponibilidade do link
status = web_page.status_code

#if para checar o status positivo do site
if status == 200:

#laço de repetição para passar por todos os valores de texto inclusos no arquivo .json e adicionando os mesmo a lista criada e os mostrando na tela.
    for i in web_page_json:
        repository_list.append(i["name"])
        print(i['name'])

else:
    print('Indisponível.')
