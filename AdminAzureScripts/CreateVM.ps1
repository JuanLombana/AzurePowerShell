#Add-AzureRmAccount
#Login-AzureRmAccount
#Get-AzureRmSubscription -SubscriptionName "ArgosID Bizspark" | Select-AzureRmSubscription
#Set-AzureRmContext -SubscriptionName "ArgosID Bizspark"
#Get-AzureRmContext

#GRUPO DE RECURSOS
#New-AzureRmResourceGroup -Name "RGTest1" -Location "Southcentral US"
#$Resource = Get-AzureRmResourceGroup -Name "RGTest1"
#$Resource.ResourceId

#CUENTA DE ALMACENAMIENTO
#New-AzureRmStorageAccount -ResourceGroupName "RGTest1" -Name "satest170532" -SkuName Standard_LRS -Location "SouthCentral Us" -Kind Storage 

#CREAR MAQUINA VIRTUAL
<#
$Credentials = Get-Credential
#CONFIGURACION DE LA VM
$VMConfig = New-AzureRmVMConfig -VMName "VMTest1" -VMSize "Standard_A1"
#CONFIGURACION DEL SO
$VMConfig = Set-AzureRmVMOperatingSystem -VM $VMConfig -Windows -ComputerName "VMTest11" -Credential ($Credentials)
#CONFIGURACION DE LA IMAGEN SO
$VMConfig = Set-AzureRmVMSourceImage -VM $VMConfig -PublisherName "MicrosoftWindowsServer" -Offer "WindowsServer" -Skus "2012-R2-Datacenter" -Version "latest"
#CONFIGURACION DEL DISCO DE SO
$VMConfig = Set-AzureRmVMOSDisk -VM $VMConfig -Name "vmtest1.vhd" -VhdUri "https://satest170532.blob.core.windows.net/vhds/vmtest1.vhd" -CreateOption FromImage -Caching ReadWrite 
#CONFIGURACION DE RED
$subnet = New-AzureRmVirtualNetworkSubnetConfig -Name "SubnetTest1" -AddressPrefix "10.0.0.0/24"
$vnet = New-AzureRmVirtualNetwork -Force -Name "VNetTest1" -ResourceGroupName "RGTest1" -Location "Southcentralus" -AddressPrefix "10.0.0.0/16" -Subnet $subnet
$subnetId = $vnet.Subnets[0].Id
$pip = New-AzureRmPublicIpAddress -ResourceGroupName "RGTest1" -Name "VIPTest1" -Location "Southcentralus" -AllocationMethod Dynamic -DomainNameLabel "vmrosquitastest1"
$nic = New-AzureRmNetworkInterface -Force -Name "NICTest1" -ResourceGroupName "RGTest1" -Location "Southcentralus" -SubnetId $subnetId -PublicIpAddressId $pip.Id
$VMConfig = Add-AzureRmVMNetworkInterface -VM $VMConfig -Id $nic.Id
#CREAR MAQUINA VIRTUAL
New-AzureRmVM -ResourceGroupName "RGTest1" -Location "Southcentralus" -VM $VMConfig
#>

#ELIMINAR MAQUINA VIRTUAL ASM
#Import-AzurePublishSettingsFile -PublishSettingsFile "C:\Azure\argosid.publishsettings"
#Get-AzureService -ServiceName "DevTest19222"
#$VM = Get-AzureVM -ServiceName "DevTest19222" -Name "DevTest1"
#Remove-AzureVM -ServiceName "DevTest19222" -Name "DevTest1"
#Remove-AzureService -ServiceName "DevTest19222"
#Remove-AzureV


#CAMBIAR TAMAÑO DE LA MÁQUINA VIRTUAL
<#
$VM = Get-AzureRmVM -Name "VMTest1" -ResourceGroupName "RGTest1"
$VM = New-AzureRmVMConfig -VMName "VMTest1" -VMSize "Standard_A3"
$VM.Location = "Southcentral US"
Update-AzureRmVM -ResourceGroupName "RGTest1" -VM $VM
#>


#AGREGAR VM A VNET EXISTENTE.

