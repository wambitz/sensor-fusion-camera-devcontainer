## External Project

### Attempt 1: 

```cmake
ExternalProject_Add(
    opencv_external
    # PREFIX ${CMAKE_BINARY_DIR}/third-party/opencv_build
    SOURCE_DIR ${CMAKE_SOURCE_DIR}/third-party/opencv4.10
    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${THIRD_PARTY_INSTALL_DIR}/opencv4
               # -DCMAKE_BUILD_TYPE=Release
               # -DCMAKE_CONFIGURATION_TYPES=Release # If this is not set it will attempt to build other configurations on Windows and cause and error
               -DBUILD_SHARED_LIBS=ON
               -DBUILD_TEST=OFF
               -DBUILD_EXAMPLES=OFF
)
```

Commands:

```bash
cmake -S . -B build
cmake --build build
cd 02-opencv-library
cmake -S . -B build   
```

We get errors:

```powershell
PS C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library> cmake -S . -B build    
-- Building for: Visual Studio 17 2022
-- Selecting Windows SDK version 10.0.22621.0 to target Windows 10.0.22631.
-- The CXX compiler identification is MSVC 19.35.32217.1
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Check for working CXX compiler: C:/Program Files/Microsoft Visual Studio/2022/Community/VC/Tools/MSVC/14.35.32215/bin/Hostx64/x64/cl.exe - skipped
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- OpenCV_DIR is not set. Attempting to find OpenCV globally...
CMake Warning at CMakeLists.txt:22 (message):
  OpenCV not found globally.  Trying local installation...


-- Found OpenCV: 4.10.0
-- OpenCV include path: C:/Users/wambe/Workspace/Udacity/SensorFusion/03_Camera/sfnd-camera-devcontainer/third-party/install/opencv4/include
-- OpenCV libraries: opencv_calib3d;opencv_core;opencv_dnn;opencv_features2d;opencv_flann;opencv_gapi;opencv_highgui;opencv_imgcodecs;opencv_imgproc;opencv_ml;opencv_objdetect;opencv_photo;opencv_stitching;opencv_video;opencv_videoio
-- Configuring done (3.0s)
CMake Error in CMakeLists.txt:
  IMPORTED_IMPLIB not set for imported target "opencv_calib3d" configuration
  "MinSizeRel".


CMake Error in CMakeLists.txt:
  IMPORTED_IMPLIB not set for imported target "opencv_core" configuration
  "MinSizeRel".


CMake Error in CMakeLists.txt:
  IMPORTED_IMPLIB not set for imported target "opencv_dnn" configuration
  "MinSizeRel".

...

Make Error in CMakeLists.txt:
  IMPORTED_IMPLIB not set for imported target "opencv_gapi" configuration
  "RelWithDebInfo".


CMake Error in CMakeLists.txt:
  IMPORTED_IMPLIB not set for imported target "opencv_highgui" configuration
  "RelWithDebInfo".


CMake Error in CMakeLists.txt:
  IMPORTED_IMPLIB not set for imported target "opencv_imgcodecs"
  configuration "RelWithDebInfo".

...

-- Generating done (0.3s)
CMake Warning:
  Manually-specified variables were not used by the project:

    CMAKE_BUILD_TYPE

```



### Attempt 2

```cmake
ExternalProject_Add(
    opencv_external
    # PREFIX ${CMAKE_BINARY_DIR}/third-party/opencv_build
    SOURCE_DIR ${CMAKE_SOURCE_DIR}/third-party/opencv4.10
    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${THIRD_PARTY_INSTALL_DIR}/opencv4
               # -DCMAKE_BUILD_TYPE=Release
               # -DCMAKE_CONFIGURATION_TYPES=Release # If this is not set it will attempt to build other configurations on Windows and cause and error
               -DBUILD_SHARED_LIBS=ON
               -DBUILD_TEST=OFF
               -DBUILD_EXAMPLES=OFF
)
```

Commands:

```bash
cmake -S . -B build
cmake --build build --config Release
cd 02-opencv-library
cmake -S . -B build   # We passed this point
cmake --build build   # ERROR here
```

ERROR:

