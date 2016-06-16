#EN ESTE CASO ASUMIMOS QUE TENEMOS UN APPLIANCE EN LA IP 192.168.0.4 (SUBNET APPLIANCE 192.168.0.0/24)
#REQUERIMOS QUE TODO EL TRAFICO QUE VA DE LA SUBNET FRONTEND (192.168.1.0/24) Y QUE VA A LA SUBNET BACKEND (192.168.2.0/24)
#SE REDIRIJA POR EL APPLIANCE POR MOTIVOS DE SEGURIDAD O SUPERVICIÓN.
#EL APPLIANCE DEBE RECIBIR EL IP FORWARDING PARA PODER RECIBIR TRAFICO QUE VA DIRIGIDO A OTRA IP.

#RUTAS
$routeFTB = New-AzureRmRouteConfig -Name "FrontToBack" -AddressPrefix "192.168.2.0/24" -NextHopType VirtualAppliance -NextHopIpAddress "192.168.0.4"
#TABLA DE ENRUTAMIENTO
$routeTable = New-AzureRmRouteTable -Name "UDRFTB" -ResourceGroupName "RGVNTest1" -Location "soutcentralus" -Route @($routeFTB)
#SE DEBE RECONFIGURAR LA SUBNET Y LA VNET TAL COMO EN LA NSG
$vnet = Get-AzureRmVirtualNetwork -ResourceGroupName "RGVNTest1" -Name "VNetClickIn"
Set-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $vnet -Name "frontend" -AddressPrefix "192.168.1.0/24" -RouteTable $routeFTB
Set-AzureRmVirtualNetwork -VirtualNetwork $vnet
#SE DEBE TRAER LA NIC DEL APPLIANCE PARA PERMITIR EL IP FORWARDING
$nicAPP = Get-AzureRmNetworkInterface -ResourceGroupName "RGVNTest1" -Name "NICVMTest12"
$nicAPP.EnableIPForwarding = $true
Set-AzureRmNetworkInterface -NetworkInterface $nicAPP