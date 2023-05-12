import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rainbow/rainbow/rainbow.dart';
import 'package:camera/camera.dart';

const List<String> pc_type = <String>['봄 웜톤', '여름 쿨톤', '가을 웜톤', '겨울 쿨톤'];
// List<CameraDescription>? cameras;

//유저의 설정된 퍼스널컬러로 변경해야 함.
String cur_pc_type = '여름 쿨톤';
String nickName = 'qkrrjsgh';
String image_url = "https://i.ibb.co/CwzHq4z/trans-logo-512.png";
List<CameraDescription> cameras = [];

void main() async {
  try {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('cameraException $e');
  }
  // cameras = await availableCameras();
  // FlutterNativeSplash.

  if (await Permission.manageExternalStorage.isDenied) {
    debugPrint('no access storage');
    await Permission.manageExternalStorage.request;
    debugPrint('access storage granted');
  }

  runApp(const MaterialApp(
    home: Rainbow(),
  ));
  // FlutterNativeSplash.remove();
}