```powershell
PS C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library> cmake --build build 
MSBuild version 17.5.1+f6fdcf537 for .NET Framework

  Checking Build System
  Building Custom Rule C:/Users/wambe/Workspace/Udacity/SensorFusion/03_Camera/sfnd-camera-devcontainer/02-opencv-library/CMakeLists.txt
  change_pixels.cpp
change_pixels.obj : error LNK2019: unresolved external symbol "class cv::debug_build_guard::_InputOutputArray const & __cdecl cv::noArray(void)" (?noArray@cv@@YAAEBV_Inpu
tOutputArray@debug_build_guard@1@XZ) referenced in function "void __cdecl changePixels(void)" (?changePixels@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Cam 
era\sfnd-camera-devcontainer\02-opencv-library\build\change_pixels.vcxproj]
change_pixels.obj : error LNK2019: unresolved external symbol "public: class cv::Mat & __cdecl cv::Mat::setTo(class cv::debug_build_guard::_InputArray const &,class cv::d 
ebug_build_guard::_InputArray const &)" (?setTo@Mat@cv@@QEAAAEAV12@AEBV_InputArray@debug_build_guard@2@0@Z) referenced in function "void __cdecl changePixels(void)" (?cha 
ngePixels@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\change_pixels.vcxproj]
change_pixels.obj : error LNK2019: unresolved external symbol "void __cdecl cv::imshow(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<cha 
r> > const &,class cv::debug_build_guard::_InputArray const &)" (?imshow@cv@@YAXAEBV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@AEBV_InputArray@debug_bui 
ld_guard@1@@Z) referenced in function "void __cdecl changePixels(void)" (?changePixels@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcon 
tainer\02-opencv-library\build\change_pixels.vcxproj]
C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\Debug\change_pixels.exe : fatal error LNK1120: 3 unresolved exter 
nals [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\change_pixels.vcxproj]
  Building Custom Rule C:/Users/wambe/Workspace/Udacity/SensorFusion/03_Camera/sfnd-camera-devcontainer/02-opencv-library/CMakeLists.txt
  create_matrix.cpp
create_matrix.obj : error LNK2019: unresolved external symbol "class cv::debug_build_guard::_InputOutputArray const & __cdecl cv::noArray(void)" (?noArray@cv@@YAAEBV_Inpu
tOutputArray@debug_build_guard@1@XZ) referenced in function "void __cdecl createMatrix1(void)" (?createMatrix1@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_C 
amera\sfnd-camera-devcontainer\02-opencv-library\build\create_matrix.vcxproj]
create_matrix.obj : error LNK2019: unresolved external symbol "public: class cv::Mat & __cdecl cv::Mat::setTo(class cv::debug_build_guard::_InputArray const &,class cv::d 
ebug_build_guard::_InputArray const &)" (?setTo@Mat@cv@@QEAAAEAV12@AEBV_InputArray@debug_build_guard@2@0@Z) referenced in function "void __cdecl createMatrix1(void)" (?cr 
eateMatrix1@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\create_matrix.vcxproj]
create_matrix.obj : error LNK2019: unresolved external symbol "void __cdecl cv::imshow(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<cha 
r> > const &,class cv::debug_build_guard::_InputArray const &)" (?imshow@cv@@YAXAEBV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@AEBV_InputArray@debug_bui 
ld_guard@1@@Z) referenced in function "void __cdecl createMatrix1(void)" (?createMatrix1@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devc 
ontainer\02-opencv-library\build\create_matrix.vcxproj]
C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\Debug\create_matrix.exe : fatal error LNK1120: 3 unresolved exter 
nals [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\create_matrix.vcxproj]
  Building Custom Rule C:/Users/wambe/Workspace/Udacity/SensorFusion/03_Camera/sfnd-camera-devcontainer/02-opencv-library/CMakeLists.txt
  load_image_1.cpp
load_image_1.obj : error LNK2019: unresolved external symbol "void __cdecl cv::imshow(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char
> > const &,class cv::debug_build_guard::_InputArray const &)" (?imshow@cv@@YAXAEBV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@AEBV_InputArray@debug_buil 
d_guard@1@@Z) referenced in function "void __cdecl loadImage1(void)" (?loadImage1@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontaine 
r\02-opencv-library\build\load_image_1.vcxproj]
C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\Debug\load_image_1.exe : fatal error LNK1120: 1 unresolved extern 
als [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\load_image_1.vcxproj]
  Building Custom Rule C:/Users/wambe/Workspace/Udacity/SensorFusion/03_Camera/sfnd-camera-devcontainer/02-opencv-library/CMakeLists.txt
  load_image_2.cpp
load_image_2.obj : error LNK2019: unresolved external symbol "void __cdecl cv::imshow(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char
> > const &,class cv::debug_build_guard::_InputArray const &)" (?imshow@cv@@YAXAEBV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@AEBV_InputArray@debug_buil 
d_guard@1@@Z) referenced in function "void __cdecl loadImage2(void)" (?loadImage2@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontaine 
r\02-opencv-library\build\load_image_2.vcxproj]
C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\Debug\load_image_2.exe : fatal error LNK1120: 1 unresolved extern 
als [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\load_image_2.vcxproj]
  Building Custom Rule C:/Users/wambe/Workspace/Udacity/SensorFusion/03_Camera/sfnd-camera-devcontainer/02-opencv-library/CMakeLists.txt
  load_image_3.cpp
load_image_3.obj : error LNK2019: unresolved external symbol "void __cdecl cv::imshow(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char
> > const &,class cv::debug_build_guard::_InputArray const &)" (?imshow@cv@@YAXAEBV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@AEBV_InputArray@debug_buil 
d_guard@1@@Z) referenced in function "void __cdecl loadImage3(void)" (?loadImage3@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontaine 
r\02-opencv-library\build\load_image_3.vcxproj]
C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\Debug\load_image_3.exe : fatal error LNK1120: 1 unresolved extern 
als [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\load_image_3.vcxproj]
```

```bash
cmake -S . -B build
cmake --build build --config Release
cd 02-opencv-library
cmake -S . -B build   # We passed this point
cmake --build build --config Release
```

SUCCES!!

```powershell
PS C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library> cmake --build build --config Release
MSBuild version 17.5.1+f6fdcf537 for .NET Framework

  Checking Build System
  Building Custom Rule C:/Users/wambe/Workspace/Udacity/SensorFusion/03_Camera/sfnd-camera-devcontainer/02-opencv-library/CMakeLists.txt
  change_pixels.cpp
  change_pixels.vcxproj -> C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\Release\change_pixels.exe
  Building Custom Rule C:/Users/wambe/Workspace/Udacity/SensorFusion/03_Camera/sfnd-camera-devcontainer/02-opencv-library/CMakeLists.txt
  create_matrix.cpp
  create_matrix.vcxproj -> C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\Release\create_matrix.exe
  Building Custom Rule C:/Users/wambe/Workspace/Udacity/SensorFusion/03_Camera/sfnd-camera-devcontainer/02-opencv-library/CMakeLists.txt
  load_image_1.cpp
  load_image_1.vcxproj -> C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\Release\load_image_1.exe
  Building Custom Rule C:/Users/wambe/Workspace/Udacity/SensorFusion/03_Camera/sfnd-camera-devcontainer/02-opencv-library/CMakeLists.txt
  load_image_2.cpp
  load_image_2.vcxproj -> C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\Release\load_image_2.exe
  Building Custom Rule C:/Users/wambe/Workspace/Udacity/SensorFusion/03_Camera/sfnd-camera-devcontainer/02-opencv-library/CMakeLists.txt
  load_image_3.cpp
  load_image_3.vcxproj -> C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\Release\load_image_3.exe
  Building Custom Rule C:/Users/wambe/Workspace/Udacity/SensorFusion/03_Camera/sfnd-camera-devcontainer/02-opencv-library/CMakeLists.txt
```

### Attempt 3

```cmake
ExternalProject_Add(
    opencv_external
    PREFIX ${CMAKE_BINARY_DIR}/third-party/opencv4.10
    SOURCE_DIR ${CMAKE_SOURCE_DIR}/third-party/opencv4.10
    CMAKE_ARGS 
        -DCMAKE_INSTALL_PREFIX=${THIRD_PARTY_INSTALL_DIR}/opencv4.10
        # -DCMAKE_BUILD_TYPE=Release
        # -DCMAKE_CONFIGURATION_TYPES=Release # If this is not set it will attempt to build other configurations on Windows and cause and error
        -DBUILD_SHARED_LIBS=ON
        -DBUILD_TEST=OFF
        -DBUILD_EXAMPLES=OFF
        BUILD_COMMAND      ${CMAKE_COMMAND} --build . --config Release
        #INSTALL_COMMAND    ${CMAKE_COMMAND} --build . --target install --config Release
)
```


Commands:

```bash
cmake -S . -B build
cmake --build build
cd 02-opencv-library
cmake -S . -B build   # We passed this point
# cmake --build build   # ERROR here
```

Same errors:

```powershell

...

CMake Error in CMakeLists.txt:
  IMPORTED_IMPLIB not set for imported target "opencv_objdetect"
  configuration "RelWithDebInfo".
...

```

