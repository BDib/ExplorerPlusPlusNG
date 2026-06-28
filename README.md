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
* **Modernized build system with WiX v5 and CMake support**

## Latest Builds

Latest builds are available via GitHub Actions.

## Building Explorer++

### Using PowerShell (Recommended)
Run `.\build.ps1` to build the default configuration (Release x64).
Options:
- `-Configuration [Debug|Release]`
- `-Platform [Win32|x64|ARM64]`
- `-Installer` (Builds the MSI package)
- `-Clean`

### Using Visual Studio
Open `Explorer++\Explorer++.sln` and build. Artifacts will be located in the `BIN/` directory.

### Using CMake
```bash
mkdir build
cd build
cmake .. -DCMAKE_TOOLCHAIN_FILE=C:/path/to/vcpkg/scripts/buildsystems/vcpkg.cmake
cmake --build .
```

## Documentation

Documentation is available online at [Read the Docs](https://explorerplusplus.readthedocs.io/en/latest/).

## Contributors

* David Erceg
* Google/Jules
* B Dib
* And many other contributors.
