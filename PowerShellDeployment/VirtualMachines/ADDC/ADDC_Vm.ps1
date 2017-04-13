﻿Clear-Host

$workLoadName = "ADDC"
$vmSize="Standard_A3"
$skuName = "2012-R2-Datacenter"
$publisherName = "MicrosoftWindowsServer"
$offerName = "WindowsServer"
$subnetName = "addc-subnet"
$storageAccount = Get-AzureRmStorageAccount -ResourceGroupName $env:resourceGroupName -Name $env:storageAccountName -ErrorAction SilentlyContinue -ErrorVariable err -OutVariable outvar

New-Vm -WorkLoadName $workLoadName -VMSize $vmSize -ResourceGroupName $env:resourceGroupName -StorageAccountName $env:storageAccountName -SubNetName $subnetName -VNetName $env:vnetName -SkuName $skuName -PublisherName $publisherName -OfferName $offerName

#$storageAccount = Get-AzureRmStorageAccount -ResourceGroupName $env:resourceGroupName -Name $env:storageAccountName -ErrorAction SilentlyContinue -ErrorVariable err -OutVariable outvar

$addc_vm_list = Get-AzureRmVM -ResourceGroupName $env:resourceGroupName | Where-Object {$_.Name -like "ADDC*"}
$AddcVm1 = $addc_vm_list[0]

# Active Directory database and SYSVOL on D:
$dataDiskName="AdDb_SysVol"
$dataDiskUri = $storageAccount.PrimaryEndpoints.Blob.ToString() + "vhds/" + $dataDiskName  + ".vhd"
$vmName=$AddcVm1.Name
$vm=Get-AzureRmVM -ResourceGroupName $env:resourceGroupName -Name $vmName
$vm=Add-AzureRmVMDataDisk -VM $vm -Name $dataDiskName -VhdUri $dataDiskUri -Caching ReadWrite -DiskSizeInGB 100 -Lun 5 -CreateOption Empty
Update-AzureRmVM -VM $vm -ResourceGroupName $env:resourceGroupName

# logs on E:
$dataDiskName="AdLogs"
$dataDiskUri = $storageAccount.PrimaryEndpoints.Blob.ToString() + "vhds/" + $dataDiskName  + ".vhd"
$vmName=$AddcVm1.Name
$vm=Get-AzureRmVM -ResourceGroupName $env:resourceGroupName -Name $vmName
$vm=Add-AzureRmVMDataDisk -VM $vm -Name $dataDiskName -VhdUri $dataDiskUri -Caching ReadWrite -DiskSizeInGB 100 -Lun 6 -CreateOption Empty
Update-AzureRmVM -VM $vm -ResourceGroupName $env:resourceGroupName




# set up data disks and dirves...
Get-Disk | Where-Object IsSystem -eq $true
Get-Disk | Where-Object IsSystem -eq $false
# initialize disks
Initialize-Disk 2 –PartitionStyle MBR
Initialize-Disk 3 –PartitionStyle MBR
# add partition and disk drive letters

New-Partition –DiskNumber 2 -UseMaximumSize -AssignDriveLetter 
Get-Partition –DiskNumber 2

New-Partition –DiskNumber 3 -UseMaximumSize -AssignDriveLetter 
Get-Partition –DiskNumber 3
