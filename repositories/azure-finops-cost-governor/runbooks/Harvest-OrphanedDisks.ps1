<#
.SYNOPSIS
    Automated FinOps Harvester for Unattached Azure Managed Disks
.DESCRIPTION
    Scans Azure subscriptions for unattached managed disks (ManagedBy is null).
    Takes a safety snapshot and removes orphaned disks to prevent recurring billing waste.
.AUTHOR
    Pankaj Singh (Enterprise Cloud Architect)
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [string]$SubscriptionId,

    [Parameter(Mandatory = $false)]
    [bool]$DryRun = $true,

    [Parameter(Mandatory = $false)]
    [int]$RetentionDays = 30
)

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  AZURE FINOPS ENGINE: UNATTACHED MANAGED DISK HARVESTER    " -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan

if ($SubscriptionId) {
    Set-AzContext -SubscriptionId $SubscriptionId | Out-Null
}

$unattachedDisks = Get-AzDisk | Where-Object { $_.ManagedBy -eq $null }

if ($unattachedDisks.Count -eq 0) {
    Write-Host "✅ No unattached disks detected. Environment is fully optimized." -ForegroundColor Green
    return
}

Write-Host "Found $($unattachedDisks.Count) unattached managed disks." -ForegroundColor Yellow

$totalSavedGB = 0

foreach ($disk in $unattachedDisks) {
    $totalSavedGB += $disk.DiskSizeGB
    Write-Host " -> Disk: $($disk.Name) | RG: $($disk.ResourceGroupName) | Size: $($disk.DiskSizeGB) GB | Tier: $($disk.Sku.Name)"
    
    if (-not $DryRun) {
        Write-Host "    [ACTION] Taking safety snapshot before deletion..." -ForegroundColor Yellow
        $snapshotConfig = New-AzSnapshotConfig -SourceResourceId $disk.Id -Location $disk.Location -CreateOption Copy
        New-AzSnapshot -Snapshot $snapshotConfig -SnapshotName "$($disk.Name)-predelete-snapshot" -ResourceGroupName $disk.ResourceGroupName | Out-Null
        
        Write-Host "    [ACTION] Removing orphaned disk $($disk.Name)..." -ForegroundColor Red
        Remove-AzDisk -ResourceGroupName $disk.ResourceGroupName -DiskName $disk.Name -Force | Out-Null
    }
}

Write-Host "`nSummary: Total Storage Harvested: $totalSavedGB GB." -ForegroundColor Green
if ($DryRun) {
    Write-Host "Mode: DryRun completed. Re-run with -DryRun `$false to execute deletion." -ForegroundColor Cyan
}
