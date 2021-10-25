# EVTP

Electric Vehicle Trip Planning and Range Estimation

## Abstract 

Abstract
Battery Electric Vehicles (BEV) offer a cheaper and zero-emission mode of transport in comparison to an Internal Combustion Engine (ICE) vehicles. However, BEV’s do have some inconveniences, such as short driving range and long charging times in combination with inaccurate remaining range estimations. These inconveniences have created the idea of range anxiety and stress within BEV owners, or potential buyers, with the argument of needing extra trip planning comparatively to ICE vehicles. In this dissertation, we show the design and results of a working application (drawing on previous work by Beamish (2020)) that will provide automated trip planning and improve the accuracy of the remaining battery range calculations. The trip planning application will include automatic inclusion of charging stations where required and to optimise routes, reducing overall trip time when taking charging requirements into account. Real-time data logging of speed, battery, and gyroscopic data from both the BEV and a mounted smart phone will be used when creating a dynamic model for each driver, which can be used on a planned route terrain data to provide an optimised, and accurate range estimation. This application will create datasets that will be unique to each user, reducing the potentially stressful experiences of using BEV’s and associated range anxiety. 

## How to run
This project has been created using the Flutter extension for VSCode, assuming Flutter is installed on local development machine, this extension allows for easy installation of packages and running on multiple device configurations with debugging. 

### Install Dependencies: 
Open the pubspec.yaml file and click run in the top right, this will run ```flutter pub get```

### Run/Debugging
Click the run in top right, and select device if required, note: 
Due to the use of AWS Amplify via Flutter, web is not a supported platform for running, make sure to use a physical device or simulator

### Links:
- https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter 
- https://flutter.dev/docs/development/tools/vs-code
