# README

**This repository provides a structured approach to building and running C++ projects that depend on OpenCV.** Whether you are using a globally installed version of OpenCV or integrating a local version via a submodule, this guide will help you set up the environment, build the code, and ensure proper runtime configuration.

## Table of Contents

1. [Overview](#overview)  
2. [Prerequisites](#prerequisites)  
3. [Choosing Between Global and Local OpenCV](#choosing-between-global-and-local-opencv)  
4. [Global OpenCV Integration](#global-opencv-integration)  
   - [Building All Projects](#building-all-projects-with-global-opencv)  
   - [Building a Single Project](#building-a-single-project-with-global-opencv)
5. [Local OpenCV Integration (Submodule)](#local-opencv-integration-submodule)  
   - [Initializing the Submodule](#initializing-the-submodule)  
   - [Building and Installing Local OpenCV](#building-and-installing-local-opencv)  
   - [Building All Projects with Local OpenCV](#building-all-projects-with-local-opencv)  
   - [Building a Single Project with Local OpenCV](#building-a-single-project-with-local-opencv)
6. [Environment Variables and PATH Setup](#environment-variables-and-path-setup)  
   - [PowerShell](#powershell)  
   - [CMD](#cmd)  
   - [Bash](#bash)
7. [Advanced Configuration Examples](#advanced-configuration-examples)
8. [Testing and Verification Scenarios](#testing-and-verification-scenarios)
9. [Troubleshooting](#troubleshooting)
10. [Additional Tips](#additional-tips)

## Overview

This repository hosts multiple C++ projects that demonstrate OpenCV usage. The build system is powered by CMake, allowing flexibility in how you integrate OpenCV:

- **Global OpenCV:** Ideal if OpenCV is already installed on your system via package managers or installers.
- **Local OpenCV (Submodule):** Keeps projects self-contained, making them portable and consistent across machines and environments (e.g., CI servers, devcontainers).

**Key Goals:**
- Provide a reproducible build environment.
- Allow quick switching between global and local OpenCV installations.
- Offer clear instructions for configuring environment variables and paths.


## Prerequisites

- **CMake (3.10+ recommended)**
- **C++ Compiler:** MSVC on Windows or GCC/Clang on Linux.
- **Git:** For managing submodules when using local OpenCV.
- **OpenCV Installed Globally (Optional):** If you prefer using the system’s OpenCV.


## Choosing Between Global and Local OpenCV

**Global installation** is simpler if your workstation already has OpenCV set up. Projects will just need to find it via `find_package(OpenCV REQUIRED)`.

**Local installation** is recommended if:
- You need a specific OpenCV version not available globally.
- You want consistent builds across different environments (e.g., devcontainers, CI).
- You do not have administrative privileges to install system-wide dependencies.

You can easily switch by adjusting `OpenCV_DIR` and `PATH`.

---

## Global OpenCV Integration

If OpenCV is globally installed, you can build all projects at once or individually with minimal configuration.

### Building All Projects with Global OpenCV

```bash
cd ../../
cmake -S . -B build
cmake --build build --config Release
cmake --build build --config Debug
```

This top-level build command processes all subdirectories and projects in one go.

### Building a Single Project with Global OpenCV

If you only want to work on `01-playground`:

```bash
cd 01-playground
cmake -S . -B build
cmake --build build --config Release
cmake --build build --config Debug
```

Ensure that `OpenCV_DIR` points to your global OpenCV installation directory (if needed) and that your `PATH` includes the OpenCV binary directory. If these are not set, `find_package(OpenCV REQUIRED)` will fail.

---

## Local OpenCV Integration (Submodule)

When global OpenCV isn’t available or desired, you can pull OpenCV as a submodule and build it from source.

### Initializing the Submodule

```bash
git submodule update --init --recursive
```

This downloads the OpenCV code into `third-party/opencv4.10`.

### Building and Installing Local OpenCV

```bash
cd third-party/opencv4.10
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX=../install
cmake --build build --config Release
cmake --build build --config Debug
cmake --build build --config Release --target INSTALL
cmake --build build --config Debug --target INSTALL
```

**Result:** OpenCV is installed to `third-party/opencv4.10/build/install`. You’ll point `OpenCV_DIR` to this directory.

### Building All Projects with Local OpenCV

```bash
cd ../../
cmake -S . -B build
cmake --build build --config Release
cmake --build build --config Debug
```

### Building a Single Project with Local OpenCV

For example, `01-playground`:

```bash
cd 01-playground
cmake -S . -B build -DOpenCV_DIR="../third-party/opencv4.10/build/install"
cmake --build build --config Release
cmake --build build --config Debug
```

Adjust the relative path to `OpenCV_DIR` as needed based on your project’s location.


## Environment Variables and PATH Setup

To run your executables, you must ensure that OpenCV’s binaries are discoverable at runtime. This often means adding the appropriate directories to your `PATH`. Overwriting `OpenCV_DIR` ensures CMake finds the correct OpenCV installation at configure time.

**Note:** If multiple OpenCV versions coexist, ensure the correct path variables are set in your session before building or running.

### PowerShell

```powershell
$env:PATH = "${PWD}\third-party\opencv4.10\build\x64\vc17\bin;" + $env:PATH
```

### CMD

```cmd
set "PATH=C:\full\path\to\third-party\opencv4.10\build\x64\vc17\bin;%PATH%"
```

### Bash

```bash
PATH="/path/to/opencv/bin:$PATH" ./MyApp
```

## Advanced Configuration Examples

- **Using a local OpenCV in a nested project structure:**

  ```bash
  cmake -S . -B build -DOpenCV_DIR="../../third-party/opencv4.10/build/install"
  cmake --build build
  ```

- **Overwriting a global installation:**

  Set `OpenCV_DIR` to the local install path and adjust `PATH` to prioritize the local OpenCV `bin` directory over system paths.


## Testing and Verification Scenarios

These tests were performed to validate various configurations.

### TEST 1: All Projects with Global OpenCV

```powershell
cmake -S . -B build
cmake --build build
.\build\02-opencv-library\Debug\create_matrix.exe
```

**Verify:**
```powershell
# Check OpenCV_DIR in environment and in CMakeCache.txt
echo ${env:OpenCV_DIR}
Get-Content .\build\CMakeCache.txt | Select-String -Pattern OpenCV_DIR

# Check PATH includes OpenCV bin
echo ${env:PATH} | Select-String opencv
```

### TEST 2: All Projects with Local OpenCV

```powershell
cmake -S . -B build -DOpenCV_DIR="third-party/opencv4.10/build/install"
cmake --build build
.\build\02-opencv-library\Debug\create_matrix.exe
```

**Verify:** Same checks as TEST 1, ensuring the `PATH` and `OpenCV_DIR` point to the local install.

### TEST 3: Single Project with Global OpenCV

```powershell
cd 01-playground
cmake -S . -B build
cmake --build build
.\build\Debug\create_matrix.exe
```

### TEST 4: Single Project with Local OpenCV

```powershell
cd 01-playground
cmake -S . -B build -DOpenCV_DIR="../third-party/opencv4.10/build/install"
cmake --build build
.\build\Debug\create_matrix.exe
```

### TEST 5: Tests in a Devcontainer

```bash
cmake -S . -B build
cmake --build build
# Run executables as normal
```

---

## Troubleshooting

- **CMake can’t find OpenCV:**  
  Double-check `OpenCV_DIR` in `CMakeCache.txt` and ensure it’s set to the correct path. If not set, specify it manually with `-DOpenCV_DIR=...`.
  
- **Executable fails to run due to missing DLLs (Windows) or `.so` files (Linux):**  
  Ensure that the OpenCV `bin` directory is included in your `PATH`. For local builds, updating `PATH` might be required each session.
  
- **Multiple OpenCV versions conflict:**  
  Verify that `OpenCV_DIR` and `PATH` do not point to multiple installations simultaneously. Stick to one strategy (global or local) per build.

- **Permission issues (Linux):**  
  If building locally, ensure you have write permissions in `third-party/opencv4.10/build/install`.


