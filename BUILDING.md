# Building Explorer++

Explorer++ uses a modern CMake build system and integrates with [vcpkg](https://vcpkg.io/) for dependency management. It supports building for **Win32 (x86)**, **x64**, and **ARM64** architectures.

## Requirements

- **Visual Studio 2022+** (Community, Professional, or Enterprise).
  - Install the **"Desktop development with C++"** workload.
  - (Optional) For ARM64 support, ensure **"MSVC v143 - VS 2022 C++ ARM64 build tools"** is selected.
- **Windows 10/11 SDK** (Latest version recommended).
- **CMake 3.21+** (Included with Visual Studio).

## Setup

1.  **Clone the repository** with submodules:
    ```bash
    git clone --recurse-submodules https://github.com/derceg/explorerplusplus.git
    cd explorerplusplus
    ```

2.  **Initialize vcpkg** (required if not using a system-wide vcpkg):
    - PowerShell: `.\Explorer++\ThirdParty\vcpkg\bootstrap-vcpkg.bat`
    - Bash: `./Explorer++/ThirdParty/vcpkg/bootstrap-vcpkg.sh`

## Ways to Build

### 1. Using PowerShell Script (Recommended)
The `build.ps1` script automates the entire process using CMake presets.

- **Build all platforms and configurations:**
  ```powershell
  .\build.ps1
  ```
- **Build specific platform/configuration:**
  ```powershell
  .\build.ps1 -Platforms x64 -Configurations release
  ```
- **Build with custom vcpkg toolchain:**
  ```powershell
  .\build.ps1 -VcpkgToolchain C:/vcpkg/scripts/buildsystems/vcpkg.cmake
  ```

### 2. Using Visual Studio 2022+ (CMake Integration)
1. Open Visual Studio.
2. Select **File > Open > Folder...** and choose the root directory of the repository.
3. Visual Studio will automatically detect the `CMakeLists.txt` and `CMakePresets.json`.
4. Use the **Configuration Dropdown** in the toolbar to select your desired target (e.g., `x64-release`, `win32-debug`).
5. Go to **Build > Build All**.

### 3. Using CMake Command Line
You can build manually using the provided presets.

- **Configure:**
  ```bash
  cmake --preset x64-release
  ```
- **Build:**
  ```bash
  cmake --build --preset x64-release
  ```

*Note: If vcpkg is not automatically detected, provide the toolchain file:*
```bash
cmake --preset x64-release -DCMAKE_TOOLCHAIN_FILE=C:/path/to/vcpkg/scripts/buildsystems/vcpkg.cmake
```

### 4. Using MSVC Build Tools (Command Line)
Open a **Developer Command Prompt for VS 2022** and follow the CMake Command Line instructions above.

## Output Artifacts

All build artifacts are located in the `build/` directory under their respective preset names:
- **Executables & DLLs:** `build/{preset-name}/bin/`
- **Libraries:** `build/{preset-name}/lib/`

## Translations

Building the `ExplorerPP` target or using the build presets will automatically build all **29 Translation DLLs**. These are placed in the same `bin/` directory as the main executable.

## Tests

Unit tests are supported via GoogleTest (integrated through vcpkg). You can run tests through Visual Studio's Test Explorer or via `ctest` in the build directory.
