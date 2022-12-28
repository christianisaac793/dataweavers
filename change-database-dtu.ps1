# Install the Azure PowerShell module if it is not already installed
if (!(Get-Module -Name AzureRM -ListAvailable)) {
  Install-Module -Name AzureRM -AllowClobber
}

# Import the Azure PowerShell module
Import-Module AzureRM

# Connect to Azure using an interactive login prompt
Connect-AzureRmAccount

# Declare variables for the resource group, server, and database names
param (
  [string]$resourceGroupName,
  [string]$serverName,
  [string]$databaseName
)

# Declare a variable for the new DTU value
param (
  [int]$newDtu
)

# Get the database object
$database = Get-AzureRmSqlDatabase -ResourceGroupName $resourceGroupName -ServerName $serverName -DatabaseName $databaseName

# Set the new DTU value
$database.Sku.Capacity = $newDtu

# Update the database with the new DTU value
Set-AzureRmSqlDatabase -Database $database
