#SE TOMA LA SUBRED DESCRITA ABAJO PARA APLICAR A ALGUNAS SUBNETS UN NSG Y MODIFICAR OTRAS EXISTENTES.

#CREAR RED VIRTUAL CON 3 SUBREDES.
#$subnetAplicacion = New-AzureRmVirtualNetworkSubnetConfig -Name "aplicacion" -AddressPrefix "172.16.0.0/24"
#$subnetServidores = New-AzureRmVirtualNetworkSubnetConfig -Name "servidores" -AddressPrefix "172.16.1.0/28"
#$subnetDatos = New-AzureRmVirtualNetworkSubnetConfig -Name "datos" -AddressPrefix "172.16.1.16/28"
#New-AzureRmVirtualNetwork -Name "VNetClickIn" -ResourceGroupName "RGVNTest1" -Location "Southcentralus" -AddressPrefix "172.16.0.0/12" -Subnet $subnetAplicacion,$subnetServidores,$subnetDatos

#DEFINICIÓN DE REGLAS ACL DEL NSG
$reglaHttpEntrada = New-AzureRmNetworkSecurityRuleConfig -Name "HttpEntradaPermitirServidores" -Description "Permitir entrada http a subred de servidores" -Protocol Tcp  -SourceAddressPrefix "Internet" -SourcePortRange "*" -DestinationAddressPrefix "*" -DestinationPortRange "80" -Access Allow -Priority "100" -Direction Inbound
$reglaSqlEntrada = New-AzureRmNetworkSecurityRuleConfig -Name "SqlEntradaPermitirDatos" -Description "Permitir entrada sql a subred de datos" -Protocol Tcp  -SourceAddressPrefix "172.16.1.0/28" -SourcePortRange "*" -DestinationAddressPrefix "*" -DestinationPortRange "1433" -Access Allow -Priority "100" -Direction Inbound

#CREACIÓN DEL NSG
$nsgServidores = New-AzureRmNetworkSecurityGroup -Name "NSGServidores" -ResourceGroupName "RGVNTest1" -Location "southcentralus" -SecurityRules @($reglaHttpEntrada)
$nsgDatos = New-AzureRmNetworkSecurityGroup -Name "NSGDatos" -ResourceGroupName "RGVNTest1" -Location "southcentralus" -SecurityRules @($reglaSqlEntrada)

#ASOCIAR A SUBNET EXISTENTE
$VNet = Get-AzureRmVirtualNetwork -ResourceGroupName "RGVNTest1" -Name "VNetClickIn"
$subnetServidores = Get-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $VNet -Name "servidores"
Set-AzureRmVirtualNetworkSubnetConfig -Name "servidores" -VirtualNetwork $VNet -AddressPrefix "172.16.1.0/28" -NetworkSecurityGroup $nsgServidores
Set-AzureRmVirtualNetwork -VirtualNetwork $VNet #GUARDAR CAMBIOS

#DEFINIR NSG EN LA CREACIÓN DE LA SUBNET
$VNet = Get-AzureRmVirtualNetwork -Name "VNetClickIn" -ResourceGroupName "RGVNTest1"
Add-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $VNet -Name "satelites" -AddressPrefix "192.168.0.0/24" -NetworkSecurityGroup $nsgServidores
Set-AzureRmVirtualNetwork -VirtualNetwork $VNet
