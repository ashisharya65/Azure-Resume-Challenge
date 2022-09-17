[CmdletBinding()]
param (
    [Parameter(Mandatory)]
    [string]
    $ResourceGroup,

    [Parameter(Mandatory)]
    [string]
    $Subscription,

    [Parameter(Mandatory)]
    [string]
    $StorageAccountName,

    [Parameter()]
    [string]
    $StorageAccountSku = 'Standard_LRS',

    [Parameter(Mandatory)]
    [string]
    $Region,

    [Parameter(Mandatory)]
    [string]
    $WebsiteFilePath
)

# Log in to Azure
az login

# Set subscription to deploy resources
az account set --subscription $Subscription

# Create resource group
az group create --name $ResourceGroup --location $Region

# Create storage account
az storage account create --name $StorageAccountName --resource-group $ResourceGroup --location $Region --sku $StorageAccountSku --kind StorageV2

# Enable static website hosting
az storage blob service-properties update --account-name 'arya65storageaccount' --static-website --index-document index.html

# Upload website folders from local path
az storage blob upload-batch --source "D:\Azure-Resume-Challenge" --destination '$web' --account-name 'arya65storageaccount'

# Display website URL
az storage account show -n 'arya65storageaccount' --resource-group 'azureresume-rg' --query "primaryEndpoints.web" --output tsv