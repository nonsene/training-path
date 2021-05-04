<h1 align="center">REST API</h1>

## Project Description
This project has the objective to show how API works by creating a Web App using the GitHub API and the MongoDB as database.

Content Table:
<!--ts-->
   * [Project Description](#Project-Description)
   * [Prerequisites](#Prerequisites)
   * [Requisites](#Requisites)
   * [MongoDB setup](#MongoDB-setup)
   * [Executing](#Executing)
## Features

- [x] User registration
- [x] Repository registration

## Prerequisites

For your code to run you will need to download the follow tools:

- [Python](https://www.python.org/downloads/)
- [PyPI](https://pypi.org/project/pip/)
- [IDE (Recommended: PyCharm by JetBrains)](https://www.jetbrains.com/pycharm/download/)
- [Postman (Recommended)](https://www.jetbrains.com/pycharm/download/)
- [MongoDB Atlas](https://account.mongodb.com/account/register?signedOut=true)

With that done, you should check for the <em>mongoDB.py</em> project in the directory and run it to save some data on your DB.
## Requisites

Before starting, you will need to use Pip to install the libraries in order to execute the program correctly. 


```bash
> pip install -r requirements.txt
```
### MongoDB setup

Create a <em>mongoDB Atlas</em> account in order to proceed. Create a cluster with a desired name and get the URI link on the connect button.

![alt text](CONNECT.png "Title")

Follow the steps using the <em>Connect your application</em> path, then copy your URI that should look like this.
```
mongodb+srv://<user>:<password>@<cluster>.lnn6e.mongodb.net/myFirstDatabase?retryWrites=true&w=majority
```

Substitute the ```app.config['MONGODB_SETTINGS'] = {"host": " <URI>}``` using your copied URI and change the <em> <user.>:<password.></em> with your credentials.

## Executing
Run your code. You should get this answer:
``` * Serving Flask app "test" (lazy loading)
 * Environment: production
   WARNING: This is a development server. Do not use it in a production deployment.
   Use a production WSGI server instead.
 * Debug mode: off
 * Running on http://127.0.0.1:5000/ (Press CTRL+C to quit)
 ```

Paste the ``http://localhost:5000/user`` on your address bar to see if the code works correctly.