### Attempt 4

```cmake
ExternalProject_Add(
    opencv_external
    PREFIX ${CMAKE_BINARY_DIR}/third-party/opencv4.10
    SOURCE_DIR ${CMAKE_SOURCE_DIR}/third-party/opencv4.10
    CMAKE_ARGS 
        -DCMAKE_INSTALL_PREFIX=${THIRD_PARTY_INSTALL_DIR}/opencv4.10
        # -DCMAKE_BUILD_TYPE=Release
        # -DCMAKE_CONFIGURATION_TYPES=Release # If this is not set it will attempt to build other configurations on Windows and cause and error
        -DBUILD_SHARED_LIBS=ON
        -DBUILD_TEST=OFF
        -DBUILD_EXAMPLES=OFF
        BUILD_COMMAND      ${CMAKE_COMMAND} --build . --config Release
        INSTALL_COMMAND    ${CMAKE_COMMAND} --build . --target install --config Release
)
```


Commands:

```bash
cmake -S . -B build
cmake --build build
cd 02-opencvlibrary
cmake -S . -B build   # We passed this point
cmake --build build   # ERROR here
```

Errors

```powershell

PS C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library> cmake --build build
MSBuild version 17.5.1+f6fdcf537 for .NET Framework

  Checking Build System
  Building Custom Rule C:/Users/wambe/Workspace/Udacity/SensorFusion/03_Camera/sfnd-camera-devcontainer/02-opencv-library/CMakeLists.txt
  change_pixels.cpp
change_pixels.obj : error LNK2019: unresolved external symbol "class cv::debug_build_guard::_InputOutputArray const & __cdecl cv::noArray(void)" (?noArray@cv@@YAAEBV_Inpu
tOutputArray@debug_build_guard@1@XZ) referenced in function "void __cdecl changePixels(void)" (?changePixels@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Cam 
era\sfnd-camera-devcontainer\02-opencv-library\build\change_pixels.vcxproj]
change_pixels.obj : error LNK2019: unresolved external symbol "public: class cv::Mat & __cdecl cv::Mat::setTo(class cv::debug_build_guard::_InputArray const &,class cv::d 
ebug_build_guard::_InputArray const &)" (?setTo@Mat@cv@@QEAAAEAV12@AEBV_InputArray@debug_build_guard@2@0@Z) referenced in function "void __cdecl changePixels(void)" (?cha 
ngePixels@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\change_pixels.vcxproj]
change_pixels.obj : error LNK2019: unresolved external symbol "void __cdecl cv::imshow(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<cha 
r> > const &,class cv::debug_build_guard::_InputArray const &)" (?imshow@cv@@YAXAEBV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@AEBV_InputArray@debug_bui 
ld_guard@1@@Z) referenced in function "void __cdecl changePixels(void)" (?changePixels@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcon 
tainer\02-opencv-library\build\change_pixels.vcxproj]
C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\Debug\change_pixels.exe : fatal error LNK1120: 3 unresolved exter 
nals [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\change_pixels.vcxproj]
  Building Custom Rule C:/Users/wambe/Workspace/Udacity/SensorFusion/03_Camera/sfnd-camera-devcontainer/02-opencv-library/CMakeLists.txt
  create_matrix.cpp
create_matrix.obj : error LNK2019: unresolved external symbol "class cv::debug_build_guard::_InputOutputArray const & __cdecl cv::noArray(void)" (?noArray@cv@@YAAEBV_Inpu
tOutputArray@debug_build_guard@1@XZ) referenced in function "void __cdecl createMatrix1(void)" (?createMatrix1@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_C 
amera\sfnd-camera-devcontainer\02-opencv-library\build\create_matrix.vcxproj]
create_matrix.obj : error LNK2019: unresolved external symbol "public: class cv::Mat & __cdecl cv::Mat::setTo(class cv::debug_build_guard::_InputArray const &,class cv::d 
ebug_build_guard::_InputArray const &)" (?setTo@Mat@cv@@QEAAAEAV12@AEBV_InputArray@debug_build_guard@2@0@Z) referenced in function "void __cdecl createMatrix1(void)" (?cr 
eateMatrix1@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\create_matrix.vcxproj]
create_matrix.obj : error LNK2019: unresolved external symbol "void __cdecl cv::imshow(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<cha 
r> > const &,class cv::debug_build_guard::_InputArray const &)" (?imshow@cv@@YAXAEBV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@AEBV_InputArray@debug_bui 
ld_guard@1@@Z) referenced in function "void __cdecl createMatrix1(void)" (?createMatrix1@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devc 
ontainer\02-opencv-library\build\create_matrix.vcxproj]
C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\Debug\create_matrix.exe : fatal error LNK1120: 3 unresolved exter 
nals [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\create_matrix.vcxproj]
  Building Custom Rule C:/Users/wambe/Workspace/Udacity/SensorFusion/03_Camera/sfnd-camera-devcontainer/02-opencv-library/CMakeLists.txt
  load_image_1.cpp
load_image_1.obj : error LNK2019: unresolved external symbol "void __cdecl cv::imshow(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char
> > const &,class cv::debug_build_guard::_InputArray const &)" (?imshow@cv@@YAXAEBV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@AEBV_InputArray@debug_buil 
d_guard@1@@Z) referenced in function "void __cdecl loadImage1(void)" (?loadImage1@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontaine 
r\02-opencv-library\build\load_image_1.vcxproj]
C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\Debug\load_image_1.exe : fatal error LNK1120: 1 unresolved extern 
als [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\load_image_1.vcxproj]
  Building Custom Rule C:/Users/wambe/Workspace/Udacity/SensorFusion/03_Camera/sfnd-camera-devcontainer/02-opencv-library/CMakeLists.txt
  load_image_2.cpp
load_image_2.obj : error LNK2019: unresolved external symbol "void __cdecl cv::imshow(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char
> > const &,class cv::debug_build_guard::_InputArray const &)" (?imshow@cv@@YAXAEBV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@AEBV_InputArray@debug_buil 
d_guard@1@@Z) referenced in function "void __cdecl loadImage2(void)" (?loadImage2@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontaine 
r\02-opencv-library\build\load_image_2.vcxproj]
C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\Debug\load_image_2.exe : fatal error LNK1120: 1 unresolved extern 
als [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\load_image_2.vcxproj]
  Building Custom Rule C:/Users/wambe/Workspace/Udacity/SensorFusion/03_Camera/sfnd-camera-devcontainer/02-opencv-library/CMakeLists.txt
  load_image_3.cpp
load_image_3.obj : error LNK2019: unresolved external symbol "void __cdecl cv::imshow(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char
> > const &,class cv::debug_build_guard::_InputArray const &)" (?imshow@cv@@YAXAEBV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@AEBV_InputArray@debug_buil 
d_guard@1@@Z) referenced in function "void __cdecl loadImage3(void)" (?loadImage3@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontaine 
r\02-opencv-library\build\load_image_3.vcxproj]
C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\Debug\load_image_3.exe : fatal error LNK1120: 1 unresolved extern 
als [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\load_image_3.vcxproj]

```

