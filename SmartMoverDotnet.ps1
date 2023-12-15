# Name:    SmartMoverCloudAPI
# Purpose: Execute the SmartMoverCloudAPI program

######################### Parameters ##########################
param(
    $pafid = '',
    $company = '',
    $fullname = '',
    $addressline1 = '',
    $city = '',
    $state = '',
    $postalcode = '',
    $country = '', 
    $license = '',
    [switch]$quiet = $false
    )

# Uses the location of the .ps1 file 
# Modify this if you want to use 
$CurrentPath = $PSScriptRoot
Set-Location $CurrentPath
$ProjectPath = "$CurrentPath\SmartMoverDotnet"
$BuildPath = "$ProjectPath\Build"

If (!(Test-Path $BuildPath)) {
  New-Item -Path $ProjectPath -Name 'Build' -ItemType "directory"
}

########################## Main ############################
Write-Host "`n===================== Melissa Smart Mover Cloud API ========================`n"

# Get license (either from parameters or user input)
if ([string]::IsNullOrEmpty($license) ) {
  $license = Read-Host "Please enter your license string"
}

# Check for License from Environment Variables 
if ([string]::IsNullOrEmpty($license) ) {
  $license = $env:MD_LICENSE
}

if ([string]::IsNullOrEmpty($license)) {
  Write-Host "`nLicense String is invalid!"
  Exit
}

# Start program
# Build project
Write-Host "`n=============================== BUILD PROJECT =============================="

dotnet publish -f="net7.0" -c Release -o $BuildPath SmartMoverDotnet\SmartMoverDotnet.csproj

# Run project
if ([string]::IsNullOrEmpty($pafid) -and[string]::IsNullOrEmpty($company) -and [string]::IsNullOrEmpty($fullname) -and [string]::IsNullOrEmpty($addressline1) -and [string]::IsNullOrEmpty($city) -and [string]::IsNullOrEmpty($state) -and [string]::IsNullOrEmpty($postalcode) -and [string]::IsNullOrEmpty($country)) {
  dotnet $BuildPath\SmartMoverDotnet.dll --license $license 
}
else {
  dotnet $BuildPath\SmartMoverDotnet.dll --license $license --pafid $pafid --company $company --fullname $fullname --addressline1 $addressline1 --city $city --state $state --postalcode $postalcode --country $country
}
