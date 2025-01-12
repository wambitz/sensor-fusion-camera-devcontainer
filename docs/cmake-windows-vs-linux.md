When using **CMake with Visual Studio** (or other multi-configuration generators), the build type **is not specified during the configuration step** because Visual Studio supports multiple configurations (e.g., Debug, Release, RelWithDebInfo) **within the same project files**. Instead, you choose the build type at **build time**.

---

### **Steps to Configure and Build on Windows with Visual Studio**

1. **Configuration Step**  
   Generate Visual Studio project files with `cmake -S . -B build`. Do not set `CMAKE_BUILD_TYPE` because it’s ignored for multi-configuration generators like Visual Studio.

   Example:
   ```bash
   cmake -S . -B build -G "Visual Studio 17 2022" -A x64
   ```
   Here:
   - `-G "Visual Studio 17 2022"` specifies the generator.
   - `-A x64` sets the platform architecture (x64, Win32, or ARM).

2. **Build Step**  
   Specify the build type (`Release`, `Debug`, etc.) when calling `cmake --build`. Use the `--config` flag to set the configuration.

   Example:
   ```bash
   cmake --build build --config Release
   ```

   - `--config Release` specifies the build type for Visual Studio. You can also use `Debug`, `RelWithDebInfo`, or `MinSizeRel`.

---

### **Why `CMAKE_BUILD_TYPE` is Ignored on Windows**
- For single-configuration generators like **Makefiles** or **Ninja**, the `CMAKE_BUILD_TYPE` variable determines the build type at configuration time.
- For multi-configuration generators like **Visual Studio** or **Xcode**, you don’t need to predefine the build type during configuration. Instead, you select the build configuration when invoking the build command or through the IDE.

---

### **Summary of Key Commands**

1. **Generate Visual Studio project files**:
   ```bash
   cmake -S . -B build -G "Visual Studio 17 2022" -A x64
   ```

2. **Build a specific configuration**:
   ```bash
   cmake --build build --config Release
   ```
   or
   ```bash
   cmake --build build --config Debug
   ```

3. **Open the Visual Studio IDE**:
   If you want to manually choose the configuration in Visual Studio:
   - Open the generated `.sln` file in Visual Studio.
   - Select the desired configuration (`Debug`, `Release`, etc.) from the dropdown menu in the toolbar.
   - Build the project from within the IDE.

---

### **Common Build Types**
When using Visual Studio, you have these standard build types:
- **Debug**: Includes debug symbols, no optimizations.
- **Release**: Optimized code, no debug symbols.
- **RelWithDebInfo**: Optimized code **with debug symbols** (useful for profiling and debugging).
- **MinSizeRel**: Optimized for minimum binary size.

---

### **Recap**
- On Windows with Visual Studio, you specify the build configuration **at build time** using `--config`.
- Example:
   ```bash
   cmake --build build --config Release
   ```
- Alternatively, select the build type directly in the Visual Studio IDE.

---

To keep both **Release** and **Debug** binaries on Linux, you need to use a **multi-configuration build setup** or organize your builds using separate output directories.

### **Option 1: Use CMake's Multi-Config Generators**  
While single-configuration generators like Makefiles and Ninja are common on Linux, CMake **supports multi-configuration generators** like **Ninja Multi-Config** starting with CMake 3.17.

#### Steps:
1. **Configure with the Multi-Config Generator**  
   Use `-G "Ninja Multi-Config"` instead of the standard Ninja or Makefile generator.

   ```bash
   cmake -S . -B build -G "Ninja Multi-Config"
   ```

2. **Build Specific Configurations**  
   When building, you specify the desired configuration (e.g., Debug or Release) with `--config`.

   Example:
   ```bash
   cmake --build build --config Debug
   cmake --build build --config Release
   ```

3. **Output Location**  
   The binaries for each configuration will be placed in separate folders within the build directory:
   ```
   build/
   ├── Debug/
   │   └── my_executable
   └── Release/
       └── my_executable
   ```

---

### **Option 2: Separate Build Directories for Debug and Release**  
If you are using a **single-configuration generator** like Makefiles or Ninja (default on Linux), you can maintain separate build directories for each configuration.

#### Steps:
1. **Configure Debug and Release in Separate Directories**  
   Run the configuration step twice with different `CMAKE_BUILD_TYPE` values, each targeting a unique build directory.

   ```bash
   cmake -S . -B build/debug -DCMAKE_BUILD_TYPE=Debug
   cmake -S . -B build/release -DCMAKE_BUILD_TYPE=Release
   ```

2. **Build Debug and Release Binaries**  
   Build from each respective directory:

   ```bash
   cmake --build build/debug
   cmake --build build/release
   ```

3. **Result**  
   The output binaries will be kept separate:
   ```
   build/
   ├── debug/
   │   └── my_executable   # Debug binary
   └── release/
       └── my_executable   # Release binary
   ```

---

### **Option 3: Specify Output Paths for Each Configuration**
If you want to keep all configurations in the same build directory, you can use CMake variables like `CMAKE_RUNTIME_OUTPUT_DIRECTORY` to explicitly set where binaries are output.

#### Steps:
1. **Modify `CMakeLists.txt`**  
   Add the following to your `CMakeLists.txt` to configure different output directories:

   ```cmake
   set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/bin/Debug)
   set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/bin/Release)
   ```

   This tells CMake to place:
   - Debug binaries in `build/bin/Debug`
   - Release binaries in `build/bin/Release`

2. **Configure and Build**  
   You still need separate configurations, but now CMake will respect the output paths:

   ```bash
   cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug
   cmake --build build

   cmake -S . -B build -DCMAKE_BUILD_TYPE=Release
   cmake --build build
   ```

3. **Result**  
   Your binaries are organized under `bin/`:
   ```
   build/
   ├── bin/
   │   ├── Debug/
   │   │   └── my_executable
   │   └── Release/
   │       └── my_executable
   ```

---

### **Recommendation**
The most common and cleanest approach for Linux is **Option 2: Separate Build Directories**. It avoids conflicts and works naturally with single-configuration generators like Makefiles or Ninja.

If you're open to using **multi-config generators**, **Option 1** with **Ninja Multi-Config** provides a more modern solution.

Let me know if you'd like a deeper dive into any of these approaches! 🚀