Commands:

```bash
cmake -S . -B build
cmake --build build
cd 02-opencv-library
cmake -S . -B build   # We passed this point
cmake --build build  --config Release
```

SUCCESS!!

```bash
cmake --build build  --config Debug # ERROR here
```

### Attemp 5

Try this:

```cmake
ExternalProject_Add(
    opencv_external
    PREFIX ${CMAKE_BINARY_DIR}/third-party/opencv4.10
    SOURCE_DIR ${CMAKE_SOURCE_DIR}/third-party/opencv4.10
    CMAKE_ARGS 
        -DCMAKE_INSTALL_PREFIX=${THIRD_PARTY_INSTALL_DIR}/opencv4.10
        # -DCMAKE_BUILD_TYPE=Release
        # -DCMAKE_CONFIGURATION_TYPES=Release # If this is not set it will attempt to build other configurations on Windows and cause and error
        -DBUILD_SHARED_LIBS=ON
        -DBUILD_TEST=OFF
        -DBUILD_EXAMPLES=OFF
        BUILD_COMMAND      ${CMAKE_COMMAND} --build . --config Release
        INSTALL_COMMAND    ${CMAKE_COMMAND} --build . --target install --config Release
)
```


Commands:

```bash
cmake -S . -B build
cmake --build build --target opencv_external
cd 02-opencv-library
cmake -S . -B build   # We passed this point
cmake --build build   # ERROR here
```

ERROR:

```powershell
PS C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library> cmake --build build
MSBuild version 17.5.1+f6fdcf537 for .NET Framework

  Checking Build System
  Building Custom Rule C:/Users/wambe/Workspace/Udacity/SensorFusion/03_Camera/sfnd-camera-devcontainer/02-opencv-library/CMakeLists.txt
  change_pixels.cpp
change_pixels.obj : error LNK2019: unresolved external symbol "class cv::debug_build_guard::_InputOutputArray const & __cdecl cv::noArray(void)" (?noArray@cv@@YAAEBV_Inpu
tOutputArray@debug_build_guard@1@XZ) referenced in function "void __cdecl changePixels(void)" (?changePixels@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Cam 
era\sfnd-camera-devcontainer\02-opencv-library\build\change_pixels.vcxproj]
change_pixels.obj : error LNK2019: unresolved external symbol "public: class cv::Mat & __cdecl cv::Mat::setTo(class cv::debug_build_guard::_InputArray const &,class cv::d 
ebug_build_guard::_InputArray const &)" (?setTo@Mat@cv@@QEAAAEAV12@AEBV_InputArray@debug_build_guard@2@0@Z) referenced in function "void __cdecl changePixels(void)" (?cha 
ngePixels@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\change_pixels.vcxproj]
change_pixels.obj : error LNK2019: unresolved external symbol "void __cdecl cv::imshow(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<cha 
r> > const &,class cv::debug_build_guard::_InputArray const &)" (?imshow@cv@@YAXAEBV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@AEBV_InputArray@debug_bui 
ld_guard@1@@Z) referenced in function "void __cdecl changePixels(void)" (?changePixels@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcon 
tainer\02-opencv-library\build\change_pixels.vcxproj]
C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\Debug\change_pixels.exe : fatal error LNK1120: 3 unresolved exter 
nals [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\change_pixels.vcxproj]
  Building Custom Rule C:/Users/wambe/Workspace/Udacity/SensorFusion/03_Camera/sfnd-camera-devcontainer/02-opencv-library/CMakeLists.txt
  create_matrix.cpp
create_matrix.obj : error LNK2019: unresolved external symbol "class cv::debug_build_guard::_InputOutputArray const & __cdecl cv::noArray(void)" (?noArray@cv@@YAAEBV_Inpu
tOutputArray@debug_build_guard@1@XZ) referenced in function "void __cdecl createMatrix1(void)" (?createMatrix1@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_C 
amera\sfnd-camera-devcontainer\02-opencv-library\build\create_matrix.vcxproj]
create_matrix.obj : error LNK2019: unresolved external symbol "public: class cv::Mat & __cdecl cv::Mat::setTo(class cv::debug_build_guard::_InputArray const &,class cv::d 
ebug_build_guard::_InputArray const &)" (?setTo@Mat@cv@@QEAAAEAV12@AEBV_InputArray@debug_build_guard@2@0@Z) referenced in function "void __cdecl createMatrix1(void)" (?cr 
eateMatrix1@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\create_matrix.vcxproj]
create_matrix.obj : error LNK2019: unresolved external symbol "void __cdecl cv::imshow(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<cha 
r> > const &,class cv::debug_build_guard::_InputArray const &)" (?imshow@cv@@YAXAEBV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@AEBV_InputArray@debug_bui 
ld_guard@1@@Z) referenced in function "void __cdecl createMatrix1(void)" (?createMatrix1@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devc 
ontainer\02-opencv-library\build\create_matrix.vcxproj]
C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\Debug\create_matrix.exe : fatal error LNK1120: 3 unresolved exter 
nals [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\create_matrix.vcxproj]
  Building Custom Rule C:/Users/wambe/Workspace/Udacity/SensorFusion/03_Camera/sfnd-camera-devcontainer/02-opencv-library/CMakeLists.txt
  load_image_1.cpp
load_image_1.obj : error LNK2019: unresolved external symbol "void __cdecl cv::imshow(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char
> > const &,class cv::debug_build_guard::_InputArray const &)" (?imshow@cv@@YAXAEBV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@AEBV_InputArray@debug_buil 
d_guard@1@@Z) referenced in function "void __cdecl loadImage1(void)" (?loadImage1@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontaine 
r\02-opencv-library\build\load_image_1.vcxproj]
C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\Debug\load_image_1.exe : fatal error LNK1120: 1 unresolved extern 
als [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\load_image_1.vcxproj]
  Building Custom Rule C:/Users/wambe/Workspace/Udacity/SensorFusion/03_Camera/sfnd-camera-devcontainer/02-opencv-library/CMakeLists.txt
  load_image_2.cpp
load_image_2.obj : error LNK2019: unresolved external symbol "void __cdecl cv::imshow(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char
> > const &,class cv::debug_build_guard::_InputArray const &)" (?imshow@cv@@YAXAEBV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@AEBV_InputArray@debug_buil 
d_guard@1@@Z) referenced in function "void __cdecl loadImage2(void)" (?loadImage2@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontaine 
r\02-opencv-library\build\load_image_2.vcxproj]
C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\Debug\load_image_2.exe : fatal error LNK1120: 1 unresolved extern 
als [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\load_image_2.vcxproj]
  Building Custom Rule C:/Users/wambe/Workspace/Udacity/SensorFusion/03_Camera/sfnd-camera-devcontainer/02-opencv-library/CMakeLists.txt
  load_image_3.cpp
load_image_3.obj : error LNK2019: unresolved external symbol "void __cdecl cv::imshow(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char
> > const &,class cv::debug_build_guard::_InputArray const &)" (?imshow@cv@@YAXAEBV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@AEBV_InputArray@debug_buil 
d_guard@1@@Z) referenced in function "void __cdecl loadImage3(void)" (?loadImage3@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontaine 
r\02-opencv-library\build\load_image_3.vcxproj]
C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\Debug\load_image_3.exe : fatal error LNK1120: 1 unresolved extern 
als [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\load_image_3.vcxproj]
```

