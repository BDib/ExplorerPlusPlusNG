cmake_minimum_required(VERSION 3.20)

# Project setup
project(ExplorerPP LANGUAGES C CXX RC)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Unicode support
add_definitions(-DUNICODE -D_UNICODE)

# Options for release mode
set(EXPLORERPP_RELEASE_MODE "" CACHE STRING "Release mode: beta or stable")
set(EXPLORERPP_BUILD_NUMBER "" CACHE STRING "Build number")

# MSVC specific settings
if(MSVC)
    add_compile_options(/W4 /permissive- /utf-8)
    # Set Runtime Library: MultiThreaded (static) for Release, MultiThreadedDebug (static) for Debug
    set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")

    # Platform-specific definitions
    if(CMAKE_SYSTEM_PROCESSOR STREQUAL "x86" OR CMAKE_GENERATOR_PLATFORM STREQUAL "Win32")
        add_definitions(-DBUILD_WIN32 -DWIN32)
    elseif(CMAKE_SYSTEM_PROCESSOR STREQUAL "AMD64" OR CMAKE_GENERATOR_PLATFORM STREQUAL "x64")
        add_definitions(-DBUILD_WIN64)
    elseif(CMAKE_SYSTEM_PROCESSOR STREQUAL "ARM64" OR CMAKE_GENERATOR_PLATFORM STREQUAL "ARM64")
        add_definitions(-DBUILD_ARM64)
    endif()

    add_definitions(-DPLATFORM_TOOLSET_VERSION=${MSVC_TOOLSET_VERSION})
    add_definitions(-DNOMINMAX -D_WIN32_WINNT=0x0A00)

    if(EXPLORERPP_RELEASE_MODE STREQUAL "beta")
        add_definitions(-DENVIRONMENT_RELEASE_BETA=1)
    elseif(EXPLORERPP_RELEASE_MODE STREQUAL "stable")
        add_definitions(-DENVIRONMENT_RELEASE_STABLE=1)
    endif()

    if(NOT EXPLORERPP_BUILD_NUMBER STREQUAL "")
        add_definitions(-DENVIRONMENT_BUILD_NUMBER=${EXPLORERPP_BUILD_NUMBER})
    endif()

    # Precompiled headers optimization
    set(CMAKE_PCH_WARN_WITH_PCH OFF)
endif()

# Output directory
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

# Dependencies (vcpkg)
find_package(Boost REQUIRED)
find_package(cereal CONFIG REQUIRED)
find_package(fmt CONFIG REQUIRED)
find_package(glog CONFIG REQUIRED)
find_package(nlohmann_json CONFIG REQUIRED)
find_package(sol2 CONFIG REQUIRED)
find_package(wil CONFIG REQUIRED)
find_package(detours CONFIG REQUIRED)
find_package(concurrencpp CONFIG REQUIRED)
find_package(Lua REQUIRED)
find_package(cppwinrt CONFIG REQUIRED)

# Helper Library
add_library(Helper STATIC)

target_sources(Helper PRIVATE
    "Explorer++/Helper/BaseWindow.cpp"
    "Explorer++/Helper/BulkClipboardWriter.cpp"
    "Explorer++/Helper/CachedIcons.cpp"
    "Explorer++/Helper/Clipboard.cpp"
    "Explorer++/Helper/ClipboardHelper.cpp"
    "Explorer++/Helper/ClipboardWatcher.cpp"
    "Explorer++/Helper/ComboBox.cpp"
    "Explorer++/Helper/ComboBoxHelper.cpp"
    "Explorer++/Helper/Console.cpp"
    "Explorer++/Helper/Controls.cpp"
    "Explorer++/Helper/DataExchangeHelper.cpp"
    "Explorer++/Helper/DataObjectImpl.cpp"
    "Explorer++/Helper/DataObjectWrapper.cpp"
    "Explorer++/Helper/DetoursHelper.cpp"
    "Explorer++/Helper/DialogSettings.cpp"
    "Explorer++/Helper/DoubleBufferedPaint.cpp"
    "Explorer++/Helper/DpiCompatibility.cpp"
    "Explorer++/Helper/DragDropHelper.cpp"
    "Explorer++/Helper/DriveInfo.cpp"
    "Explorer++/Helper/DropHandler.cpp"
    "Explorer++/Helper/DropSourceImpl.cpp"
    "Explorer++/Helper/DropTargetWindow.cpp"
    "Explorer++/Helper/EnumFormatEtcImpl.cpp"
    "Explorer++/Helper/FileActionHandler.cpp"
    "Explorer++/Helper/FileDialogs.cpp"
    "Explorer++/Helper/FileOperations.cpp"
    "Explorer++/Helper/FolderSize.cpp"
    "Explorer++/Helper/GdiplusHelper.cpp"
    "Explorer++/Helper/Helper.cpp"
    "Explorer++/Helper/ImageHelper.cpp"
    "Explorer++/Helper/KeyboardStateImpl.cpp"
    "Explorer++/Helper/ListViewHelper.cpp"
    "Explorer++/Helper/MenuHelper.cpp"
    "Explorer++/Helper/MessageForwarder.cpp"
    "Explorer++/Helper/MessageWindowHelper.cpp"
    "Explorer++/Helper/Pidl.cpp"
    "Explorer++/Helper/PidlHelper.cpp"
    "Explorer++/Helper/ProcessHelper.cpp"
    "Explorer++/Helper/ReferenceCount.cpp"
    "Explorer++/Helper/RegistrySettings.cpp"
    "Explorer++/Helper/ResizableDialogHelper.cpp"
    "Explorer++/Helper/ResourceHelper.cpp"
    "Explorer++/Helper/RichEditHelper.cpp"
    "Explorer++/Helper/ScopedBitmapLock.cpp"
    "Explorer++/Helper/ScopedRedrawDisabler.cpp"
    "Explorer++/Helper/ScopedStopSource.cpp"
    "Explorer++/Helper/ServiceProviderBase.cpp"
    "Explorer++/Helper/SetDefaultFileManager.cpp"
    "Explorer++/Helper/ShellBackgroundContextMenu.cpp"
    "Explorer++/Helper/ShellBackgroundContextMenuDelegate.cpp"
    "Explorer++/Helper/ShellContextMenu.cpp"
    "Explorer++/Helper/ShellContextMenuBuilder.cpp"
    "Explorer++/Helper/ShellContextMenuIdGenerator.cpp"
    "Explorer++/Helper/ShellContextMenuIdRemapper.cpp"
    "Explorer++/Helper/ShellDropTargetWindow.cpp"
    "Explorer++/Helper/ShellHelper.cpp"
    "Explorer++/Helper/ShellItemContextMenu.cpp"
    "Explorer++/Helper/StringHelper.cpp"
    "Explorer++/Helper/SystemClipboardStore.cpp"
    "Explorer++/Helper/SystemClockImpl.cpp"
    "Explorer++/Helper/TabHelper.cpp"
    "Explorer++/Helper/TimeHelper.cpp"
    "Explorer++/Helper/UniqueResources.cpp"
    "Explorer++/Helper/UniqueThreadId.cpp"
    "Explorer++/Helper/WilExtraTypes.cpp"
    "Explorer++/Helper/WindowHelper.cpp"
    "Explorer++/Helper/WindowSubclass.cpp"
    "Explorer++/Helper/XMLSettings.cpp"
    "Explorer++/Helper/stdafx.cpp"
)

