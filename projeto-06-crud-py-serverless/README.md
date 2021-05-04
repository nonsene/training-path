<h1 style="text-align: center;"> LOCAL CRUD API WITH SERVERLESS FUNCTIONS </h1>

## 📦 Contents
1. [About The Project](#-about-the-project)
    
2. [Build With](#-built-with)
    * [Prerequisites](#-prerequisites)
    * [Running the program](#-running-the-program)
    
3. [Querying with Postman](#-querying-with-postman)
    * [POST](#post)
    * [GET](#get)
    * [PUT](#put)
    * [DELETE](#delete)



## ❓ About The Project

Designed to run an API locally with serverless functions 
and using Azure Functions Core Tools.

## 🏗️ Built With

* [Python](https://www.python.org)
* [MongoDB](https://www.mongodb.com)
* [Azure Functions Core Tools](https://www.npmjs.com/package/azure-functions-core-tools)


### 📋 Prerequisites

Before continuing to the next steps, you will need to download
[Azure CLI](https://docs.microsoft.com/pt-br/cli/azure/install-azure-cli-windows?tabs=azure-cli) and 
[Azure Functions](https://www.npmjs.com/package/azure-functions-core-tools) in order
to run the next few commands.

Execute ```> pip install -r requirements.txt```on your terminal to download all the libraries 
needed to run the program. 

This lesson shows the commands running on your terminal or command prompt. 

### 💾 Running the program

1. Open the project on your IDE.
2. Run the terminal on your project directory and type the following command:

   ```shell
   func start
   ```
   Wait for this message:
   ```shell
   Found Python version 3.9.1 (py).

   Azure Functions Core Tools
   Core Tools Version:       3.0.3331 Commit hash: 0b57b1647c5a385beb8f7d64fa0e534ad4c7555d
   Function Runtime Version: 3.0.15371.0


   Functions:

        products: [GET,POST,PUT,DELETE] http://localhost:5000/products

   For detailed output, run func with --verbose flag.
   Worker process started and initialized.


   ```
3. Open the following link on your address bar.
   ```html
    http://localhost:5000/products?url=/products
   ```
4. You should see this message in your webpage:
   ```json
   [
     {
       "ProductID": 159, 
       "Name": "safe", 
       "Description": {
         "valor": 555
       }, 
       "Price": 1500.0
     }, 
     {
       "ProductID": 2, 
       "Name": "dois", 
       "Description": {
         "valor": 2
       }, 
       "Price": 2.0
     }
   ]
   ```
   And this message on your terminal:
   ```shell
    Executing 'Functions.products' (Reason='This function was programmatically called via the host 
    APIs.', Id=9a168387-69db-451f-9f54-60802eaa3294)
    Python HTTP trigger GET
    Executed 'Functions.products' (Succeeded, Id=9a168387-69db-451f-9f54-60802eaa3294, Duration=2058ms)
   ```
## 📝 Querying with Postman
On your [postman app](https://www.postman.com/downloads/) or web browser, create a 
new collection to start a new query.


### POST


1. Use the `http://localhost:5000/products` as the default link to the POST query. Use the following KEY:VALUE 
to make a right post.

   ```
           KEY                         VALUE  
   ✅      url                       /products
   ```
   <br>
   <br>
   
2. Second you will need to set up the Headers with Json, so you can post data. Click 
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

   <br>

### GET


Using the GET option on your postman app, create a new query by just simply tipping 
```http://localhost:5000/products``` and using the KEY:VALUE for the url.
You can get a list of ProductID too, just use ```/products/id``` as the VALUE for the url.


### PUT

Use the ```/products/id``` VALUE for the url and insert a dictionaries without the id field. Take the POST query
as example to this.
   ```
   {"name": "Car", "description":{"size": 555}, "price": 1500}
   ```


### DELETE

Use the ```/products/<productId>``` VALUE for the url and run the query to DELETE a product using the
specific ID.
