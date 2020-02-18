#!/bin/bash

LOCATION="westus"
RESOURCE="azure_static_sites_demo_westus"
ARM_TEMPLATE_FILE="staticSitesPayload.json"
SUBSCRIPTION_ID="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
ARM_URL="https://$LOCATION.management.azure.com/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE/providers/Microsoft.Web/staticSites/armtest0?api-version=2019-12-01-preview"

# Create a resource group (do this once)
# az group create --name $RESOURCE --location "westus"

# List all deployed static sites
# az rest \
#   --resource "https://management.azure.com" \
#   --method get \
#   --uri "$ARM_URL"

# Attach a static site
# echo ">> Creating $ARM_URL"
# az rest \
#   --resource "https://management.azure.com" \
#   --method put \
#   --uri "$ARM_URL" \
#   --body "@$ARM_TEMPLATE_FILE" 

# Detach a static site
# echo ">> Deleting $ARM_URL"
# az rest \
#   --resource "https://management.azure.com" \
#   --method delete \
#   --uri "$ARM_URL" \
#   --body "@$ARM_TEMPLATE_FILE" 
