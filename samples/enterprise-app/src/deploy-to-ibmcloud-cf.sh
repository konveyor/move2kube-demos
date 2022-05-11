#!/usr/bin/env bash
# This script deploys the services of the enterprise-app to IBM Cloud Foundry.
# Login to IBM Cloud before running this script or uncomment the command below and run the script.
# ibmcloud login
# ibmcloud login --sso
# ibmcloud target -g <RESOURCE-GROUP> --cf

rand1=`echo $RANDOM$RANDOM`
app="enterprise-app"
export appname=`echo $app-$rand1`
echo "appname is: $appname"

echo "\n\n========== Deploying Orders service to Cloud Foundry =================="
cd orders
SPRING_PROFILES_ACTIVE=dev-inmemorydb ./mvnw clean package -P dev-inmemorydb
ibmcloud cf push $appname-orders
cd ..
echo "=============== Orders deployed to Cloud Foundry ======================"


echo "\n\n========== Deploying Inventory service to Cloud Foundry ==============="
cd inventory
SPRING_PROFILES_ACTIVE=dev-inmemorydb ./mvnw clean package -P dev-inmemorydb
ibmcloud cf push $appname-inventory
cd ..
echo "=============== Inventory deployed to Cloud Foundry ==================="


echo "\n\n========== Deploying Customers service to Cloud Foundry ==============="
cd customers
SPRING_PROFILES_ACTIVE=dev-inmemorydb ./mvnw clean package -P dev-inmemorydb
ibmcloud cf push $appname-customers
cd ..
echo "=============== Customers deployed to Cloud Foundry ==================="


echo "\n\n========== Deploying Gateway service to Cloud Foundry ================="
cd gateway
sed -i '' 's/http:\/\/orders:8080/http:\/\/'"$appname"'-orders.mybluemix.net/g' src/main/resources/application-dev.properties
sed -i '' 's/http:\/\/customers:8080/http:\/\/'"$appname"'-customers.mybluemix.net/g' src/main/resources/application-dev.properties
sed -i '' 's/http:\/\/inventory:8080/http:\/\/'"$appname"'-inventory.mybluemix.net/g' src/main/resources/application-dev.properties
SPRING_PROFILES_ACTIVE=dev ./mvnw clean package -P dev
ibmcloud cf push $appname-gateway
cd ..
echo "=============== Gateway deployed to Cloud Foundry ====================="


echo "\n\n========== Deploying Frontend service to Cloud Foundry ================"
cd frontend
sed -i '' 's|const gateway_svc.*|const gateway_svc = "http:\/\/\'"$appname"'-gateway.mybluemix.net";|g' server.js
sed -i '' 's/http:\/\/localhost:8080/http:\/\/'"$appname"'-gateway.mybluemix.net/g' webpack.dev.js
CF_STAGING_TIMEOUT=30 ibmcloud cf push $appname-frontend
echo "=============== Frontend deployed to Cloud Foundry ===================="

echo "\n\n\nYour appname is $appname and you can use that to connect to the different components of the enterprise-app individually and test them."

echo "\n\n=========== Testing the deployments of the backend services ==========="
echo "Testing $appname-inventory:"
curl http://$appname-inventory.mybluemix.net/products

echo "Testing $appname-customers:"
curl http://$appname-customers.mybluemix.net/customers

echo "Testing $appname-orders:"
curl http://$appname-orders.mybluemix.net/orders

echo "Testing $appname-gateway:"
curl http://$appname-gateway.mybluemix.net/customers
curl http://$appname-gateway.mybluemix.net/orders
curl http://$appname-gateway.mybluemix.net/products
