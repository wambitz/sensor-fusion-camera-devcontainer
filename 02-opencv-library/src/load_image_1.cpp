#include <iomanip>
#include <iostream>
#include <string>
#include <filesystem>
#include <opencv2/core.hpp>
#include <opencv2/highgui.hpp>

using namespace std;

void loadImage1()
{
    // current_path() returns a std::filesystem::path
    std::filesystem::path cwd = std::filesystem::current_path();
    
    std::cout << "Current working directory: " << cwd << std::endl;

    // load image from file
    cv::Mat img;
    // This is if you run from the root dir like so:
    // ./build/02-opencv-library/Debug/load_image_1.exe
    img = cv::imread("02-opencv-library/images/img1.png"); 

    // show result
    string windowName = "First steps in OpenCV";
    cv::namedWindow(windowName, 1); // create window
    cv::imshow(windowName, img);
    cv::waitKey(0); // wait for keyboard input before continuing
}

int main()
{
    loadImage1();
    return 0;
}