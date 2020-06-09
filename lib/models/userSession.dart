import 'user.dart';
import 'camera.dart';


/// Map of patient name to saved diagnoses image paths
Map<String, List<String>> savedPatientDiagnoses = {};

List <String> patientList= [];

String currentDiagnosesImagePath="";


logout(){
    gCamData = CameraData();
    patientList = [];
    savedPatientDiagnoses = {};
    currentDiagnosesImagePath="";//clear other user data
}