# VGA Image Display Using FPGA

## Overview
This repository contains the RTL code and scripts for a Digital IC Design project focused on displaying an image on a VGA monitor using an FPGA. The system is divided conceptually into a VGA Controller that manages pixel generation timing and a Graphics Engine that determines the visual output.

## Team
* Malak Mansour: malakmansour529@gmail.com
* Fady Ashraf: fadyashraf255200@gmail.com
* Karim Khaled

## System Architecture
The hardware pipeline consists of five logical video signals (R, G, B, HSYNC, VSYNC) and is divided into the following key modules:
* **Pixel X Counter**: Generates the horizontal pixel position.
* **Pixel Y Counter**: Generates the vertical pixel position.
* **VGA Sync**: Generates the required VGA timing signals. This includes `pixel_x`, `pixel_y`, `video_on` (which indicates if the current position is within the visible 640x480 area), `hsync`, and `vsync`.
* **ROM**: Stores the image data.
* **RGB Module (Graphics Engine)**: Receives the current `pixel_x`, `pixel_y`, and `video_on` signals to determine the color of the current pixel and generate the appropriate `rgb` output values.
* **Clock**: Drives pixel timing across all modules. The baseline video mode uses a nominal 25.175 MHz pixel clock to target a 640x480 resolution at 60 Hz.
* **Top Module**: Connects all modules together.

## Challenges & Solutions

### 1. Image Quality
* **Problem**: The displayed image had inaccurate colors and noticeable color errors.
* **Solution (Floyd-Steinberg Dithering)**: We applied Floyd-Steinberg dithering, which improved color representation and reduced visible color errors.

### 2. Storage
* **Problem**: The original image required too much memory.
* **Solution**: Image Stretching: We bypassed the memory limits by using image stretching, which reduced the amount of stored image data while maintaining an acceptable displayed size.

