# 02-opencv-library/CMakeLists.txt
cmake_minimum_required(VERSION 3.16 FATAL_ERROR)

project(sfnd-camera LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CXX_FLAGS "-Wall")
set(CMAKE_CXX_FLAGS "${CXX_FLAGS}")

if(NOT OpenCV_FOUND)
    find_package(OpenCV REQUIRED)
endif()

# Include OpenCV headers
include_directories(${OpenCV_INCLUDE_DIRS})

# Add binaries for source files
add_executable(create_matrix src/create_matrix.cpp)
target_link_libraries(create_matrix PRIVATE ${OpenCV_LIBS})

add_executable(change_pixels src/change_pixels.cpp)
target_link_libraries(change_pixels PRIVATE ${OpenCV_LIBS})

add_executable(load_image_1 src/load_image_1.cpp)
target_link_libraries(load_image_1 PRIVATE ${OpenCV_LIBS})

add_executable(load_image_2 src/load_image_2.cpp)
target_link_libraries(load_image_2 PRIVATE ${OpenCV_LIBS})

add_executable(load_image_3 src/load_image_3.cpp)
target_link_libraries(load_image_3 PRIVATE ${OpenCV_LIBS})
