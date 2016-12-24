// OpenCV.cpp : Defines the exported functions for the DLL application.
//

#include "stdafx.h"
#include <opencv2\opencv.hpp>
#include <iostream>
#include <sstream>
#define DllImport extern "C" __declspec(dllimport)
#define DllExport extern "C" __declspec(dllexport)
using namespace std;
using namespace cv;
Mat frame;
bool CameraControl = true;
DllExport double OpenCam(double ab) {
	
		VideoCapture vid(ab);
		if (!vid.isOpened())
		{
			return -1;
		}
		while (CameraControl)
		{
			bool kontrol = vid.read(frame);
			if (!kontrol)
			{
				return -2;
			}

			vector<int> skstrma;
			skstrma.push_back(CV_IMWRITE_JPEG_QUALITY);
			skstrma.push_back(100);
			std::ostringstream strs;
			strs << ab;
			std::string str = strs.str();
			imwrite("Cache/" + str + ".jpg", frame, skstrma);
		}

}
DllExport double CloseCam() {
	CameraControl = FALSE; 
	return 1;
}

DllExport double GetCamList(double baslangic, double bitis) {
	double CameraCount  = 0 ;		
	for (size_t i = baslangic; i < bitis; i ++)
	{
		VideoCapture vid(i);
		if (!vid.isOpened())
		{
			//
		}
		else {
			CameraCount ++;
		}
	}
	return CameraCount;
	
}
