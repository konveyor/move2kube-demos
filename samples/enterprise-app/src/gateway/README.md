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

First, deploy the backend services- [orders](https://github.com/konveyor/move2kube-demos/tree/main/samples/enterprise-app/src/orders#deploying-to-cloud-foundry), [customers](https://github.com/konveyor/move2kube-demos/tree/main/samples/enterprise-app/src/customers#deploying-to-cloud-foundry) and [inventory](https://github.com/konveyor/move2kube-demos/tree/main/samples/enterprise-app/src/inventory#deploying-to-cloud-foundry) to Cloud Foundry before deploying the `gateway` service.

Next, update the endpoint URLs of `orders`, `inventory` and `customers` services in the [application-dev.properties](https://github.com/konveyor/move2kube-demos/blob/main/samples/enterprise-app/src/gateway/src/main/resources/application-dev.properties) file using the App URL for each of these services on Cloud Foundry. Make sure you use `http` in the service URLs in the application-dev.properties file, and not `https`.

For example:-

[`application-dev.properties`](https://github.com/konveyor/move2kube-demos/blob/91e8051731f3508343ad51c0713fc36f05825d1b/samples/enterprise-app/src/gateway/src/main/resources/application-dev.properties#L1)

```console
services.orders.url=http://enterprise-app-2743220496-orders.mybluemix.net/orders
services.customers.url=http://enterprise-app-2743220496-customers.mybluemix.net/customers
services.inventory.url=http://enterprise-app-2743220496-inventory.mybluemix.net/products
```

Now, login to your Cloud Foundry account `cf login` and then run the below commands to deploy the `gateway` service to Cloud Foundry.

```console
$ SPRING_PROFILES_ACTIVE=dev ./mvnw clean package -P dev
```

```console
$ cf push --random-route
```

NOTE: The service can also be deployed with a different `name` other than what is specified in the manifest.yml file and without using the `random-route` flag by running the below commands, and that overrides the name present in the manifest.yml file. Since, we are not using the `random-route`, so first we will create a unique variable that no-one else will be using in the multi-tenant IBM Cloud Foundry environment.

```console
$ rand1=`echo $RANDOM$RANDOM`
$ app="enterprise-app"
$ appname=`echo $app-$rand1`
$ echo $appname
```
```console
$ cf push $appname-gateway
```
