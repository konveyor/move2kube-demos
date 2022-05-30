# Customers Service

This service is a REST API that returns customer information.  
A customer is a tuple of (id, username, name, surname, address, zipCode, city, country).  
All responses are in JSON format.  
There are 2 endpoints:
- `/customers` returns a list of all the customers (upto pagination limit)
- `/customers/{id}` returns the info of the customer with that id.

## Usage

```
$ SPRING_PROFILES_ACTIVE=local ./mvnw clean spring-boot:run -P local
```

Browse to http://localhost:8080/customers

### Run the war file in a container

```
$ docker run --rm -it \
    -p 8080:8080 \
    -e SPRING_PROFILES_ACTIVE=dev-inmemorydb \
    -v "$PWD/target/ROOT.war:/usr/local/tomcat/webapps-javaee/ROOT.war" \
    tomcat
```

## Deploying to Cloud Foundry

1. Login to your Cloud Foundry account (`cf login` or `cf login --sso`) if you haven't done so already.
1. If you haven't set an `$appname` yet, then choose an appropriate name that doesn't clash with apps that have already been deployed to Cloud Foundry. Example:
    ```sh
    $ appname='my-new-enterprise-app'
    ```
    We will use this same `$appname` when deploying all the other services.
1. Run the below commands to deploy the `customers` service to Cloud Foundry.
    ```sh
    $ SPRING_PROFILES_ACTIVE=dev-inmemorydb ./mvnw clean package -P dev-inmemorydb
    $ cf push "$appname"-customers
    ```
