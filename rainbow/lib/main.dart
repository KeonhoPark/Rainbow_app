import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:rainbow/rainbow/rainbow.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.
  runApp(const MaterialApp(
    home: Rainbow(),
  ));
  // FlutterNativeSplash.remove();
}