```bash
cmake --build build  --config Release 
```

SUCCESS!!


```bash
cmake --build build  --config Debug # ERROR here
```

```powershell
PS C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library> cmake --build build  --config Debug 
MSBuild version 17.5.1+f6fdcf537 for .NET Framework

change_pixels.obj : error LNK2019: unresolved external symbol "class cv::debug_build_guard::_InputOutputArray const & __cdecl cv::noArray(void)" (?noArray@cv@@YAAEBV_Inpu
tOutputArray@debug_build_guard@1@XZ) referenced in function "void __cdecl changePixels(void)" (?changePixels@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Cam 
era\sfnd-camera-devcontainer\02-opencv-library\build\change_pixels.vcxproj]
change_pixels.obj : error LNK2019: unresolved external symbol "public: class cv::Mat & __cdecl cv::Mat::setTo(class cv::debug_build_guard::_InputArray const &,class cv::d 
ebug_build_guard::_InputArray const &)" (?setTo@Mat@cv@@QEAAAEAV12@AEBV_InputArray@debug_build_guard@2@0@Z) referenced in function "void __cdecl changePixels(void)" (?cha 
ngePixels@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\change_pixels.vcxproj]
change_pixels.obj : error LNK2019: unresolved external symbol "void __cdecl cv::imshow(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<cha 
r> > const &,class cv::debug_build_guard::_InputArray const &)" (?imshow@cv@@YAXAEBV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@AEBV_InputArray@debug_bui 
ld_guard@1@@Z) referenced in function "void __cdecl changePixels(void)" (?changePixels@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcon 
tainer\02-opencv-library\build\change_pixels.vcxproj]
C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\Debug\change_pixels.exe : fatal error LNK1120: 3 unresolved exter 
nals [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\change_pixels.vcxproj]
create_matrix.obj : error LNK2019: unresolved external symbol "class cv::debug_build_guard::_InputOutputArray const & __cdecl cv::noArray(void)" (?noArray@cv@@YAAEBV_Inpu
tOutputArray@debug_build_guard@1@XZ) referenced in function "void __cdecl createMatrix1(void)" (?createMatrix1@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_C 
amera\sfnd-camera-devcontainer\02-opencv-library\build\create_matrix.vcxproj]
create_matrix.obj : error LNK2019: unresolved external symbol "public: class cv::Mat & __cdecl cv::Mat::setTo(class cv::debug_build_guard::_InputArray const &,class cv::d 
ebug_build_guard::_InputArray const &)" (?setTo@Mat@cv@@QEAAAEAV12@AEBV_InputArray@debug_build_guard@2@0@Z) referenced in function "void __cdecl createMatrix1(void)" (?cr 
eateMatrix1@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\create_matrix.vcxproj]
create_matrix.obj : error LNK2019: unresolved external symbol "void __cdecl cv::imshow(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<cha 
r> > const &,class cv::debug_build_guard::_InputArray const &)" (?imshow@cv@@YAXAEBV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@AEBV_InputArray@debug_bui 
ld_guard@1@@Z) referenced in function "void __cdecl createMatrix1(void)" (?createMatrix1@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devc 
ontainer\02-opencv-library\build\create_matrix.vcxproj]
C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\Debug\create_matrix.exe : fatal error LNK1120: 3 unresolved exter 
nals [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\create_matrix.vcxproj]
load_image_1.obj : error LNK2019: unresolved external symbol "void __cdecl cv::imshow(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char
> > const &,class cv::debug_build_guard::_InputArray const &)" (?imshow@cv@@YAXAEBV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@AEBV_InputArray@debug_buil 
d_guard@1@@Z) referenced in function "void __cdecl loadImage1(void)" (?loadImage1@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontaine 
r\02-opencv-library\build\load_image_1.vcxproj]
C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\Debug\load_image_1.exe : fatal error LNK1120: 1 unresolved extern 
als [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\load_image_1.vcxproj]
load_image_2.obj : error LNK2019: unresolved external symbol "void __cdecl cv::imshow(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char
> > const &,class cv::debug_build_guard::_InputArray const &)" (?imshow@cv@@YAXAEBV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@AEBV_InputArray@debug_buil 
d_guard@1@@Z) referenced in function "void __cdecl loadImage2(void)" (?loadImage2@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontaine 
r\02-opencv-library\build\load_image_2.vcxproj]
C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\Debug\load_image_2.exe : fatal error LNK1120: 1 unresolved extern 
als [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\load_image_2.vcxproj]
load_image_3.obj : error LNK2019: unresolved external symbol "void __cdecl cv::imshow(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char
> > const &,class cv::debug_build_guard::_InputArray const &)" (?imshow@cv@@YAXAEBV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@AEBV_InputArray@debug_buil 
d_guard@1@@Z) referenced in function "void __cdecl loadImage3(void)" (?loadImage3@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontaine 
r\02-opencv-library\build\load_image_3.vcxproj]
C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\Debug\load_image_3.exe : fatal error LNK1120: 1 unresolved extern 
als [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\load_image_3.vcxproj]
```

### Attemp 6

Try this:

