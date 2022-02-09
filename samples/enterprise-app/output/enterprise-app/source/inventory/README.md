# Inventory Service

This service is a REST API that returns order information for each product.  
A product is a tuple of (id, name, description).  
All responses are in JSON format.  
There are 2 endpoints:
- `/products` returns a list of all the products (upto pagination limit)
- `/products/{id}` returns the info of the order with that id.

## Usage

```
$ SPRING_PROFILES_ACTIVE=dev-inmemorydb ./mvnw clean spring-boot:run -P dev-inmemorydb
```

Browse to http://localhost:8083/products
