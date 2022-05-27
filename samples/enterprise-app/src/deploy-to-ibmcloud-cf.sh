#!/usr/bin/env bash
# This script deploys the services of the enterprise-app to IBM Cloud Foundry.
# Login to IBM Cloud before running this script or uncomment the command below and run the script.
# ibmcloud login
# ibmcloud login --sso
# ibmcloud target -g <RESOURCE-GROUP> --cf
# ibmcloud cf install

CF_CLI_TOOL='ibmcloud cf' ./deploy-to-cf.sh
