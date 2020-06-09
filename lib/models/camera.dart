import 'package:camera/camera.dart';


class CameraData{
   String localImagePath;
   List<String> sessionImages=[];
   List<CameraDescription> availableCameras=[];

}

CameraData gCamData = CameraData();