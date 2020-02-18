
![Azure Pages CI](https://github.com/manekinekko/azure-static-sites-demo/workflows/Azure%20Pages%20CI/badge.svg)

## {{Azure Pages}} demo app

### How to setup {{Azure Pages}}

1. This is an Canary release. Your subscription has to be whitelisted by the product team.
1. Make sure you have the Azure CLI installed.
2. Log in to your Azure Account. Run `az login`
1. You need to unregister then register back to the `Microsoft.Web` resource provider:
```bash
az provider unregister --namespace Microsoft.Web
az provider register --namespace Microsoft.Web
```
3. create a resource group in the `westus` location (replace `$RESOURCE` with your own values): 
```bash
az group create \
  --name $RESOURCE 
  --location "westus"
```

4. Create a `payload.json` file:
```json
{
  "location": "westus",
  "properties": {
    "repositoryUrl": "$GITHUB_REPOSITORY_URL",
    "branch": "master",
    "createOrUpdateWorkflow": "true",
    "repositoryToken": "$GITHUB_TOKEN"
  },
  "sku": { "Name": "Standard", "Tier": "Standard" }
}
```
5. Update the following properties in the `payload.json`:
  - `repositoryUrl`: The URL of the GitHub repository. 
  - `repositoryToken`: The personal GitHub access token ([create one here](https://github.com/settings/tokens)). **Make sure to grant "repo, workflow, and admin:public_key (read)"**
5. Go ahead and create a static site resource (replace `$SUBSCRIPTION_ID` and `$RESOURCE` with your own values): 
```bash
az rest \
   --resource "https://management.azure.com" \
   --method put \
   --uri "https://westus.management.azure.com/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE/providers/Microsoft.Web/staticSites/demo?api-version=2019-12-01-preview" \
   --body "@payload.json" 
```
6. You should get a response which looks like:
```json
{
  "id": "/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE/providers/Microsoft.Web/staticSites/demo",
  "location": "West US",
  "name": "demo",
  "properties": {
    "branch": "master",
    "customDomains": [],
    "defaultHostname": "xxxxxx.staticsitescanary.net",
    "repositoryUrl": "$GITHUB_REPOSITORY_URL"
  },
  "resourceGroup": "$RESOURCE",
  "sku": {
    "name": "Standard",
    "tier": "Standard"
  },
  "type": "Microsoft.Web/staticSites"
}
```
7. Note down the URL that your app will be deployed at: xxxxxx.staticsitescanary.net
8. The Azure Function will be available at xxxxxx.staticsitescanary.net/.api/<functionName>


### Notes
- the GITHUB_TOKEN is stored in plain text in payload.json. DO NOT commit that to GitHub, otherwise the GitHub security bot will automatically delete your personal Token!
- you can not change the repositoryUrl. You have to delete it and recreate.
- function app inside the `api` needs to be built with Node.js LTS (even number: 8, 10, 12, etc.)
