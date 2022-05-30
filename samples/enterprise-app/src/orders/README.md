# Orders Service

This service is a REST API that returns order information for each customer.  
A order is a tuple of (id, customer id, date, items).  
The order items are a list of items.  
Each order item is a tuple of (id, product id, quantity, price).  
All responses are in JSON format.  
There are 2 endpoints:
- `/orders` returns a list of all the orders (upto pagination limit)
- `/orders/{id}` returns the info of the order with that id.

## Usage

```
$ SPRING_PROFILES_ACTIVE=local ./mvnw clean spring-boot:run -P local
```

Browse to http://localhost:8081/orders

## Deploying to Cloud Foundry

1. Login to your Cloud Foundry account (`cf login` or `cf login --sso`) if you haven't done so already.
1. If you haven't set an `$appname` yet, then choose an appropriate name that doesn't clash with apps that have already been deployed to Cloud Foundry. Example:
    ```sh
    $ appname='my-new-enterprise-app'
    ```
    We will use this same `$appname` when deploying all the other services.
1. Run the below commands to deploy the `orders` service to Cloud Foundry.
    ```sh
    $ SPRING_PROFILES_ACTIVE=dev-inmemorydb ./mvnw clean package -P dev-inmemorydb
    $ cf push "$appname"-orders
    ```
