import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:rainbow/main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rainbow/rainbow/loading.dart';
import 'package:rainbow/rainbow/rainbow.dart';
import 'mainPage.dart';
import 'package:google_ml_vision/google_ml_vision.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  CameraController? controller;
  bool _isCameraInitialized = false;
  File? imageFile = null;
  List<Face> faces = [];
  final FaceDetector _faceDetector = GoogleVision.instance.faceDetector();

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    await previousCameraController?.dispose();

    if (mounted) {
      setState(() {
        controller = cameraController;
      });
    }

    cameraController.addListener(() {
      if (mounted) setState(() {});
    });

    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      print('cameraException: $e');
    }

    if (mounted) {
      setState(() {
        _isCameraInitialized = controller!.value.isInitialized;
      });
    }
  }

  @override
  void initState() {
    onNewCameraSelected(cameras[1]);
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      onNewCameraSelected(cameraController.description);
    }
  }

  Future<XFile?> takePicture() async {
    final CameraController? cameraController = controller;
    if (cameraController!.value.isTakingPicture) {
      return null;
    }

    try {
      XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      print('error occured while taking picture: $e');
      return null;
    }
  }

  void flutterDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(imageFile == null ? "사진을 촬영해 주세요" : "얼굴이 나오게 촬영해 주세요"),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: new Text("확인"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rainbowPrimaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              _isCameraInitialized
                  ? AspectRatio(
                      aspectRatio: 1 / controller!.value.aspectRatio,
                      child: imageFile == null
                          ? controller!.buildPreview()
                          : Image.file(imageFile!),
                    )
                  : Container(),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () async {
                      XFile? rawImage = await takePicture();
                      imageFile = File(rawImage!.path);
                      GoogleVisionImage visionImage =
                          GoogleVisionImage.fromFile(imageFile!);
                      faces = await _faceDetector.processImage(visionImage);
                      if (faces.isEmpty) {
                        // imageFile = null;
                        print("No face!");
                        setState(() {});
                      }
                      GallerySaver.saveImage(imageFile!.path);
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(Icons.circle, color: Colors.white38, size: 80),
                        Icon(Icons.circle, color: Colors.white, size: 65),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                    onPressed: () {
                      print('다시 촬영 클릭 됨');
                      imageFile = null;
                      setState(() {});
                    },
                    child: Text(
                      "다시 촬영",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                    onPressed: () {
                      print('측정하기 클릭 됨');
                      if (imageFile != null && faces.isNotEmpty) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Loading(),
                            ));
                      } else {
                        flutterDialog();
                        setState(() {});
                      }
                    },
                    child: Text(
                      "측정하기",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
