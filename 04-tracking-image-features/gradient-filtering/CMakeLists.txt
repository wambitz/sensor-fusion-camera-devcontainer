# 04-tracking-image-features/gradient-filtering/CMakeLists.txt
cmake_minimum_required(VERSION 3.16 FATAL_ERROR)

project(sfnd-camera LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CXX_FLAGS "-Wall")
set(CMAKE_CXX_FLAGS, "${CXX_FLAGS}")

if(NOT OpenCV_FOUND)
    find_package(OpenCV REQUIRED)
endif()


# Include OpenCV headers
include_directories(${OpenCV_INCLUDE_DIRS})
link_directories(${OpenCV_LIBRARY_DIRS})
add_definitions(${OpenCV_DEFINITIONS})

# Executables for exercises
add_executable (gaussian_smoothing src/gaussian_smoothing.cpp)
target_link_libraries (gaussian_smoothing ${OpenCV_LIBRARIES})

add_executable (gradient_sobel src/gradient_sobel.cpp)
target_link_libraries (gradient_sobel ${OpenCV_LIBRARIES})

add_executable (magnitude_sobel src/magnitude_sobel.cpp)
target_link_libraries (magnitude_sobel ${OpenCV_LIBRARIES})
