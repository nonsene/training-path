# Introduction

This README file objective is to show how to use the main program to insert repositories from GitHub, on a DataBase, just by typing your desired Git username. Based on Requests and SQL Alchemy libraries, this is a simple code to train skills on Python.

# Requirements
* Python installed
* Basic skills on Python
* Json
* Requests Library installed 
* Integrated development environment (IDE)
* MongoDB Cluster online

## Installation

For Python installation, just use the Python [site](https://www.python.org/downloads/) and follow the steps. (Don't forget to add Python to PATH)


For the libraries used on the program, use [Pip](https://pip.pypa.io/en/stable/) to download all of them:

```
> pip install -r install.txt
```

For mongoDB cluster, enter the following [link](https://account.mongodb.com/account/login?signedOut=true) and create an account on Cloud Mongo. After that, create a new cluster and go to connect options and follow the setup to get the connection link. The link should be like this:
``` 
mongodb+srv://<user>:<password>@<cluster>.lnn6e.mongodb.net/<database>?retryWrites=true&w=majority:
```

# Download and Execution

Download then run the code on your IDE and replace the <em>connect</em> parentheses with your connection link.
```
connect(host='mongodb+srv://userk:03086803@clusterk.lnn6e.mongodb.net/MongoDBtraining?retryWrites=true&w=majority')
```



Then execute the program till you have this response: 
``` 
Enter username:
```

Type the username that you want. With this done, you should get a list of repositories that are being add on your DB based on what username you've typed.

