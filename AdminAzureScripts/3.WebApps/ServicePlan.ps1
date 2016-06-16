
#SE CREA EL SERVICE PLAN: TIER ES EL NIVEL (Free,Shared,Basic,Standard, Premium), WORKERSIZE ES EL TAMAÑO (1:Small, 2:Medium, 3:Large)
New-AzureRmAppServicePlan -Location "southcentralus" -Tier Standard -WorkerSize Large -NumberofWorkers 1  -ResourceGroupName "RGTest1" -Name "SPTest2" -

#ELIMINAR UN SERVICE PLAN
$Sp = Get-AzureRmAppServicePlan -ResourceGroupName "RGTest1" -Name "SPTest2"
Remove-AzureRmAppServicePlan -AppServicePlan $Sp

#ESCALAR VERTICALMENTE UN SERVICE PLAN
Set-AzureRmAppServicePlan -Tier Standard -WorkerSize Small -ResourceGroupName "RGTest1" -Name "SPTest1" -NumberofWorkers 1

#ESCALAR HORIZONTALMENTE UN SERVICE PLAN
Set-AzureRmAppServicePlan -ResourceGroupName "RGTest1" -Name "SPTest1" -NumberofWorkers 1
