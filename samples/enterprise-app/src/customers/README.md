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

First login to your Cloud Foundry account `cf login` and then run the below commands to deploy the `customers` service to Cloud Foundry.

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
$ cf push $appname-customers
```
