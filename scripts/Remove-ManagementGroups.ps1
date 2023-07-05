$tenantId = "f6279e07-c6ac-45ee-a551-12a2fdf33d14"
$sub6 = "795ed07b-f150-4728-b325-c7c82d6534aa"
Connect-AzAccount -TenantId $tenantId -SubscriptionId $sub6

$mgs = Get-AzManagementGroup
foreach ($mg in $mgs)
{
    Remove-AzManagementGroup -GroupName ($mg.Id).Split("/")[-1]
}