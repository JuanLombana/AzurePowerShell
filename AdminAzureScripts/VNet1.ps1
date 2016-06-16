#$subnet1 = New-AzureRmVirtualNetworkSubnetConfig -Name "SbTest1" -AddressPrefix "10.1.0.0/24"
#New-AzureRmVirtualNetwork -Name "VNETTest2" -ResourceGroupName "RGTest1" -Location "SouthcentralUs" -AddressPrefix "10.1.0.0/16" -Subnet $subnet1

#Remove-AzureRmVirtualNetwork -Name "VNETTest2" -ResourceGroupName "RGTest1" -Force 

#New-AzureRmResourceGroup -Name "RGVNTest1" -Location "SouthcentralUs"

#CREAR RED VIRTUAL CON 3 SUBREDES.
#$subnetAplicacion = New-AzureRmVirtualNetworkSubnetConfig -Name "aplicacion" -AddressPrefix "172.16.0.0/24"
#$subnetServidores = New-AzureRmVirtualNetworkSubnetConfig -Name "servidores" -AddressPrefix "172.16.1.0/28"
#$subnetDatos = New-AzureRmVirtualNetworkSubnetConfig -Name "datos" -AddressPrefix "172.16.1.16/28"
#New-AzureRmVirtualNetwork -Name "VNetClickIn" -ResourceGroupName "RGVNTest1" -Location "Southcentralus" -AddressPrefix "172.16.0.0/12" -Subnet $subnetAplicacion,$subnetServidores,$subnetDatos

#MODIFICAR ADDRESS SPACE DEL GRUPO DE RECURSOS.
#$VNet = Get-AzureRmVirtualNetwork -Name "VNetClickIn" -ResourceGroupName "RGVNTest1"
#$VNet.AddressSpace.AddressPrefixes.Add("192.168.0.0/24")
#Set-AzureRmVirtualNetwork -VirtualNetwork $VNet

#AGREGAR SUBNET A LA RED VIRTUAL
#$subnetSatelite = New-AzureRmVirtualNetworkSubnetConfig -Name "satelites" -AddressPrefix "192.168.0.0/24"
#$VNet = Get-AzureRmVirtualNetwork -Name "VNetClickIn" -ResourceGroupName "RGVNTest1"
#$VNet.Subnets.Add($subnetSatelite)
#Set-AzureRmVirtualNetwork -VirtualNetwork $VNet

