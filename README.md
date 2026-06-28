# Explorer++

Explorer++ is a lightweight and fast file manager for Windows.

## Features

* With the option to save to the registry or a configuration file, Explorer++ is __completely portable__
* __Tabbed browsing__ for easy management of multiple folders
* Display window shows previews of files as they are selected
* __Easy-to-remember keyboard shortcuts__ for quick navigation
* Customizable user interface
* Full drag-and-drop support with other applications, including Windows Explorer
* Advanced file operations such as merging and splitting supported
* Change file dates and attributes
* Save a directory listing
* Bookmark tabs
* __Search__ for files using their name and attributes
* Switch between icon, list, detail, thumbnail and tile view
* Filter files
* **ARM64 support**
* **Modernized build system with CMake and vcpkg support**

## Latest Builds

Latest builds are available via GitHub Actions.

## Building Explorer++

Explorer++ now uses a modern CMake build system. For detailed instructions, see [BUILDING.md](BUILDING.md).

### Quick Start (PowerShell)
The recommended way to build is using the `build.ps1` script:
```powershell
.\build.ps1
```
This will build all platforms (x64, Win32, ARM64) in both Debug and Release modes.

### Using Visual Studio 2022+
Open Visual Studio and **Open Folder** pointing to the repository root. Visual Studio will automatically configure the project using CMake. Select a preset (e.g., `x64-release`) from the configuration dropdown and build.

### Using CMake CLI
```bash
cmake --preset x64-release
cmake --build --preset x64-release
```

## Documentation

Documentation is available online at [Read the Docs](https://explorerplusplus.readthedocs.io/en/latest/).

## Contributors

* David Erceg
* Google/Jules
* B Dib
* And many other contributors.
