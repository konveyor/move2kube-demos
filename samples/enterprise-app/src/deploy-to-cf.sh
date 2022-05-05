#!/usr/bin/env bash
# This script deploys the services of the enterprise-app to Cloud Foundry.
# Login to Cloud Foundry before running this script or uncomment the command below and run the script.
# cf login
# cf login --sso

rand1=`echo $RANDOM$RANDOM`
app="enterprise-app"
export appname=`echo $app-$rand1`
echo $appname

cd orders
SPRING_PROFILES_ACTIVE=dev-inmemorydb ./mvnw clean package -P dev-inmemorydb
cf push $appname-orders
cd ..

cd inventory
SPRING_PROFILES_ACTIVE=dev-inmemorydb ./mvnw clean package -P dev-inmemorydb
cf push $appname-inventory
cd ..

cd customers
SPRING_PROFILES_ACTIVE=dev-inmemorydb ./mvnw clean package -P dev-inmemorydb
cf push $appname-customers
cd ..

cd gateway
sed -i '' 's/http:\/\/orders:8081/http:\/\/'"$appname"'-orders.mybluemix.net/g' src/main/resources/application-dev.properties
sed -i '' 's/http:\/\/customers:8082/http:\/\/'"$appname"'-customers.mybluemix.net/g' src/main/resources/application-dev.properties
sed -i '' 's/http:\/\/inventory:8083/http:\/\/'"$appname"'-inventory.mybluemix.net/g' src/main/resources/application-dev.properties
SPRING_PROFILES_ACTIVE=dev ./mvnw clean package -P dev
cf push $appname-gateway
cd ..

cd frontend
sed -i '' 's|const gateway_svc.*|const gateway_svc = "http:\/\/\'"$appname"'-gateway.mybluemix.net";|g' server.js
sed -i '' 's/http:\/\/localhost:8080/http:\/\/'"$appname"'-gateway.mybluemix.net/g' webpack.dev.js
cf push $appname-frontend
