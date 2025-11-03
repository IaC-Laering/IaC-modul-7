# Deploy script for Windows (PowerShell)
param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("dev", "test", "prod")]
    [string]$Environment,
    
    [Parameter(Mandatory=$true)]
    [string]$Artifact
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path $Artifact)) {
    Write-Host " Error: Artifact not found: $Artifact" -ForegroundColor Red
    exit 1
}

Write-Host " Deploying to $Environment environment..." -ForegroundColor Green
Write-Host ""

# Create workspace
$WORKSPACE = "workspace-$Environment"
if (Test-Path $WORKSPACE) {
    Remove-Item -Recurse -Force $WORKSPACE
}
New-Item -ItemType Directory -Path $WORKSPACE | Out-Null

# Extract artifact
Write-Host "1 Extracting artifact..." -ForegroundColor Yellow
tar -xzf $Artifact -C $WORKSPACE
Write-Host " Artifact extracted" -ForegroundColor Green
Write-Host ""

Set-Location "$WORKSPACE/terraform"

# Initialize with backend
Write-Host "2 Initializing Terraform..." -ForegroundColor Yellow
terraform init -backend-config="../backend-configs/backend-$Environment.tfvars"
Write-Host ""

# Plan
Write-Host "3 Planning deployment..." -ForegroundColor Yellow
terraform plan -var-file="../environments/$Environment.tfvars" -out=tfplan
Write-Host ""

# Apply
Write-Host "4 Applying changes..." -ForegroundColor Yellow
terraform apply -auto-approve tfplan
Write-Host ""

# Show outputs
Write-Host " Deployment complete!" -ForegroundColor Green
Write-Host ""
Write-Host " Outputs:" -ForegroundColor Cyan
terraform output

Set-Location ../..
