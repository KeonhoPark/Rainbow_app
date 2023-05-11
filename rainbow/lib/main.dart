import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:rainbow/rainbow/rainbow.dart';
import 'package:camera/camera.dart';

const List<String> pc_type = <String>['봄 웜톤', '여름 쿨톤', '가을 웜톤', '겨울 쿨톤'];
// List<CameraDescription>? cameras;

//유저의 설정된 퍼스널컬러로 변경해야 함.
String cur_pc_type = '여름 쿨톤';
String nickName = 'qkrrjsgh';
String image_url = "https://i.ibb.co/CwzHq4z/trans-logo-512.png";

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // cameras = await availableCameras();
  // FlutterNativeSplash.
  runApp(const MaterialApp(
    home: Rainbow(),
  ));
  // FlutterNativeSplash.remove();
}
