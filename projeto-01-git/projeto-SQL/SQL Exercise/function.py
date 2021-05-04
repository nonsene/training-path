import pyodbc

server = 'gabrielsene.database.windows.net'
database = 'repositorygit'
username = 'cloudadmin'
password = 'GabrielPires96*'
driver = '{ODBC Driver 17 for SQL Server}'

def server_connect():
    server_connection_key = pyodbc.connect('DRIVER='+driver+';PORT=1433;SERVER='+server+';PORT=1443;DATABASE='+database+';UID='+username+';PWD='+password)
    return server_connection_key

def select():
    connection = server_connect()
    cursor = connection.cursor()
    cursor.execute('SELECT * FROM repogit')
    result = cursor.fetchall()
    connection.close()
    return result

def insert_values(username, repository_list):
    connection = server_connect()
    cursor = connection.cursor()
    cursor.execute(f"INSERT INTO repogit VALUES ('{username}', '{repository_list}')")
    connection.commit()
    connection.close()

def delete_values(username):
    connection = server_connect()
    cursor = connection.cursor()
    cursor.execute(f"DELETE FROM repogit WHERE username = '{username}'")
    connection.commit()
    connection.close()

def check_username(username):
    connection = server_connect()
    cursor = connection.cursor()
    cursor.execute(f"SELECT CASE WHEN EXISTS (SELECT username FROM repogit WHERE username = '{username}') THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END")
    result = cursor.fetchone()
    connection.close()
    return result