```cmake
ExternalProject_Add(
    opencv_external
    PREFIX ${CMAKE_BINARY_DIR}/third-party/opencv4.10
    SOURCE_DIR ${CMAKE_SOURCE_DIR}/third-party/opencv4.10
    CMAKE_ARGS 
        -DCMAKE_INSTALL_PREFIX=${THIRD_PARTY_INSTALL_DIR}/opencv4.10
        # -DCMAKE_BUILD_TYPE=Release
        # -DCMAKE_CONFIGURATION_TYPES=Release # If this is not set it will attempt to build other configurations on Windows and cause and error
        -DBUILD_SHARED_LIBS=ON
        -DBUILD_TEST=OFF
        -DBUILD_EXAMPLES=OFF
        BUILD_COMMAND      ${CMAKE_COMMAND} --build . --config Release
        INSTALL_COMMAND    ${CMAKE_COMMAND} --build . --target install --config Release
)
```


Commands:

```bash
cmake -S . -B build
cmake --build build --config Debug
cd 02-opencv-library
cmake -S . -B build   # We passed this point
cmake --build build   # ERROR here
```

Output:

```powershell
PS C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library> cmake --build build 
MSBuild version 17.5.1+f6fdcf537 for .NET Framework

  Checking Build System
  Building Custom Rule C:/Users/wambe/Workspace/Udacity/SensorFusion/03_Camera/sfnd-camera-devcontainer/02-opencv-library/CMakeLists.txt
  change_pixels.cpp
change_pixels.obj : error LNK2019: unresolved external symbol "class cv::debug_build_guard::_InputOutputArray const & __cdecl cv::noArray(void)" (?noArray@cv@@YAAEBV_Inpu
tOutputArray@debug_build_guard@1@XZ) referenced in function "void __cdecl changePixels(void)" (?changePixels@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Cam 
era\sfnd-camera-devcontainer\02-opencv-library\build\change_pixels.vcxproj]
change_pixels.obj : error LNK2019: unresolved external symbol "public: class cv::Mat & __cdecl cv::Mat::setTo(class cv::debug_build_guard::_InputArray const &,class cv::d 
ebug_build_guard::_InputArray const &)" (?setTo@Mat@cv@@QEAAAEAV12@AEBV_InputArray@debug_build_guard@2@0@Z) referenced in function "void __cdecl changePixels(void)" (?cha 
ngePixels@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\change_pixels.vcxproj]
change_pixels.obj : error LNK2019: unresolved external symbol "void __cdecl cv::imshow(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<cha 
r> > const &,class cv::debug_build_guard::_InputArray const &)" (?imshow@cv@@YAXAEBV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@AEBV_InputArray@debug_bui 
ld_guard@1@@Z) referenced in function "void __cdecl changePixels(void)" (?changePixels@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcon 
tainer\02-opencv-library\build\change_pixels.vcxproj]
C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\Debug\change_pixels.exe : fatal error LNK1120: 3 unresolved exter 
nals [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\change_pixels.vcxproj]
  Building Custom Rule C:/Users/wambe/Workspace/Udacity/SensorFusion/03_Camera/sfnd-camera-devcontainer/02-opencv-library/CMakeLists.txt
  create_matrix.cpp
create_matrix.obj : error LNK2019: unresolved external symbol "class cv::debug_build_guard::_InputOutputArray const & __cdecl cv::noArray(void)" (?noArray@cv@@YAAEBV_Inpu
tOutputArray@debug_build_guard@1@XZ) referenced in function "void __cdecl createMatrix1(void)" (?createMatrix1@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_C 
amera\sfnd-camera-devcontainer\02-opencv-library\build\create_matrix.vcxproj]
create_matrix.obj : error LNK2019: unresolved external symbol "public: class cv::Mat & __cdecl cv::Mat::setTo(class cv::debug_build_guard::_InputArray const &,class cv::d 
ebug_build_guard::_InputArray const &)" (?setTo@Mat@cv@@QEAAAEAV12@AEBV_InputArray@debug_build_guard@2@0@Z) referenced in function "void __cdecl createMatrix1(void)" (?cr 
eateMatrix1@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\create_matrix.vcxproj]
create_matrix.obj : error LNK2019: unresolved external symbol "void __cdecl cv::imshow(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<cha 
r> > const &,class cv::debug_build_guard::_InputArray const &)" (?imshow@cv@@YAXAEBV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@AEBV_InputArray@debug_bui 
ld_guard@1@@Z) referenced in function "void __cdecl createMatrix1(void)" (?createMatrix1@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devc 
ontainer\02-opencv-library\build\create_matrix.vcxproj]
C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\Debug\create_matrix.exe : fatal error LNK1120: 3 unresolved exter 
nals [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\create_matrix.vcxproj]
  Building Custom Rule C:/Users/wambe/Workspace/Udacity/SensorFusion/03_Camera/sfnd-camera-devcontainer/02-opencv-library/CMakeLists.txt
  load_image_1.cpp
load_image_1.obj : error LNK2019: unresolved external symbol "void __cdecl cv::imshow(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char
> > const &,class cv::debug_build_guard::_InputArray const &)" (?imshow@cv@@YAXAEBV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@AEBV_InputArray@debug_buil 
d_guard@1@@Z) referenced in function "void __cdecl loadImage1(void)" (?loadImage1@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontaine 
r\02-opencv-library\build\load_image_1.vcxproj]
C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\Debug\load_image_1.exe : fatal error LNK1120: 1 unresolved extern 
als [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\load_image_1.vcxproj]
  Building Custom Rule C:/Users/wambe/Workspace/Udacity/SensorFusion/03_Camera/sfnd-camera-devcontainer/02-opencv-library/CMakeLists.txt
  load_image_2.cpp
load_image_2.obj : error LNK2019: unresolved external symbol "void __cdecl cv::imshow(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char
> > const &,class cv::debug_build_guard::_InputArray const &)" (?imshow@cv@@YAXAEBV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@AEBV_InputArray@debug_buil 
d_guard@1@@Z) referenced in function "void __cdecl loadImage2(void)" (?loadImage2@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontaine 
r\02-opencv-library\build\load_image_2.vcxproj]
C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\Debug\load_image_2.exe : fatal error LNK1120: 1 unresolved extern 
als [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\load_image_2.vcxproj]
  Building Custom Rule C:/Users/wambe/Workspace/Udacity/SensorFusion/03_Camera/sfnd-camera-devcontainer/02-opencv-library/CMakeLists.txt
  load_image_3.cpp
load_image_3.obj : error LNK2019: unresolved external symbol "void __cdecl cv::imshow(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char
> > const &,class cv::debug_build_guard::_InputArray const &)" (?imshow@cv@@YAXAEBV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@AEBV_InputArray@debug_buil 
d_guard@1@@Z) referenced in function "void __cdecl loadImage3(void)" (?loadImage3@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontaine 
r\02-opencv-library\build\load_image_3.vcxproj]
C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\Debug\load_image_3.exe : fatal error LNK1120: 1 unresolved extern 
als [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\load_image_3.vcxproj]
```

