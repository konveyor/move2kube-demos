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
$ SPRING_PROFILES_ACTIVE=dev-inmemorydb ./mvnw clean spring-boot:run -P dev-inmemorydb
```

Browse to http://localhost:8081/orders

## Deploying to Cloud Foundry

First login to your Cloud Foundry account `cf login` and then run the below commands to deploy the `orders` service to Cloud Foundry.

```console
$ SPRING_PROFILES_ACTIVE=dev-inmemorydb ./mvnw clean package -P dev-inmemorydb
```

```console
$ cf push
```
