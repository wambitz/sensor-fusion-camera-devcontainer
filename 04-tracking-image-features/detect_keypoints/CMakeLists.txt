# 04-tracking-image-features/detect-keypoints/CMakeLists.txt
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

# Executables for exercise
add_executable (detect_keypoints src/detect_keypoints.cpp)
target_link_libraries (detect_keypoints ${OpenCV_LIBRARIES})