```bash
cmake --build build --config Debug  # ERROR here
```

Error too:


```powershell
PS C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library> cmake --build build --config Debug
MSBuild version 17.5.1+f6fdcf537 for .NET Framework

change_pixels.obj : error LNK2019: unresolved external symbol "class cv::debug_build_guard::_InputOutputArray const & __cdecl cv::noArray(void)" (?noArray@cv@@YAAEBV_Inpu
tOutputArray@debug_build_guard@1@XZ) referenced in function "void __cdecl changePixels(void)" (?changePixels@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Cam 
era\sfnd-camera-devcontainer\02-opencv-library\build\change_pixels.vcxproj]
change_pixels.obj : error LNK2019: unresolved external symbol "public: class cv::Mat & __cdecl cv::Mat::setTo(class cv::debug_build_guard::_InputArray const &,class cv::d 
ebug_build_guard::_InputArray const &)" (?setTo@Mat@cv@@QEAAAEAV12@AEBV_InputArray@debug_build_guard@2@0@Z) referenced in function "void __cdecl changePixels(void)" (?cha 
ngePixels@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\change_pixels.vcxproj]
change_pixels.obj : error LNK2019: unresolved external symbol "void __cdecl cv::imshow(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<cha 
r> > const &,class cv::debug_build_guard::_InputArray const &)" (?imshow@cv@@YAXAEBV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@AEBV_InputArray@debug_bui 
ld_guard@1@@Z) referenced in function "void __cdecl changePixels(void)" (?changePixels@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcon 
tainer\02-opencv-library\build\change_pixels.vcxproj]
C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\Debug\change_pixels.exe : fatal error LNK1120: 3 unresolved exter 
nals [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\change_pixels.vcxproj]
create_matrix.obj : error LNK2019: unresolved external symbol "class cv::debug_build_guard::_InputOutputArray const & __cdecl cv::noArray(void)" (?noArray@cv@@YAAEBV_Inpu
tOutputArray@debug_build_guard@1@XZ) referenced in function "void __cdecl createMatrix1(void)" (?createMatrix1@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_C 
amera\sfnd-camera-devcontainer\02-opencv-library\build\create_matrix.vcxproj]
create_matrix.obj : error LNK2019: unresolved external symbol "public: class cv::Mat & __cdecl cv::Mat::setTo(class cv::debug_build_guard::_InputArray const &,class cv::d 
ebug_build_guard::_InputArray const &)" (?setTo@Mat@cv@@QEAAAEAV12@AEBV_InputArray@debug_build_guard@2@0@Z) referenced in function "void __cdecl createMatrix1(void)" (?cr 
eateMatrix1@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\create_matrix.vcxproj]
create_matrix.obj : error LNK2019: unresolved external symbol "void __cdecl cv::imshow(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<cha 
r> > const &,class cv::debug_build_guard::_InputArray const &)" (?imshow@cv@@YAXAEBV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@AEBV_InputArray@debug_bui 
ld_guard@1@@Z) referenced in function "void __cdecl createMatrix1(void)" (?createMatrix1@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devc 
ontainer\02-opencv-library\build\create_matrix.vcxproj]
C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\Debug\create_matrix.exe : fatal error LNK1120: 3 unresolved exter 
nals [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\create_matrix.vcxproj]
load_image_1.obj : error LNK2019: unresolved external symbol "void __cdecl cv::imshow(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char
> > const &,class cv::debug_build_guard::_InputArray const &)" (?imshow@cv@@YAXAEBV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@AEBV_InputArray@debug_buil 
d_guard@1@@Z) referenced in function "void __cdecl loadImage1(void)" (?loadImage1@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontaine 
r\02-opencv-library\build\load_image_1.vcxproj]
C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\Debug\load_image_1.exe : fatal error LNK1120: 1 unresolved extern 
als [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\load_image_1.vcxproj]
load_image_2.obj : error LNK2019: unresolved external symbol "void __cdecl cv::imshow(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char
> > const &,class cv::debug_build_guard::_InputArray const &)" (?imshow@cv@@YAXAEBV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@AEBV_InputArray@debug_buil 
d_guard@1@@Z) referenced in function "void __cdecl loadImage2(void)" (?loadImage2@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontaine 
r\02-opencv-library\build\load_image_2.vcxproj]
C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\Debug\load_image_2.exe : fatal error LNK1120: 1 unresolved extern 
als [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\load_image_2.vcxproj]
load_image_3.obj : error LNK2019: unresolved external symbol "void __cdecl cv::imshow(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char
> > const &,class cv::debug_build_guard::_InputArray const &)" (?imshow@cv@@YAXAEBV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@AEBV_InputArray@debug_buil 
d_guard@1@@Z) referenced in function "void __cdecl loadImage3(void)" (?loadImage3@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontaine 
r\02-opencv-library\build\load_image_3.vcxproj]
C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\Debug\load_image_3.exe : fatal error LNK1120: 1 unresolved extern 
als [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\02-opencv-library\build\load_image_3.vcxproj]
```

Commands:

```
cd ..
cmake --build build --config Release
cd 02-opencv-library
cmake --build build  --config Release
```

SUCCESS!!!

### Attemp 7

From the parent dir

```bash
cmake -S . -B build
cmake --build build --config Release
```

SUCESS!!!

```bash
cmake --build build --config Debug
```

ERRORS:

