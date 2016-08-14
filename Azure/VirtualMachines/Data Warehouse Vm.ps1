﻿Clear-Host

$resourceGroupName = "vchds-root-rg"
$dataCentre = "canadacentral"
$vnetName = "vchds-vnet"
$storageAccountName = "vchdsstorageacct"

$workLoadName = "DW"
$vmSize="Standard_A6"
$skuName = "Enterprise"
$publisherName = "MicrosoftRServer"
$offerName = "RServer-WS2012R2"
$subnetName = "dw-subnet"


$VmIp = "192.168.2.10"
$VmId = 1
New-Vm -WorkLoadName $workLoadName -VMSize $vmSize -ResourceGroupName $resourceGroupName -StorageAccountName $StorageAccountName -SubNetName $subnetName -VNetName $vnetName -PrivateIp $VmIp -VmId $VmId -SkuName $skuName -PublisherName $publisherName -OfferName $offerName

$workLoadName = "DW"
$vmSize="Standard_A6"
$skuName = "Enterprise"
$publisherName = "MicrosoftSQLServer"
$offerName = "SQL2016-WS2012R2-BYOL"

$VmIp = "192.168.2.20"
$VmId = 2
New-Vm -WorkLoadName $workLoadName -VMSize $vmSize -ResourceGroupName $resourceGroupName -StorageAccountName $StorageAccountName -SubNetName $subnetName -VNetName $vnetName -PrivateIp $VmIp -VmId $VmId -SkuName $skuName -PublisherName $publisherName -OfferName $offerName
