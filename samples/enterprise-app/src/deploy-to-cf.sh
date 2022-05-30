#!/usr/bin/env bash
# This script deploys the services of the enterprise-app to Cloud Foundry.
# Login to Cloud Foundry before running this script or uncomment the command below and run the script.
# cf login
# cf login --sso

if [[ "$(basename "$PWD")" != 'src' ]] ; then
  echo 'Please run this script from the "src" directory'
  exit 1
fi

CF_CLI_TOOL="${CF_CLI_TOOL:-cf}"

working_dir="$PWD"
echo "$RANDOM$RANDOM" > /dev/null # In zsh, to clear the cached $RANDOM$RANDOM value
rand1="$RANDOM$RANDOM"
app='enterprise-app'
appname="$app-$rand1"
echo "appname is: $appname"

trap "trap_ctrl_c" INT

function trap_ctrl_c () {
    echo "Ctrl-C caught.. Performing clean up!"
    cd "$working_dir" || exit
}

echo -e "\n\n======================================================================="
echo "========== Deploying Orders service to Cloud Foundry =================="
echo "======================================================================="
cd "$working_dir"/orders || exit
SPRING_PROFILES_ACTIVE=dev-inmemorydb ./mvnw clean package -P dev-inmemorydb
$CF_CLI_TOOL push "$appname"-orders
rm -rf target

echo -e "\n\n======================================================================="
echo "========== Deploying Inventory service to Cloud Foundry ==============="
echo "======================================================================="
cd "$working_dir"/inventory || exit
SPRING_PROFILES_ACTIVE=dev-inmemorydb ./mvnw clean package -P dev-inmemorydb
$CF_CLI_TOOL push "$appname"-inventory
rm -rf target

echo -e "\n\n======================================================================="
echo "========== Deploying Customers service to Cloud Foundry ==============="
echo "======================================================================="
cd "$working_dir"/customers || exit
SPRING_PROFILES_ACTIVE=dev-inmemorydb ./mvnw clean package -P dev-inmemorydb
$CF_CLI_TOOL push "$appname"-customers
rm -rf target

echo -e "\n\n======================================================================="
echo "========== Deploying Gateway service to Cloud Foundry ================="
echo "======================================================================="
cd "$working_dir"/gateway || exit
SPRING_PROFILES_ACTIVE=dev ./mvnw clean package -P dev
$CF_CLI_TOOL push "$appname"-gateway \
    --var ENTERPRISE_APP_CUSTOMERS_URL="http://$appname-customers.mybluemix.net/customers" \
    --var ENTERPRISE_APP_INVENTORY_URL="http://$appname-inventory.mybluemix.net/products" \
    --var ENTERPRISE_APP_ORDERS_URL="http://$appname-orders.mybluemix.net/orders"
cd "$working_dir"/gateway || exit # If the user presses ctrl-c during previous step it will take to the $working_dir
rm -rf target

echo -e "\n\n======================================================================="
echo "========== Deploying Frontend service to Cloud Foundry ================"
echo "======================================================================="
cd "$working_dir"/frontend || exit
CF_STAGING_TIMEOUT=30 $CF_CLI_TOOL push "$appname"-frontend --var ENTERPRISE_APP_GATEWAY_URL="http://$appname-gateway.mybluemix.net"
cd "$working_dir" || exit

echo -e "\n\n======================================================================="
echo "======================================================================="
echo -e "\nYour appname is '$appname'"
echo "You can use the appname to connect to the different components of the enterprise-app individually and test them."

echo -e "\n\n=========== Testing the Cloud Foundry deployments of the enterprise-app services ==========="
echo -e "\n$appname-inventory:"
echo "curl http://$appname-inventory.mybluemix.net/products"

echo -e "\n$appname-customers:"
echo "curl http://$appname-customers.mybluemix.net/customers"

echo -e "\n$appname-orders:"
echo "curl http://$appname-orders.mybluemix.net/orders"

echo -e "\n$appname-gateway:"
echo "curl http://$appname-gateway.mybluemix.net/customers"
echo "curl http://$appname-gateway.mybluemix.net/orders"
echo "curl http://$appname-gateway.mybluemix.net/products"

echo -e "\n$appname-frontend:\nVisit http://$appname-frontend.mybluemix.net URL on your browser. Please refresh the page if it appears blank."

echo -e "\n\n======================================================================="
echo "======================================================================="

trap - INT