``` powershell
PS C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer> cmake --build build --config Debug
MSBuild version 17.5.1+f6fdcf537 for .NET Framework

change_pixels.obj : error LNK2019: unresolved external symbol "class cv::debug_build_guard::_InputOutputArray const & __cdecl cv::noArray(void)" (?noArray@cv@@YAAEBV_Inpu
tOutputArray@debug_build_guard@1@XZ) referenced in function "void __cdecl changePixels(void)" (?changePixels@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Cam 
era\sfnd-camera-devcontainer\build\02-opencv-library\change_pixels.vcxproj]
change_pixels.obj : error LNK2019: unresolved external symbol "public: class cv::Mat & __cdecl cv::Mat::setTo(class cv::debug_build_guard::_InputArray const &,class cv::d 
ebug_build_guard::_InputArray const &)" (?setTo@Mat@cv@@QEAAAEAV12@AEBV_InputArray@debug_build_guard@2@0@Z) referenced in function "void __cdecl changePixels(void)" (?cha 
ngePixels@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\build\02-opencv-library\change_pixels.vcxproj]
change_pixels.obj : error LNK2019: unresolved external symbol "void __cdecl cv::imshow(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<cha 
r> > const &,class cv::debug_build_guard::_InputArray const &)" (?imshow@cv@@YAXAEBV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@AEBV_InputArray@debug_bui 
ld_guard@1@@Z) referenced in function "void __cdecl changePixels(void)" (?changePixels@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcon 
tainer\build\02-opencv-library\change_pixels.vcxproj]
C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\build\02-opencv-library\Debug\change_pixels.exe : fatal error LNK1120: 3 unresolved exter 
nals [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\build\02-opencv-library\change_pixels.vcxproj]
create_matrix.obj : error LNK2019: unresolved external symbol "class cv::debug_build_guard::_InputOutputArray const & __cdecl cv::noArray(void)" (?noArray@cv@@YAAEBV_Inpu
tOutputArray@debug_build_guard@1@XZ) referenced in function "void __cdecl createMatrix1(void)" (?createMatrix1@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_C 
amera\sfnd-camera-devcontainer\build\02-opencv-library\create_matrix.vcxproj]
create_matrix.obj : error LNK2019: unresolved external symbol "public: class cv::Mat & __cdecl cv::Mat::setTo(class cv::debug_build_guard::_InputArray const &,class cv::d 
ebug_build_guard::_InputArray const &)" (?setTo@Mat@cv@@QEAAAEAV12@AEBV_InputArray@debug_build_guard@2@0@Z) referenced in function "void __cdecl createMatrix1(void)" (?cr 
eateMatrix1@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\build\02-opencv-library\create_matrix.vcxproj]
create_matrix.obj : error LNK2019: unresolved external symbol "void __cdecl cv::imshow(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<cha 
r> > const &,class cv::debug_build_guard::_InputArray const &)" (?imshow@cv@@YAXAEBV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@AEBV_InputArray@debug_bui 
ld_guard@1@@Z) referenced in function "void __cdecl createMatrix1(void)" (?createMatrix1@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devc 
ontainer\build\02-opencv-library\create_matrix.vcxproj]
C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\build\02-opencv-library\Debug\create_matrix.exe : fatal error LNK1120: 3 unresolved exter 
nals [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\build\02-opencv-library\create_matrix.vcxproj]
load_image_1.obj : error LNK2019: unresolved external symbol "void __cdecl cv::imshow(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char
> > const &,class cv::debug_build_guard::_InputArray const &)" (?imshow@cv@@YAXAEBV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@AEBV_InputArray@debug_buil 
d_guard@1@@Z) referenced in function "void __cdecl loadImage1(void)" (?loadImage1@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontaine 
r\build\02-opencv-library\load_image_1.vcxproj]
C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\build\02-opencv-library\Debug\load_image_1.exe : fatal error LNK1120: 1 unresolved extern 
als [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\build\02-opencv-library\load_image_1.vcxproj]
load_image_2.obj : error LNK2019: unresolved external symbol "void __cdecl cv::imshow(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char
> > const &,class cv::debug_build_guard::_InputArray const &)" (?imshow@cv@@YAXAEBV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@AEBV_InputArray@debug_buil 
d_guard@1@@Z) referenced in function "void __cdecl loadImage2(void)" (?loadImage2@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontaine 
r\build\02-opencv-library\load_image_2.vcxproj]
C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\build\02-opencv-library\Debug\load_image_2.exe : fatal error LNK1120: 1 unresolved extern 
als [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\build\02-opencv-library\load_image_2.vcxproj]
load_image_3.obj : error LNK2019: unresolved external symbol "void __cdecl cv::imshow(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char
> > const &,class cv::debug_build_guard::_InputArray const &)" (?imshow@cv@@YAXAEBV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@AEBV_InputArray@debug_buil 
d_guard@1@@Z) referenced in function "void __cdecl loadImage3(void)" (?loadImage3@@YAXXZ) [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontaine 
r\build\02-opencv-library\load_image_3.vcxproj]
C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\build\02-opencv-library\Debug\load_image_3.exe : fatal error LNK1120: 1 unresolved extern 
als [C:\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\build\02-opencv-library\load_image_3.vcxproj]
```

### Attempt 8 - Winner Winner Chiken Dinner!!! (This need to have the install first no subderectories allowed)

ExternalProject_Add(
    opencv_external
    PREFIX ${CMAKE_BINARY_DIR}/third-party/opencv4.10
    SOURCE_DIR ${CMAKE_SOURCE_DIR}/third-party/opencv4.10
    CMAKE_ARGS 
        -DCMAKE_INSTALL_PREFIX=${THIRD_PARTY_INSTALL_DIR}/opencv4.10
        # NOTE: If this is not configured then Release it's used by default and sub projects cannot be build in Debug Mode
        -DCMAKE_CONFIGURATION_TYPES=Debug;Release
        -DBUILD_SHARED_LIBS=ON
        -DBUILD_TEST=OFF
        -DBUILD_EXAMPLES=OFF
        BUILD_COMMAND      ${CMAKE_COMMAND} --build . --config $<CONFIG>
        INSTALL_COMMAND    ${CMAKE_COMMAND} --build . --target install --config $<CONFIG>
)

Commands

```
cmake -S . -B build
cmake --build build --config Debug
cmake --build build --config Release
```


### Attempt 9 - Winner Winner Chiken Dinner!!! (This need to have the install first no subderectories allowed)

```
cmake -S . -B build
cmake --build build --config Release
```

## sub_directory()

After several attemtps I was not able to use ExternalProject on Release and subprojects on Debug so we will try now with `sub_directory()`


### Attemp 1:

```bash
cd third-party/opencv4.10
cmake -S . -B build -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON
cmake --build build --config Release    
cmake --build build  --target install --config Release # can we skip? -> Yes, we just use build dir not install dir as OpenCV_DIR
```

We can use this if we want to skip the installation:

```cmake
set(OpenCV_DIR "${CMAKE_SOURCE_DIR}/../third-party/opencv4.10/build/") # THIS WORKS without installation!!!
```

If we want to skip the install we can also do manual management of the libraries used which could be cumbersome and require mantainance, this might be ideal for production environments though.


Everything got generated at 

```bash
03_Camera\sfnd-camera-devcontainer\third-party\opencv4.10\build\bin\Release # Also debug if generated
03_Camera\sfnd-camera-devcontainer\third-party\opencv4.10\build\lib\Release # Also debug if geberated
```

After install it copies that content to, it also depends on the configuration used, libraries get overwritten based on the command, i.e. if Release it's installed and then Debug the previous intallation will get overwritten and vicerversa.

```bash
cmake --build build --config Debug --target install
cmake --build build --config Release --target install
```

```bash
03_Camera\sfnd-camera-devcontainer\third-party\opencv4.10\build\install\x64\vc17\bin
03_Camera\sfnd-camera-devcontainer\third-party\opencv4.10\build\install\x64\vc17\ib
```



