// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// @dart=2.9

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_vision/google_ml_vision.dart';

import 'detector_painters.dart';
import 'scanner_utils.dart';
import 'package:gallery_saver/gallery_saver.dart';

class CameraPreviewScanner extends StatefulWidget {
  const CameraPreviewScanner({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CameraPreviewScannerState();
}

class _CameraPreviewScannerState extends State<CameraPreviewScanner> {
  dynamic _scanResults;
  CameraController _camera;
  bool _isDetecting = false;
  final CameraLensDirection _direction = CameraLensDirection.front;

  final FaceDetector _faceDetector = GoogleVision.instance
      .faceDetector(FaceDetectorOptions(enableContours: true));

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final CameraDescription description =
        await ScannerUtils.getCamera(_direction);

    _camera = CameraController(
      description,
      defaultTargetPlatform == TargetPlatform.android
          ? ResolutionPreset.high
          : ResolutionPreset.high,
      enableAudio: false,
    );
    await _camera.initialize();

    await _camera.startImageStream((CameraImage image) {
      if (_isDetecting) return;

      _isDetecting = true;

      ScannerUtils.detect(
        image: image,
        detectInImage: _faceDetector.processImage,
        imageRotation: description.sensorOrientation,
      ).then(
        (dynamic results) {
          if (_faceDetector == null) return;
          setState(() {
            _scanResults = results;
          });
        },
      ).whenComplete(() => Future.delayed(
          Duration(
            milliseconds: 100,
          ),
          () => {_isDetecting = false}));
    });
  }

  void _takeSnapShot() async {
    XFile image = await _camera.takePicture();
    if (image != null) {
      GallerySaver.saveImage(image.path);
    }
  }

  Widget _buildResults() {
    const Text noResultsText = Text('No results!');

    if (_scanResults == null ||
        _camera == null ||
        !_camera.value.isInitialized) {
      return noResultsText;
    }

    CustomPainter painter;

    final Size imageSize = Size(
      _camera.value.previewSize.height,
      _camera.value.previewSize.width,
    );

    if (_scanResults is! List<Face>) return noResultsText;
    painter = FaceDetectorPainter(imageSize, _scanResults);

    return CustomPaint(
      painter: painter,
    );
  }

  Widget _buildImage() {
    return Container(
      constraints: const BoxConstraints.expand(),
      child: _camera == null
          ? const Center(
              child: Text(
                'Initializing Camera...',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 30,
                ),
              ),
            )
          : Stack(
              fit: StackFit.expand,
              children: <Widget>[
                CameraPreview(_camera),
                _buildResults(),
              ],
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildImage(),
      floatingActionButton: FloatingActionButton(
          onPressed: _takeSnapShot, child: Icon(Icons.get_app)),
    );
  }

  @override
  void dispose() {
    _camera.dispose().then((_) {
      _faceDetector.close();
    });

    super.dispose();
  }
}
