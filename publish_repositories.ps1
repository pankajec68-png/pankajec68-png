<#
.SYNOPSIS
    Automated Publisher for Pankaj Singh's 5 Flagship GitHub Repositories
.DESCRIPTION
    Automates initialization and pushing of the 5 enterprise repositories to GitHub:
    1. azure-caf-enterprise-landingzone
    2. devsecops-pipeline-accelerator
    3. cloud-migration-factory-toolkit
    4. azure-finops-cost-governor
    5. zero-trust-cloud-guardrails
.AUTHOR
    Pankaj Singh (Enterprise Cloud Architect)
#>

$repoList = @(
    "azure-caf-enterprise-landingzone",
    "devsecops-pipeline-accelerator",
    "cloud-migration-factory-toolkit",
    "azure-finops-cost-governor",
    "zero-trust-cloud-guardrails"
)

$baseDir = "$PSScriptRoot\repositories"

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  PANKAJ SINGH - ENTERPRISE GITHUB REPOSITORY PUBLISHER     " -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan

foreach ($repo in $repoList) {
    $repoPath = Join-Path $baseDir $repo
    Write-Host "`n🚀 Processing [$repo]..." -ForegroundColor Yellow

    if (-not (Test-Path $repoPath)) {
        Write-Warning "Directory not found: $repoPath"
        continue
    }

    Push-Location $repoPath

    try {
        if (-not (Test-Path ".git")) {
            git init -b main
        }
        git add .
        git commit -m "feat: initial enterprise production release of $repo" --allow-empty
        
        $remoteUrl = "https://github.com/pankajec68-png/$repo.git"
        git remote remove origin 2>$null
        git remote add origin $remoteUrl
        
        Write-Host "Pushing to $remoteUrl..." -ForegroundColor Green
        git push -u origin main
        Write-Host "✅ Successfully published: $repo" -ForegroundColor Green
    }
    catch {
        Write-Host "⚠️ Note: Ensure the repository '$repo' exists on your GitHub account (github.com/new) before pushing." -ForegroundColor Magenta
    }
    finally {
        Pop-Location
    }
}

Write-Host "`n🎉 All repositories processed!" -ForegroundColor Cyan
