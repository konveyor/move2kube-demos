# Inventory Service

This service is a REST API that returns order information for each product.  
A product is a tuple of (id, name, description).  
All responses are in JSON format.  
There are 2 endpoints:
- `/products` returns a list of all the products (upto pagination limit)
- `/products/{id}` returns the info of the order with that id.

## Usage

```
$ SPRING_PROFILES_ACTIVE=local ./mvnw clean spring-boot:run -P local
```

Browse to http://localhost:8083/products

## Deploying to Cloud Foundry

First login to your Cloud Foundry account `cf login` and then run the below commands to deploy the `inventory` service to Cloud Foundry.

```console
$ SPRING_PROFILES_ACTIVE=dev-inmemorydb ./mvnw clean package -P dev-inmemorydb
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
$ cf push $appname-inventory
```
