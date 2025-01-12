# cmake/FindOpenCVCustom.cmake
function(find_opencv_custom LOCAL_OPENCV_PATH)
    # Just unset normally (not from cache) to allow a clean attempt.
    unset(OpenCV_DIR)

    message(STATUS "Attempting to find OpenCV locally at: ${LOCAL_OPENCV_PATH}")
    find_package(OpenCV HINTS "${LOCAL_OPENCV_PATH}" NO_DEFAULT_PATH)
    if(OpenCV_FOUND)
        message(WARNING
            "You need to add the following directory to your PATH:\n"
            "${LOCAL_OPENCV_PATH}/x64/vc17/bin\n"
            "If a global OpenCV is installed and in PATH, it might take precedence.\n"
        )

        # Store results in cache to persist for subdirectories
        # set(OpenCV_FOUND ${OpenCV_FOUND} CACHE INTERNAL "OpenCV found")
        # set(OpenCV_INCLUDE_DIRS ${OpenCV_INCLUDE_DIRS} CACHE INTERNAL "OpenCV include dirs")
        # set(OpenCV_LIBS ${OpenCV_LIBS} CACHE INTERNAL "OpenCV libs")
        set(OpenCV_FOUND ${OpenCV_FOUND} CACHE BOOL "OpenCV found" FORCE)
        set(OpenCV_INCLUDE_DIRS ${OpenCV_INCLUDE_DIRS} CACHE PATH "OpenCV include dirs" FORCE)
        set(OpenCV_LIBS ${OpenCV_LIBS} CACHE STRING "OpenCV libs" FORCE)
        return()
    endif()

    message(WARNING "OpenCV not found locally. Trying global installation...")
    unset(OpenCV_DIR)
    find_package(OpenCV REQUIRED)
    if(OpenCV_FOUND)
        # Store results in cache to persist for subdirectories
        # set(OpenCV_FOUND ${OpenCV_FOUND} CACHE INTERNAL "OpenCV found")
        # set(OpenCV_INCLUDE_DIRS ${OpenCV_INCLUDE_DIRS} CACHE INTERNAL "OpenCV include dirs")
        # set(OpenCV_LIBS ${OpenCV_LIBS} CACHE INTERNAL "OpenCV libs")
        set(OpenCV_FOUND ${OpenCV_FOUND} CACHE BOOL "OpenCV found" FORCE)
        set(OpenCV_INCLUDE_DIRS ${OpenCV_INCLUDE_DIRS} CACHE PATH "OpenCV include dirs" FORCE)
        set(OpenCV_LIBS ${OpenCV_LIBS} CACHE STRING "OpenCV libs" FORCE)
    endif()
endfunction()


# NOTE: Be mindful when using install because it could contains both Release and Debug together. This is dependent on how the project was built
# set(OpenCV_DIR "${CMAKE_SOURCE_DIR}/third-party/opencv4.10/build/install")
# set(OpenCV_DIR "${CMAKE_SOURCE_DIR}/third-party/install") # -> This was installed with a prefix

# NOTE: Be mindful when using install because it contains either Release or Debug
# set(OpenCV_DIR "${CMAKE_SOURCE_DIR}/../third-party/opencv4.10/build/win-install/") -> This doesn't work it's just for stating at installation
# set(OpenCV_DIR "${CMAKE_SOURCE_DIR}/../third-party/opencv4.10/build/win-install/x64/vc17/lib") -> This doesn't work it's just for stating at installation
# set(OpenCV_DIR "${CMAKE_SOURCE_DIR}/../third-party/opencv4.10/build/install/") # This only exists after install 
# set(OpenCV_DIR "${CMAKE_SOURCE_DIR}/../third-party/opencv4.10/build/install/x64/vc17/lib")

# Local OpenCV directory (adjust to the actual location of OpenCVConfig.cmake)
# NOTE: This need to be set to overwrite sub projects definition of OpenCV_DIR, this doesn't need install
# set(LOCAL_OPENCV_PATH "${CMAKE_SOURCE_DIR}/third-party/opencv4.10/build")