# Declare variables for the resource group and web app names
variables:
  resourceGroupName: 'myResourceGroup'
  webAppName: 'myWebApp'

# Declare a variable for the package filename
parameters:
  - name: packageFilename
    type: string

# Install the Azure PowerShell module if it is not already installed
- task: PowerShell@2
  displayName: 'Install Azure PowerShell module'
  inputs:
    targetType: 'inline'
    script: |
      if (!(Get-Module -Name AzureRM -ListAvailable)) {
        Install-Module -Name AzureRM -AllowClobber
      }

# Importing the Azure PowerShell module
- task: PowerShell@2
  displayName: 'Import Azure PowerShell module'
  inputs:
    targetType: 'inline'
    script: |
      Import-Module AzureRM


# Connecting to Azure using a service connection
- task: AzurePowerShell@5
  displayName: 'Connect to Azure'
  inputs:
    azureSubscription: 'myAzureSubscription'
    ScriptType: 'FilePath'
    ScriptPath: 'Connect-AzureRmAccount.ps1'

# Deploying the web app
- task: AzurePowerShell@5
  displayName: 'Deploy web app'
  inputs:
    azureSubscription: 'myAzureSubscription'
    ScriptType: 'FilePath'
    ScriptPath: 'deploy-web-app.ps1'
    ScriptArguments: '-resourceGroupName $(resourceGroupName) -webAppName $(webAppName) -packageFilename $(packageFilename)'


# Disconnecting from Azure
- task: AzurePowerShell@5
  displayName: 'Disconnect from Azure'
  inputs:
    azureSubscription: 'myAzureSubscription'
    ScriptType: 'FilePath'
    ScriptPath: 'Disconnect-AzureRmAccount.ps1'
