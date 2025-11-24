
terraform init -backend-config="/shared/backend.hcl"

Write-Host "Running Terraform validation..." -ForegroundColor Blue
Write-Host ""

terraform fmt -check -recursive

Write-Host "`nRunning terraform validate..." -ForegroundColor Cyan
terraform validate 

Write-Host "`nRunning TFLint..." -ForegroundColor Cyan
tflint --init
tflint

Write-Host "`nRunning Checkov..." -ForegroundColor Cyan
checkov -d .

Write-Host "`nValidation complete!" -ForegroundColor Green