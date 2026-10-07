<#
.SYNOPSIS
    Builds and runs the Melissa Smart Mover Cloud API .NET sample.

.DESCRIPTION
    This script builds SmartMoverDotnet with dotnet publish, then runs the resulting
    executable, passing along the license and (if supplied) the PAF ID and the
    name/company/address fields.

    Overall flow:
      1. Resolve the license (parameter, prompt, or MD_LICENSE environment variable).
      2. Publish SmartMoverDotnet in Release configuration to .\SmartMoverDotnet\Build.
      3. Run the built executable: one-shot mode if any input field was supplied,
         otherwise interactive mode (the .NET program prompts for each field).

.PARAMETER pafid
    PAF ID to use in one-shot mode.

.PARAMETER company
    Company name to look up in one-shot mode.

.PARAMETER fullname
    Full name to look up in one-shot mode.

.PARAMETER addressline1
    Street address to look up in one-shot mode.

.PARAMETER city
    City to look up in one-shot mode.

.PARAMETER state
    State to look up in one-shot mode.

.PARAMETER postalcode
    Postal code to look up in one-shot mode.

.PARAMETER country
    Country to look up in one-shot mode.

.PARAMETER license
    License string. Resolved in this order:
      1. This parameter.
      2. An interactive prompt, if the parameter was not supplied.
      3. The MD_LICENSE environment variable, if the prompt was left blank.
    Note that the environment variable is the last resort, not the first: running
    without -license always prompts, even when MD_LICENSE is set.

.PARAMETER quiet
    Accepted for parity with other sample scripts; not currently used to suppress output.

.EXAMPLE
    .\SmartMoverDotnet.ps1 -license "your-license"

.EXAMPLE
    .\SmartMoverDotnet.ps1 -pafid "<pafid>" -company "Melissa" -fullname "Ray Melissa" -addressline1 "22382 Avenida Empresa" -city "Rancho Santa Margarita" -state "CA" -postalcode "92688" -country "US" -license "your-license"
#>

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
# No input fields supplied -> run interactively; otherwise pass them all through for one-shot mode.
if ([string]::IsNullOrEmpty($pafid) -and[string]::IsNullOrEmpty($company) -and [string]::IsNullOrEmpty($fullname) -and [string]::IsNullOrEmpty($addressline1) -and [string]::IsNullOrEmpty($city) -and [string]::IsNullOrEmpty($state) -and [string]::IsNullOrEmpty($postalcode) -and [string]::IsNullOrEmpty($country)) {
  dotnet $BuildPath\SmartMoverDotnet.dll --license $license 
}
else {
  dotnet $BuildPath\SmartMoverDotnet.dll --license $license --pafid $pafid --company $company --fullname $fullname --addressline1 $addressline1 --city $city --state $state --postalcode $postalcode --country $country
}
