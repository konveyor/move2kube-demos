# Customers Service

This service is a REST API that returns customer information.  
A customer is a tuple of (id, username, name, surname, address, zipCode, city, country).  
All responses are in JSON format.  
There are 2 endpoints:
- `/customers` returns a list of all the customers (upto pagination limit)
- `/customers/{id}` returns the info of the customer with that id.

## Usage

```
$ ./mvnw clean spring-boot:run -P local
```

Browse to http://localhost:8080/customers
