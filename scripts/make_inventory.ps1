$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $PSScriptRoot
$TerraformDir = Join-Path $Root "terraform"
$IP = terraform -chdir="$TerraformDir" output -raw app_public_ip
if (-not $IP) { throw "Could not read app_public_ip. Apply Terraform first." }

$Inventory = @"
[student_servers]
student-host ansible_host=$IP ansible_user=ubuntu

[student_servers:vars]
ansible_python_interpreter=/usr/bin/python3
"@
$Inventory | Set-Content -Path (Join-Path $Root "ansible/inventory.ini")
Write-Host "Wrote ansible/inventory.ini for $IP"
