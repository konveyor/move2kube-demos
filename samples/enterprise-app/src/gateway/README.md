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

```console
$ SPRING_PROFILES_ACTIVE=local ./mvnw clean spring-boot:run -P local
```

Browse to:
- http://localhost:8080/customers
- http://localhost:8080/orders
- http://localhost:8080/products

## Deploying to Cloud Foundry

1. First, deploy the backend services to Cloud Foundry before deploying the `gateway` service.
    - [orders](https://github.com/konveyor/move2kube-demos/tree/main/samples/enterprise-app/src/orders#deploying-to-cloud-foundry)
    - [customers](https://github.com/konveyor/move2kube-demos/tree/main/samples/enterprise-app/src/customers#deploying-to-cloud-foundry)
    - [inventory](https://github.com/konveyor/move2kube-demos/tree/main/samples/enterprise-app/src/inventory#deploying-to-cloud-foundry)
1. Login to your Cloud Foundry account (`cf login` or `cf login --sso`) if you haven't done so already.
1. Using the same `$appname` that was used to deploy the backend services, run the below commands to deploy the `gateway` service to Cloud Foundry.
    ```sh
    $ SPRING_PROFILES_ACTIVE=dev ./mvnw clean package -P dev
    $ cf push "$appname"-gateway \
        --var ENTERPRISE_APP_CUSTOMERS_URL="http://$appname-customers.mybluemix.net/customers" \
        --var ENTERPRISE_APP_INVENTORY_URL="http://$appname-inventory.mybluemix.net/products" \
        --var ENTERPRISE_APP_ORDERS_URL="http://$appname-orders.mybluemix.net/orders"
    ```
