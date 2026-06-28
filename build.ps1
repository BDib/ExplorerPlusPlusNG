[CmdletBinding()]
param (
    [Parameter(HelpMessage="Specify the platforms to build (e.g., x64, win32, arm64)")]
    [string[]]$Platforms = @("x64", "win32", "arm64"),

    [Parameter(HelpMessage="Specify the configurations to build (e.g., release, debug)")]
    [string[]]$Configurations = @("release", "debug"),

    [Parameter(HelpMessage="Clean the build folder before building")]
    [switch]$Clean,

    [Parameter(HelpMessage="Use CMake to build")]
    [switch]$CMake = $true
)

$ProjectRoot = Get-Item $PSScriptRoot
$BuildBase = Join-Path $ProjectRoot.FullName "build"

if ($PSCmdlet.MyInvocation.BoundParameters.ContainsKey("Help")) {
    Write-Host "Usage: .\build.ps1 [-Platforms <x64|win32|arm64>] [-Configurations <release|debug>] [-Clean] [-CMake]"
    Write-Host "`nDescription: Automates the multi-platform/configuration build for Explorer++ using CMake."
    return
}

if ($Clean) {
    Write-Host "Cleaning build folder..." -ForegroundColor Cyan
    if (Test-Path $BuildBase) {
        Remove-Item -Recurse -Force $BuildBase
    }
    exit
}

# Ensure vcpkg is bootstrapped
if ($CMake) {
    $vcpkgBootstrap = Join-Path $ProjectRoot.FullName "Explorer++\ThirdParty\vcpkg\bootstrap-vcpkg.bat"
    if (Test-Path $vcpkgBootstrap) {
        Write-Host "Bootstrapping vcpkg..." -ForegroundColor Cyan
        & $vcpkgBootstrap
    }
}

foreach ($p in $Platforms) {
    foreach ($c in $Configurations) {
        $preset = "$($p.ToLower())-$($c.ToLower())"
        Write-Host "--- Building Preset: $preset ---" -ForegroundColor Cyan
        
        # Configure
        & cmake --preset $preset
        if ($LASTEXITCODE -ne 0) {
            Write-Error "Configure failed for $preset!"
            exit $LASTEXITCODE
        }

        # Build
        & cmake --build --preset $preset
        if ($LASTEXITCODE -ne 0) {
            Write-Error "Build failed for $preset!"
            exit $LASTEXITCODE
        }
    }
}

Write-Host "Build Completed Successfully!" -ForegroundColor Green
