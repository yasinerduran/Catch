// OpenCV.cpp : Defines the exported functions for the DLL application.
//

#include "stdafx.h"
#define DllImport extern "C" __declspec(dllimport)
#define DllExport extern "C" __declspec(dllexport)

DllExport double OpenCam(double a) {
	return  1;
}

