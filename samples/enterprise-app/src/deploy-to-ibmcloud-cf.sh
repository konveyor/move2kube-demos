#!/usr/bin/env bash
# This script deploys the services of the enterprise-app to IBM Cloud Foundry.
# Login to IBM Cloud before running this script or uncomment the command below and run the script.
# ibmcloud login
# ibmcloud login --sso
# ibmcloud target -g <RESOURCE-GROUP> --cf
# ibmcloud cf install

if [[ "$(basename "$PWD")" != 'src' ]] ; then
  echo 'Please run this script from the "src" directory'
  exit 1
fi

working_dir=`echo $PWD`
echo $RANDOM$RANDOM > /dev/null # In zsh, to clear the cached $RANDOM$RANDOM value
rand1=`echo $RANDOM$RANDOM`
app=`echo enterprise-app`
appname=`echo $app-$rand1`
echo "appname is: $appname"

trap "trap_ctrl_c" INT

function trap_ctrl_c ()
{
    echo "Ctrl-C caught.. Performing clean up!"
    cd $working_dir
}

echo "\n======================================================================="
echo "========== Deploying Orders service to Cloud Foundry =================="
echo "======================================================================="
cd orders
SPRING_PROFILES_ACTIVE=dev-inmemorydb ./mvnw clean package -P dev-inmemorydb
ibmcloud cf push $appname-orders
rm -rf target

echo "\n\n======================================================================="
echo "========== Deploying Inventory service to Cloud Foundry ==============="
echo "======================================================================="
cd $working_dir/inventory
SPRING_PROFILES_ACTIVE=dev-inmemorydb ./mvnw clean package -P dev-inmemorydb
ibmcloud cf push $appname-inventory
rm -rf target

echo "\n\n======================================================================="
echo "========== Deploying Customers service to Cloud Foundry ==============="
echo "======================================================================="
cd $working_dir/customers
SPRING_PROFILES_ACTIVE=dev-inmemorydb ./mvnw clean package -P dev-inmemorydb
ibmcloud cf push $appname-customers
rm -rf target

echo "\n\n======================================================================="
echo "========== Deploying Gateway service to Cloud Foundry ================="
echo "======================================================================="
cd $working_dir/gateway
if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' 's/http:\/\/orders:8080/http:\/\/'"$appname"'-orders.mybluemix.net/g' src/main/resources/application-dev.properties
    sed -i '' 's/http:\/\/customers:8080/http:\/\/'"$appname"'-customers.mybluemix.net/g' src/main/resources/application-dev.properties
    sed -i '' 's/http:\/\/inventory:8080/http:\/\/'"$appname"'-inventory.mybluemix.net/g' src/main/resources/application-dev.properties
else
    sed -i 's/http:\/\/orders:8080/http:\/\/'"$appname"'-orders.mybluemix.net/g' src/main/resources/application-dev.properties
    sed -i 's/http:\/\/customers:8080/http:\/\/'"$appname"'-customers.mybluemix.net/g' src/main/resources/application-dev.properties
    sed -i 's/http:\/\/inventory:8080/http:\/\/'"$appname"'-inventory.mybluemix.net/g' src/main/resources/application-dev.properties
fi
SPRING_PROFILES_ACTIVE=dev ./mvnw clean package -P dev
ibmcloud cf push $appname-gateway
cd $working_dir/gateway # If the user presses ctrl-c during previous step it will take to the $working_dir
rm -rf target
if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' 's/http:\/\/'"$appname"'-orders.mybluemix.net/http:\/\/orders:8080/g' src/main/resources/application-dev.properties
    sed -i '' 's/http:\/\/'"$appname"'-customers.mybluemix.net/http:\/\/customers:8080/g' src/main/resources/application-dev.properties
    sed -i '' 's/http:\/\/'"$appname"'-inventory.mybluemix.net/http:\/\/inventory:8080/g' src/main/resources/application-dev.properties
else
    sed -i 's/http:\/\/'"$appname"'-orders.mybluemix.net/http:\/\/orders:8080/g' src/main/resources/application-dev.properties
    sed -i 's/http:\/\/'"$appname"'-customers.mybluemix.net/http:\/\/customers:8080/g' src/main/resources/application-dev.properties
    sed -i 's/http:\/\/'"$appname"'-inventory.mybluemix.net/http:\/\/inventory:8080/g' src/main/resources/application-dev.properties
fi
echo "\n\n======================================================================="
echo "========== Deploying Frontend service to Cloud Foundry ================"
echo "======================================================================="

cd $working_dir/frontend
if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' 's|const gateway_svc.*|const gateway_svc = `http:\/\/\'"$appname"'-gateway.mybluemix.net`;|g' server.js
    sed -i '' 's/http:\/\/localhost:8080/http:\/\/'"$appname"'-gateway.mybluemix.net/g' webpack.dev.js
else
    sed -i 's|const gateway_svc.*|const gateway_svc = `http:\/\/\'"$appname"'-gateway.mybluemix.net`;|g' server.js
    sed -i 's/http:\/\/localhost:8080/http:\/\/'"$appname"'-gateway.mybluemix.net/g' webpack.dev.js
fi
CF_STAGING_TIMEOUT=30 ibmcloud cf push $appname-frontend
cd $working_dir/frontend # If the user presses ctrl-c during previous step it will take to the $working_dir
if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' 's|const gateway_svc = `http:\/\/\'"$appname"'-gateway.mybluemix.net`;|const gateway_svc = `http:\/\/${argv.gateway}`;|g' server.js
    sed -i '' 's/http:\/\/'"$appname"'-gateway.mybluemix.net/http:\/\/localhost:8080/g' webpack.dev.js
else
    sed -i 's|const gateway_svc = `http:\/\/\'"$appname"'-gateway.mybluemix.net`;|const gateway_svc = `http:\/\/${argv.gateway}`;|g' server.js
    sed -i 's/http:\/\/'"$appname"'-gateway.mybluemix.net/http:\/\/localhost:8080/g' webpack.dev.js
fi
cd $working_dir

echo "\n\n======================================================================="
echo "======================================================================="
echo "\nYour appname is '$appname'"
echo "You can use the appname to connect to the different components of the enterprise-app individually and test them."


echo "\n\n=========== Testing the Cloud Foundry deployments of the enterprise-app services ==========="
echo "\n$appname-inventory:"
echo "curl http://$appname-inventory.mybluemix.net/products"

echo "\n$appname-customers:"
echo "curl http://$appname-customers.mybluemix.net/customers"

echo "\n$appname-orders:"
echo "curl http://$appname-orders.mybluemix.net/orders"

echo "\n$appname-gateway:"
echo "curl http://$appname-gateway.mybluemix.net/customers"
echo "curl http://$appname-gateway.mybluemix.net/orders"
echo "curl http://$appname-gateway.mybluemix.net/products"

echo "\n$appname-frontend:
Visit http://$appname-frontend.mybluemix.net URL on your browser. Please refresh the page if it appears blank."

echo "\n\n======================================================================="
echo "======================================================================="
