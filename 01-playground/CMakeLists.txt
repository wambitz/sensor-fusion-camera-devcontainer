# 01-playground/CMakeLists.txt
cmake_minimum_required(VERSION 3.15)
project(MyApp)

# Set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if(NOT OpenCV_FOUND)
    find_package(OpenCV REQUIRED)
endif()

# Add your app
add_executable(MyApp src/main.cpp)

# Link against OpenCV shared libraries built in Release
target_link_libraries(MyApp ${OpenCV_LIBS})
