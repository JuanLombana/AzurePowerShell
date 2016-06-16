#Add-AzureRmAccount
#Set-AzureRmContext -SubscriptionName "ArgosId Bizspark"

$credentials = Get-Credential
#CREATE SERVER
New-AzureRmSqlServer -ServerName "dbtest70532" -Location "southcentralus" -SqlAdministratorCredentials ($credentials) -ResourceGroupName "RGTest1" -ServerVersion "12.0"
#DATABASE
New-AzureRmSqlDatabase -DatabaseName "TestDB" -ServerName "dbtest70532" -Edition Basic -ResourceGroupName "RGTest1"
#FIREWALL
New-AzureRmSqlServerFirewallRule -FirewallRuleName "ClickIn" -StartIpAddress "181.143.42.242" -EndIpAddress "181.143.42.242" -ResourceGroupName "RGTest1" -ServerName "dbtest70532"

#CONSULTAR UN SERVIDOR
Get-AzureRmSqlServer -ServerName "dbtest70532" -ResourceGroupName "RGTest1"

Get-AzureRmSqlServerUpgradeHint -ServerName "dbtest70532" -ResourceGroupName "RGTest1"
Get-AzureRmSqlDatabaseRestorePoints -ServerName "dbtest70532" -DatabaseName "TestDB" -ResourceGroupName "RGTest1"