#OBTENER CONFIGURACIONES PARA EL DISCO
#Get-AzureRmStorageAccount
#Get-AzureRmVMImagePublisher -Location "Southcentralus"
#Get-AzureRmVMImageOffer -Location "Southcentralus" -PublisherName "MicrosoftWindowsServer"
#Get-AzureRmVMImageSku -Location "southcentralus" -PublisherName "MicrosoftWindowsServer" -Offer "WindowsServer"

#OBTENER CONFIGURACIONES PARA LA RED
<#
#Get-AzureRmVirtualNetwork -ResourceGroupName "RGTest1" -Name "VNetTest1"

$Credentials = Get-Credential
$VMConfig2 = New-AzureRmVMConfig -VMName "VmTest2" -VMSize "Basic_A1"
$VMConfig2 = Set-AzureRmVMOperatingSystem -VM $VMConfig2 -Windows -ComputerName "vmtest12" -Credential ($Credentials)
$VMConfig2 = Set-AzureRmVMSourceImage -VM $VMConfig2 -Version "latest" -PublisherName "MicrosoftWindowsServer" -Offer "WindowsServer" -Skus "2012-R2-Datacenter"
$VMConfig2 = Set-AzureRmVMOSDisk -VM $VMConfig2 -VhdUri "https://satest170532.blob.core.windows.net/vhds/vhddmtest2.vhd" -CreateOption fromImage -Name "chdtest2.vhd" -Caching ReadWrite

#CONFIGURAR RED
$Vnet = Get-AzureRmVirtualNetwork -ResourceGroupName "RGTest1" -Name "VNetTest1"
$subnet = $Vnet.Subnets[0]
$pip = New-AzureRmPublicIpAddress -ResourceGroupName "RGTest1" -Name "PIPVMTest2" -Location "southcentralus" -AllocationMethod Static -DomainNameLabel "vmrosquitastest2"
$nic = New-AzureRmNetworkInterface -ResourceGroupName "RGTest1" -Name "NICVMTest2" -Location "southcentralus" -Subnet $subnet -PublicIpAddress $pip -Primary

$VMConfig2 = Add-AzureRmVMNetworkInterface -VM $VMConfig2 -NetworkInterface @($nic)
New-AzureRmVM -ResourceGroupName "RGTest1" -Location "southcentralus" -VM $VMConfig2
#>

#AGREGAR DISCO A LA VM
#$VMConfig1 = Get-AzureRmVm -ResourceGroupName "RGTest1" -Name "VmTest1"
#$VMConfig1 = Add-AzureRmVMDataDisk -VM $VMConfig1 -Name "DiscoDatos1" -VhdUri "https://satest170532.blob.core.windows.net/vhds/discodatosvm1.vhd" -Caching ReadWrite -DiskSizeInGB 128 -CreateOption empty
#Update-AzureRmVm -ResourceGroupName "RGTest1" -VM $VMConfig1

#AGREGAR NIC A MAQUINA VIRTUAL
#CADA NIC DEBE ACCEDER A UN SUBNET DIFERENTE.
#SOLO SE PUEDEN AGREGAR NIC A VMS QUE TENGAN DESDE SU INICIO MAS DE UNA NIC.
$Vnet = Get-AzureRmVirtualNetwork -ResourceGroupName "RGTest1" -Name "VNetTest1"
$pip2 = New-AzureRmPublicIpAddress -ResourceGroupName "RGTest1" -Name "PIPVMTest12" -Location "southcentralus" -AllocationMethod Dynamic -DomainNameLabel "vmrosquitastest12"
$nic2 = New-AzureRmNetworkInterface -ResourceGroupName "RGTest1" -Name "NICVMTest12" -Location "southcentralus" -Subnet $Vnet.Subnets[1] -PublicIpAddress $pip2 -PrivateIpAddress "10.0.1.4"
$VMConfig1 = Add-AzureRmVMNetworkInterface -VM $VMConfig1 -NetworkInterface $nic2
$VMConfig1.NetworkProfile.NetworkInterfaces[0].Primary = $true
Update-AzureRmVM -VM $VMConfig1 -ResourceGroupName "RGTest1"
