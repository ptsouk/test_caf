$tenantId = "78395483-9425-447a-ba64-60b90f6bb16e"
$subscriptionId = "32063afb-6adc-4aff-9085-6e0a5a1e7605"
Connect-AzAccount -TenantId $tenantId -SubscriptionId $subscriptionId

$RESOURCE_GROUP_NAME='kzn-neu-tfstate-rg'
$STORAGE_ACCOUNT_NAME="kzntfstatestorage"
$CONTAINER_NAME='tfstatecore'
$location = "northeurope"
# Create resource group
New-AzResourceGroup -Name $RESOURCE_GROUP_NAME -Location $location -Force

# Create storage account
$storageAccount = New-AzStorageAccount -ResourceGroupName $RESOURCE_GROUP_NAME -Name $STORAGE_ACCOUNT_NAME -SkuName Standard_LRS -Location $location -AllowBlobPublicAccess $true

# Create blob container
New-AzStorageContainer -Name $CONTAINER_NAME -Context $storageAccount.context -Permission blob

# # Get storage key and store to the environment variable
# $ACCOUNT_KEY = (Get-AzStorageAccountKey -ResourceGroupName $RESOURCE_GROUP_NAME -Name $STORAGE_ACCOUNT_NAME)[0].value
# $env:ARM_ACCESS_KEY = $ACCOUNT_KEY