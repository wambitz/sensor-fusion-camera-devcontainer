# Sensor Fusion NanoDegree- Camera Course
Camera is the second course in the Sensor Fusion ND. The purpose of this repo is to provide the exercise code to the students, so that they can practice in local system. 

This repo contains lesson-wise exercises and corresponding solutions for Udacity's Sensor Fusion ND. 

## A. List of Lesson-wise Exercises
1. Lesson 2: Autonomous Vehicles and Computer Vision
   - The OpenCV Library
1. Lesson 3: Engineering a Collision Detection System
   - Estimating TTC with Camera
   - Estimating TTC with Lidar
1. Lesson 4: Tracking Image Features
   - Descriptor Matching
   - Gradient-based vs. Binary Descriptors
   - Haris Corner Detection
   - Intensity Gradient and Filtering
   - Overview of Popular Keypoint Detectors
1. Lesson 5: Starter code for "Project: Camera Based 2D Feature Tracking" is available here - https://github.com/udacity/SFND_2D_Feature_Tracking
1. Lesson 6: Combining Camera and Lidar
   - Creating 3D-Objects
   - Lidar-to-Camera Point Projection
   - Object Detection with YOLO
1. Lesson 7: Starter code for "Project: Track an Object in 3D Space" is available here - https://github.com/udacity/SFND_3D_Object_Tracking


## B. Dependencies for Running Locally
1. cmake >= 2.8
    * All OSes: [click here for installation instructions](https://cmake.org/install/)


2. make >= 4.1 (Linux, Mac), 3.81 (Windows)
    * Linux: make is installed by default on most Linux distros
    * Mac: [install Xcode command line tools to get make](https://developer.apple.com/xcode/features/)
    * Windows: [Click here for installation instructions](http://gnuwin32.sourceforge.net/packages/make.htm)


3. OpenCV >= 4.1
    * This must be compiled from source using the `-D OPENCV_ENABLE_NONFREE=ON` cmake flag for testing the SIFT and SURF detectors.
    * The OpenCV 4.1.0 source code can be found [here](https://github.com/opencv/opencv/tree/4.1.0)


4. gcc/g++ >= 5.4 
    * Linux: gcc / g++ is installed by default on most Linux distros
    * Mac: same deal as make - [install Xcode command line tools](https://developer.apple.com/xcode/features/)
    * Windows: recommend using [MinGW](http://www.mingw.org/)


## C. Build Instructions
1. Fork this repo to your Github account
2. Clone your Github repo.
3. Go to the top level directory for an exercise, and run the following commands on your terminal:
```
mkdir build && cd build
cmake ..
make
./<Executable_File_Name>
```
4. Update back the remote (online) repo so that you can use the updated code in the classroom workspace. 

## D. Pushing Large Files (>100MB) [Optional]
The file `Combining Camera and Lidar/Object Detection with YOLO/detect_objects/dat/yolo/yolov3.weights` is 236.52 MB; this exceeds GitHub's file size limit of 100.00 MB

Github blocks the files that have size>100MB, while pushing them. To push large files, Git provides an option called Git Large File Storage (LFS). See the instructions at [https://git-lfs.github.com/](https://git-lfs.github.com/) to use Git LFS. See [http://git.io/iEPt8g](http://git.io/iEPt8g) for more information.

You can push large file only to unprotected remote branches. Master branch is by default protected. Read more [here](https://docs.github.com/en/github/administering-a-repository/about-protected-branches). Therefore, you'll have to push to a new unprotected branch, and later, merge it with the remote master. Use the commands below:

* Create a new local branch
```
git checkout -b <local_branch_name>
```

* Write the solution to your exercise. 

* Install Git Large File Storage (LFS). For MacOS, use
```
brew install git-lfs
git lfs install
git lfs track "<Large_file_name_if_any>"
git add .gitattributes
git add <path_to_the_Large_file_if_any>
git config --global lfs.contenttype 0

```

* Add the modified files to the index area, and commit the changes
```
git add . --all   
git commit -m "your comment"
```
* To push the current local branch and set the remote as upstream:
```
git push --set-upstream origin <local_branch_name>
```

* Next, create a PR and merge the new branch with the remote master.

## Install OpenCV globally

### To build all the projects

```bash
cd ../../
cmake -S . -B build
cmake --build build --config Release
cmake --build build --config Debug
```

- Set environment variables
    - Binary
    - OpenCV_DIR

### To build specific projects in an isolated fashion (opencv needs to be available)

```bash
cd 01-playground
cmake -S . -B build
cmake --build build --config Release
cmake --build build --config Debug
```

## Install OpenCV locally 

Clone the submodule repository:

```
git submodule update --init --recursive
```

Build the library

```bash
cd third-party/opencv4.10
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX=../third-party/install

cmake --build build --config Release
cmake --build build --config Debug
cmake --build build --config Release --target INSTALL # this will install at DCMAKE_INSTALL_PREFIX if defined otherwise build/install
cmake --build build --config Debug --target INSTALL 
```

### To build all the projects

```bash
cd ../../
cmake -S . -B build
cmake --build build --config Release
cmake --build build --config Debug
```

### To build specific projects in an isolated fashion (opencv needs to be available)

```bash
cd 01-playground
cmake -S . -B build
cmake --build build --config Release
cmake --build build --config Debug
```

To be able to run this should be added to your path. WARNING: This variable could already be set on the system / global environment variables, make sure to know where this is coming from and make sure to overwrite it if you want to use your custom installation.

Powershell:

```powershell
$env:PATH = "${PWD}\third-party\opencv4.10\build\x64\vc17\bin;" + $env:PATH
```

CMD: 

```cmd
set "PATH=\Users\wambe\Workspace\Udacity\SensorFusion\03_Camera\sfnd-camera-devcontainer\01-playground\..\third-party\opencv4.10\build\x64\vc17\bin;%PATH%"
```

Bash:

```bash
PATH="/path/to/opencv/bin:$PATH" ./MyApp
```


## Building only one project:

Mention that this needs to be defined for finding a custom build of OpenCV also it might be needed to add the binary dir to the PATH.

Doing this on your local session should overwrite a global installation if any. If nothing is set find_package() will throw an error.

```bash
cmake -S . -B build -DOpenCV_DIR="../third-party/opencv4.10/build/install"
```

Or for more nested projects like <EXAMPLE_HERE>:

```
cmake -S . -B build -DOpenCV_DIR="../../third-party/opencv4.10/build/install"
```