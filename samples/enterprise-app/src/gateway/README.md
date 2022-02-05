# Gateway Service

This service is a REST API that acts as a circuit breaker to all the backend REST API services.  
All responses are in JSON format.  
There are 6 endpoints:
- `/customers` returns a list of all the customers (upto pagination limit)
- `/customers/{id}` returns the info of the customer with that id.
- `/orders` returns a list of all the orders (upto pagination limit)
- `/orders/{id}` returns the info of the order with that id.
- `/products` returns a list of all the products (upto pagination limit)
- `/products/{id}` returns the info of the product with that id.

## Usage

```
$ SPRING_PROFILES_ACTIVE=dev ./mvnw clean spring-boot:run -P dev
```

Browse to:
- http://localhost:8080/customers
- http://localhost:8080/orders
- http://localhost:8080/products
