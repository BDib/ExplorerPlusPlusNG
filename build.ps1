[CmdletBinding()]
param (
    [Parameter(HelpMessage="Specify the platforms to build (e.g., x64, win32, arm64)")]
    [string[]]$Platforms = @("x64", "win32", "arm64"),

    [Parameter(HelpMessage="Specify the configurations to build (e.g., release, debug)")]
    [string[]]$Configurations = @("release", "debug"),

    [Parameter(HelpMessage="Clean the build folder before building")]
    [switch]$Clean,

    [Parameter(HelpMessage="Vcpkg toolchain file path")]
    [string]$VcpkgToolchain
)

$ProjectRoot = Get-Item $PSScriptRoot
$BuildBase = Join-Path $ProjectRoot.FullName "build"

if ($PSCmdlet.MyInvocation.BoundParameters.ContainsKey("Help")) {
    Write-Host "Usage: .\build.ps1 [-Platforms <x64|win32|arm64>] [-Configurations <release|debug>] [-Clean] [-VcpkgToolchain <path>]"
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

# Try to find vcpkg toolchain if not provided
if (-not $VcpkgToolchain) {
    if ($env:VCPKG_INSTALLATION_ROOT) {
        $VcpkgToolchain = "$env:VCPKG_INSTALLATION_ROOT/scripts/buildsystems/vcpkg.cmake"
    } elseif (Test-Path "$ProjectRoot/Explorer++/ThirdParty/vcpkg/scripts/buildsystems/vcpkg.cmake") {
        $VcpkgToolchain = "$ProjectRoot/Explorer++/ThirdParty/vcpkg/scripts/buildsystems/vcpkg.cmake"
        # Bootstrap if exe is missing
        if (-not (Test-Path "$ProjectRoot/Explorer++/ThirdParty/vcpkg/vcpkg.exe")) {
            Write-Host "Bootstrapping submodule vcpkg..." -ForegroundColor Cyan
            & "$ProjectRoot/Explorer++/ThirdParty/vcpkg/bootstrap-vcpkg.bat"
        }
    }
}

foreach ($p in $Platforms) {
    foreach ($c in $Configurations) {
        $preset = "$($p.ToLower())-$($c.ToLower())"
        Write-Host "--- Building Preset: $preset ---" -ForegroundColor Cyan
        
        $cmakeArgs = @("--preset", $preset)
        if ($VcpkgToolchain) {
            $cmakeArgs += "-DCMAKE_TOOLCHAIN_FILE=$VcpkgToolchain"
        }

        # Configure
        & cmake @cmakeArgs
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
