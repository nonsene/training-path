<h1 style="text-align: center;"> ⚡ SERVERLESS API WITH AZURE FUNCTIONS ⚡  </h1>

## 📦 Contents
1. [About The Project](#-about-the-project)
    * [Build With](#-built-with)
    
2. [Getting Started](#-getting-started)
    * [Prerequisites](#-prerequisites)
   
3. [Running the program on both ways](#-running-the-program-on-both-ways)
   * [Running the program locally](#-running-the-program-locally)
   * [Running the program on cloud with Azure Function](#-running-the-program-on-cloud-with-azure-function)
   
    
4. [Querying with Postman](#-querying-with-postman)
    * [POST](#post)
    * [GET](#get)
    * [PUT](#put)
    * [DELETE](#delete)
   
5. [Useful links](#useful-links)



## ❓ About The Project

Designed to run an CRUD WebAPI project on Cloud using Azure Functions

### 🏗️ Built With

* [Python](https://www.python.org)
* [MongoDB](https://www.mongodb.com)
* [Azure Functions Core Tool](https://www.npmjs.com/package/azure-functions-core-tools)
* [Azure Functions](https://azure.microsoft.com/pt-br/services/functions/)

## 🏁 Getting Started

We used python to create a CRUD API that access a mongoDB database and shows the content on your browser. Adding
Azure Functions to this allows the user to have your Web API hosted on the cloud. In this README we are going to 
show you how to do that.

### 📋 Prerequisites

Before continuing to the next steps, you will need to download
[Azure CLI](https://docs.microsoft.com/pt-br/cli/azure/install-azure-cli-windows?tabs=azure-cli) and 
[Azure Functions](https://docs.microsoft.com/pt-br/azure/azure-functions/functions-run-local?tabs=windows%2Ccsharp%2Cbash#v2) in order
to run the next few commands.

Execute ```> pip install -r requirements.txt```on your terminal to download all the libraries 
needed to run the program. 

This lesson shows the commands running on your terminal or command prompt. 

## 💾 Running the program on both ways
If you want to check how to run the program locally, just continuing rolling down this file. If not, check
out the [Running the program on cloud with Azure Functions](#-running-the-program-on-cloud-with-azure-function)
directly.

### 💾 Running the program locally

1. Open the project on your IDE.
2. On your project directory, run the terminal and write the following command:
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
   
### 💾 Running the program on cloud with Azure Function
We are going to show you how to create a serverless function app on your Azure Portal account. To do that, you will need 
a valid Azure Portal account. For the login, open your terminal and run this command:
```shell
az login
```
A window will open on your browser to confirm your Azure account. Now follow the steps:

1. First you will need a Resource Group, and an Azure Storage Group to create your serverless function. 
   If you already have that, jump to the step 2.
*  Resource Group: `az group create --name <ResourceGroupName> --location <RegionLocation>`
   

* Storage Account: `az storage account create --name <StorageName> --location <Region> 
  --resource-group <ResourceGroupName> --sku Standard_LRS`
  
2. Now use the following query to create your new serverless function app:
   ```shell
   az function app --name <FunctionAppName> --storage-account <StorageName> --consumption-plan-location <Region>
   --resource-grou <ResourceGroupName> --os-type Linux --runtime python --runtime-version 3.7
   --functions-version 2   
   ```
3. As the final step, deploy your local function to Azure:
   ```shell
   func azure functionapp publish <FunctionAppName>
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

## Useful links
* [Work With Azure Function Core Tools Locally](http://docs.microsoft.com/pt-br/azure/azure-functions/functions-run-local?tabs=windows%2Cpython%2Cbash)
* [Develop Azure Functions by using Visual Studio Code](https://docs.microsoft.com/pt-br/azure/azure-functions/functions-develop-vs-code?tabs=csharp)