# Deploy three Windows web apps to Azure, all to the same hosting plan

# Declaring variables for the resource group and hosting plan
param resourceGroupName string
param hostingPlanName string

# Declaring a variable for the location of the resource group
param location string

# Declaring variables for the web apps
param webApp1Name string
param webApp2Name string
param webApp3Name string

# Declaring a variable for the timezone of web app 3
param webApp3TimeZone string

# Declaring a variable for the SKU of the web apps
param webAppSku string

# Declaring a variable for the app service plan
param appServicePlanName string

# Declaring a variable for the web app resource id
param webAppResourceId string

# Declaring a reusable segment for the web app resource
resource webAppSegment (name: string, timeZone: string) = {
  type: 'Microsoft.Web/sites'
  apiVersion: '2020-06-01'
  name: name
  location: location
  properties: {
    serverFarmId: resourceId(resourceGroupName, 'Microsoft.Web/serverfarms', appServicePlanName)
    timeZone: timeZone
  }
}

# Deploying the web apps
resource webApp1 {
  name: webApp1Name
  location: location
  type: 'Microsoft.Web/sites'
  apiVersion: '2020-06-01'
  properties: {
    serverFarmId: resourceId(resourceGroupName, 'Microsoft.Web/serverfarms', appServicePlanName)
  }
}

resource webApp2 {
  name: webApp2Name
  location: location
  type: 'Microsoft.Web/sites'
  apiVersion: '2020-06-01'
  properties: {
    serverFarmId: resourceId(resourceGroupName, 'Microsoft.Web/serverfarms', appServicePlanName)
  }
}

#  web app 3
resource webApp3 {
  name: webApp3Name
  location: location
  type: 'Microsoft.Web/sites'
  apiVersion: '2020-06-01'
  properties: {
    serverFarmId: resourceId(resourceGroupName, 'Microsoft.Web/serverfarms', appServicePlanName)
  }
}