target_include_directories(Helper PUBLIC "Explorer++/Helper" "Explorer++/ThirdParty")
target_link_libraries(Helper PUBLIC
    Boost::boost
    glog::glog
    wil::wil
    detours::detours
    Microsoft::cppwinrt
    version.lib iphlpapi.lib userenv.lib wmvcore.lib rpcrt4.lib gdiplus.lib shlwapi.lib comctl32.lib uxtheme.lib
)
target_precompile_headers(Helper PRIVATE "Explorer++/Helper/stdafx.h")

# Explorer++ Executable
add_executable(ExplorerPP WIN32)
set_target_properties(ExplorerPP PROPERTIES OUTPUT_NAME "Explorer++")

file(GLOB_RECURSE EXPLORER_SOURCES
    "Explorer++/Explorer++/*.cpp"
)

target_sources(ExplorerPP PRIVATE
    ${EXPLORER_SOURCES}
    "Explorer++/Explorer++/Explorer++Main.rc"
    "Explorer++/Explorer++/Explorer++.exe.manifest"
)

# Mirroring vcxproj exclusions for RC files
set_source_files_properties(
    "Explorer++/Explorer++/Explorer++.rc"
    "Explorer++/Explorer++/Explorer++VersionInfo.rc"
    "Explorer++/Explorer++/Explorer++_NoTranslation.rc"
    PROPERTIES HEADER_FILE_ONLY TRUE
)

target_include_directories(ExplorerPP PRIVATE 
    "Explorer++/Explorer++"
    "Explorer++/ThirdParty"
)

target_link_libraries(ExplorerPP PRIVATE
    Helper
    fmt::fmt
    cereal::cereal
    nlohmann_json::nlohmann_json
    sol2::sol2
    concurrencpp::concurrencpp
    ${LUA_LIBRARIES}
    comctl32.lib shell32.lib gdiplus.lib msimg32.lib shlwapi.lib psapi.lib mpr.lib uxtheme.lib vfw32.lib winmm.lib urlmon.lib wininet.lib rpcrt4.lib propsys.lib msxml2.lib dwmapi.lib windowscodecs.lib dbghelp.lib
)

target_precompile_headers(ExplorerPP PRIVATE "Explorer++/Explorer++/stdafx.h")

# Translation DLLs
set(LANG_CODES AR_AE CA CS DA DE EL ES FA FI FR HE HU IT JA KO NL NO PT PL PT_BR RO RU SI SV TR UK VI ZH_CN ZH_TW)

foreach(lang_code ${LANG_CODES})
    set(RC_DIR "${CMAKE_SOURCE_DIR}/Translations/Explorer++${lang_code}")
    set(RC_FILE "${RC_DIR}/Explorer++Main.rc")

    if(NOT EXISTS "${RC_FILE}")
         set(RC_FILE "${RC_DIR}/Explorer++.rc")
    endif()

    if(EXISTS "${RC_FILE}")
        add_library(ExplorerPP${lang_code} SHARED "${RC_FILE}")
        set_target_properties(ExplorerPP${lang_code} PROPERTIES 
            OUTPUT_NAME "Explorer++${lang_code}" 
            PREFIX ""
            LINK_FLAGS "/NOENTRY"
        )
        target_include_directories(ExplorerPP${lang_code} PRIVATE "Explorer++/Explorer++")
    endif()
endforeach()
