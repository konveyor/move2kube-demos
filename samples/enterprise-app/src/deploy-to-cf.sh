#!/usr/bin/env bash
# This script deploys the services of the enterprise-app to Cloud Foundry.

if [[ "$(basename "$PWD")" != 'src' ]] ; then
  echo 'Please run this script from the "src" directory'
  exit 1
fi

CF_CLI_TOOL="${CF_CLI_TOOL:-cf}"

echo "Note: This script requires you to be logged in to your Cloud Foundry account."
if [ "$CF_CLI_TOOL" == "cf" ]; then
  echo "Hint: cf login (or cf login --sso)"
elif [ "$CF_CLI_TOOL" == "ibmcloud cf" ]; then
  echo "Hint: ibmcloud login (or ibmcloud login --sso); ibmcloud target --cf -g <RESOURCE_GROUP>"
fi

echo -e "\nAll the previously deployed services (customers/inventory/orders/gateway/frontend) of the enterprise-app existing on Cloud Foundry will be deleted."
echo "Do you want to proceed? (Y/N)"
read user_input
if [ "$user_input" = "n" ] || [ "$user_input" = "N" ] || [ "$user_input" = "no" ] || [ "$user_input" = "NO" ] || [ "$user_input" = "No" ]; then
    echo "Exiting ..."
    exit 0
elif [ "$user_input" = "y" ] || [ "$user_input" = "Y" ] || [ "$user_input" = "yes" ] || [ "$user_input" = "YES" ] || [ "$user_input" = "Yes" ]; then
    echo "Deleting the previously deployed services (customers/inventory/orders/gateway/frontend)."
else
    echo "Invalid input. Exiting ..."
    exit 0
fi

$CF_CLI_TOOL delete customers -f
$CF_CLI_TOOL delete inventory -f
$CF_CLI_TOOL delete orders -f
$CF_CLI_TOOL delete gateway -f
$CF_CLI_TOOL delete frontend -f

working_dir="$PWD"
echo "$RANDOM$RANDOM" > /dev/null # In zsh, to clear the cached $RANDOM$RANDOM value
rand1="$RANDOM$RANDOM"
app='enterprise-app'
appname="$app-$rand1"
echo -e "\nappname is: $appname"

export CF_STAGING_TIMEOUT=40
export CF_STARTUP_TIMEOUT=40

trap "trap_ctrl_c" INT

function trap_ctrl_c () {
    echo "Ctrl-C caught.. Performing clean up!"
    cd "$working_dir" || exit
}

echo -e "\n\n======================================================================="
echo "========== Deploying Customers service to Cloud Foundry ==============="
echo "======================================================================="
cd "$working_dir"/customers || exit
SPRING_PROFILES_ACTIVE=dev-inmemorydb ./mvnw clean package -P dev-inmemorydb
$CF_CLI_TOOL push -t 180 --hostname "$appname"-customers
rm -rf target

echo -e "\n\n======================================================================="
echo "========== Deploying Inventory service to Cloud Foundry ==============="
echo "======================================================================="
cd "$working_dir"/inventory || exit
SPRING_PROFILES_ACTIVE=dev-inmemorydb ./mvnw clean package -P dev-inmemorydb
$CF_CLI_TOOL push -t 180 --hostname "$appname"-inventory
rm -rf target

echo -e "\n\n======================================================================="
echo "========== Deploying Orders service to Cloud Foundry =================="
echo "======================================================================="
cd "$working_dir"/orders || exit
SPRING_PROFILES_ACTIVE=dev-inmemorydb ./mvnw clean package -P dev-inmemorydb
$CF_CLI_TOOL push -t 180 --hostname "$appname"-orders
rm -rf target

echo -e "\n\n======================================================================="
echo "========== Deploying Gateway service to Cloud Foundry ================="
echo "======================================================================="
cd "$working_dir"/gateway || exit
SPRING_PROFILES_ACTIVE=dev ./mvnw clean package -P dev
$CF_CLI_TOOL push --no-start -t 180 --hostname "$appname"-gateway
$CF_CLI_TOOL set-env gateway ENTERPRISE_APP_CUSTOMERS_URL "http://$appname-customers.mybluemix.net/customers"
$CF_CLI_TOOL set-env gateway ENTERPRISE_APP_INVENTORY_URL "http://$appname-inventory.mybluemix.net/products"
$CF_CLI_TOOL set-env gateway ENTERPRISE_APP_ORDERS_URL "http://$appname-orders.mybluemix.net/orders"
$CF_CLI_TOOL start gateway

cd "$working_dir"/gateway || exit # If the user presses ctrl-c during previous step it will take to the $working_dir
rm -rf target

echo -e "\n\n======================================================================="
echo "========== Deploying Frontend service to Cloud Foundry ================"
echo "======================================================================="
cd "$working_dir"/frontend || exit
$CF_CLI_TOOL push --no-start -t 180 --hostname "$appname"-frontend
$CF_CLI_TOOL set-env frontend ENTERPRISE_APP_GATEWAY_URL "http://$appname-gateway.mybluemix.net"
$CF_CLI_TOOL start frontend

cd "$working_dir" || exit

echo -e "\n\n======================================================================="
echo "======================================================================="
echo -e "\nYour appname is '$appname'"
echo "You can use the appname to connect to the different components of the enterprise-app individually and test them."

echo -e "\n\n=========== Testing the Cloud Foundry deployments of the enterprise-app services ==========="
echo -e "\ninventory:"
echo "curl http://$appname-inventory.mybluemix.net/products"

echo -e "\ncustomers:"
echo "curl http://$appname-customers.mybluemix.net/customers"

echo -e "\norders:"
echo "curl http://$appname-orders.mybluemix.net/orders"

echo -e "\ngateway:"
echo "curl http://$appname-gateway.mybluemix.net/customers"
echo "curl http://$appname-gateway.mybluemix.net/orders"
echo "curl http://$appname-gateway.mybluemix.net/products"

echo -e "\nfrontend:\nVisit http://$appname-frontend.mybluemix.net URL on your browser. Please refresh the page if it appears blank."

echo -e "\n\n======================================================================="
echo "======================================================================="

trap - INT
