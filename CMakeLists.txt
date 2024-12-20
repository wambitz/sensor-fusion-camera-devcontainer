# CMakeLists.txt
cmake_minimum_required(VERSION 3.16 FATAL_ERROR)
project(sfnd-camera LANGUAGES CXX)

find_package(OpenCV REQUIRED)

# =========================
# Subprojects
# =========================
add_subdirectory(01-playground)

add_subdirectory(02-opencv-library)

add_subdirectory(03-collision-detection-system/ttc-camera)
add_subdirectory(03-collision-detection-system/ttc-lidar)

add_subdirectory(04-tracking-image-features/cornerness_harris)
add_subdirectory(04-tracking-image-features/describe-keypoints)
add_subdirectory(04-tracking-image-features/descriptor-matching)
add_subdirectory(04-tracking-image-features/detect_keypoints)
add_subdirectory(04-tracking-image-features/gradient-filtering)

add_subdirectory(06-combining-camera-and-lidar/cluster-with-roi)
add_subdirectory(06-combining-camera-and-lidar/lidar-to-camera)
add_subdirectory(06-combining-camera-and-lidar/object-detection-yolo)

