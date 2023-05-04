import 'package:flutter/material.dart';
import 'camera_preview_scanner.dart';

class VirtualMakeUp extends StatelessWidget {
  const VirtualMakeUp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const CameraPreviewScanner(),
    );
  }
}
