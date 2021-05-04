<h1 style="text-align: center;"> DOCKER </h1>

## Contents
1. [About The Project](#about-the-project)
    * [Build With](#built-with)
    
2. [Getting Started](#getting-started)
    * [Prerequisites](#prerequisites)
    * [Running the program](#running-the-program)
    
3. [Querying with Postman](#querying-with-postman)
    * [POST](#post)
    * [GET](#get)
    * [PUT](#put)
    * [DELETE](#delete)



## About The Project

Designed to learn about Docker, this project uses python with Flask and MongoDB both 
hosted on Docker as containers. 

### Built With

* [Python](https://www.python.org)
* [MongoDB](https://www.mongodb.com)
* [Docker](https://www.docker.com)

## Getting Started

We used python as were building the program, but in this case you won't need it, 
just Docker and an IDE to run your program.

### Prerequisites

Install [Docker Desktop](https://www.docker.com/products/docker-desktop) and execute it. 
Follow the steps on the installation and wait until you get a `Docker Desktop is running` on 
your task bar.

### Running the program

1. Open the project on your IDE.
2. On the terminal, run the following command:
   ```
   docker-compose up
   ```
   Wait until download everything.
3. Open the following link on your address bar.
   ```
   https://localhost:5000/products
   ```
4. You should see this message:
   ```
   {
   "Error": "No products found on DB."
    }
   ```

## Querying with Postman
On your [postman app](https://www.postman.com/downloads/) or web browser, create a 
new collection to start a new query.
### POST
First you will need to set up the Headers with Json, so you can post some data. Click 
on the ```Headers``` option and create a new KEY:VALUE.
```
        KEY                         VALUE  
✅     Content-Type                application/json
```
Do not forget to mark the check box to make your key available. 

In the ```Body``` window, use the following example to create a new product.

```
{"name": "Car", "id": 159, "description":{"size": 555}, "price": 1500}
```
Note: The description field accepts only dictionaries as value. You can add them as much 
as you want.

### GET
Using the GET option on your postman app, create a new query by just simply tipping 
```http://localhost:5000/products```.
You can get a list of ProductID by tipping ```http://localhost:5000/products/<productid>```
### PUT
Instead of using ```http://localhost:5000/products``` you should now use ```http://localhost:5000/products/<productid>``` to update some information about your product.
Use the same sentence of the PUT query, but without the ID field.
### DELETE
Insert ```http://localhost:5000/products/<productid>``` in the DELETE option and execute 
to delete the product.
