// 01-playground/src/main.cpp
#include <opencv2/opencv.hpp>
#include <iostream>

int main() {
    std::cout << "OpenCV Version: " << CV_VERSION << std::endl;

    cv::Mat image = cv::Mat::zeros(300, 300, CV_8UC3);
    cv::putText(image, "Hello, OpenCV!", cv::Point(50, 150), cv::FONT_HERSHEY_SIMPLEX, 1.0, cv::Scalar(0, 255, 0), 2);

    cv::imshow("OpenCV Window", image);
    cv::waitKey(0);
    return 0;
}
