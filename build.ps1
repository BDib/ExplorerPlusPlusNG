[CmdletBinding()]
param (
    [Parameter(HelpMessage="Specify the platforms to build (e.g., x64, Win32, ARM64)")]
    [string[]]$Platforms = @("x64", "Win32", "ARM64"),

    [Parameter(HelpMessage="Specify the configurations to build (e.g., Release, Debug)")]
    [string[]]$Configurations = @("Release", "Debug"),

    [Parameter(HelpMessage="Clean the BIN folder before building")]
    [switch]$Clean
)

$ProjectRoot = Get-Item $PSScriptRoot
$BinBase = Join-Path $ProjectRoot.FullName "BIN"

if ($PSCmdlet.MyInvocation.BoundParameters.ContainsKey("Help")) {
    Write-Host "Usage: .\build.ps1 [-Platforms <x64|Win32|ARM64>] [-Configurations <Release|Debug>] [-Clean]"
    Write-Host "`nDescription: Automates the multi-platform/configuration build for Explorer++."
    return
}

if ($Clean) {
    Write-Host "Cleaning BIN folder..." -ForegroundColor Cyan
    if (Test-Path $BinBase) {
        Remove-Item -Recurse -Force $BinBase
    }
    exit
}

Write-Host "Building Explorer++ ($Platform | $Configuration)..." -ForegroundColor Cyan

$MSBuildPath = & "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe" -latest -products * -requires Microsoft.Component.MSBuild -property installationPath
if (-not $MSBuildPath) {
    Write-Error "MSBuild not found. Please ensure Visual Studio is installed."
    exit 1
}

$MSBuildExe = Join-Path $MSBuildPath "MSBuild\Current\Bin\MSBuild.exe"

foreach ($p in $Platforms) {
    # Map 'x86' to 'Win32' for MSBuild
    $targetPlatform = if ($p -eq "x86") { "Win32" } else { $p }
    
    foreach ($c in $Configurations) {
        # Define platform/configuration-specific output folder
        $outDir = Join-Path $BinBase (Join-Path $p $c)
        
        Write-Host "--- Building Platform: $p | Configuration: $c ---" -ForegroundColor Cyan
        
        & $MSBuildExe "Explorer++\Explorer++.sln" `
            /p:Configuration=$c `
            /p:Platform=$targetPlatform `
            /p:OutDir=$outDir `
            /m /t:Build

        if ($LASTEXITCODE -ne 0) {
            Write-Error "Build failed for $p | $c!"
            exit $LASTEXITCODE
        }
    }
}

Write-Host "Build Completed Successfully!" -ForegroundColor Green
