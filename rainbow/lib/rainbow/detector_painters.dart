// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// @dart=2.9

import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_ml_vision/google_ml_vision.dart';

const List<Point<int>> faceMaskConnections = [
  Point(0, 4),
  Point(0, 55),
  Point(4, 7),
  Point(4, 55),
  Point(4, 51),
  Point(7, 11),
  Point(7, 51),
  Point(7, 130),
  Point(51, 55),
  Point(51, 80),
  Point(55, 72),
  Point(72, 76),
  Point(76, 80),
  Point(80, 84),
  Point(84, 72),
  Point(72, 127),
  Point(72, 130),
  Point(130, 127),
  Point(117, 130),
  Point(11, 117),
  Point(11, 15),
  Point(15, 18),
  Point(18, 21),
  Point(21, 121),
  Point(15, 121),
  Point(21, 25),
  Point(25, 125),
  Point(125, 128),
  Point(128, 127),
  Point(128, 29),
  Point(25, 29),
  Point(29, 32),
  Point(32, 0),
  Point(0, 45),
  Point(32, 41),
  Point(41, 29),
  Point(41, 45),
  Point(45, 64),
  Point(45, 32),
  Point(64, 68),
  Point(68, 56),
  Point(56, 60),
  Point(60, 64),
  Point(56, 41),
  Point(64, 128),
  Point(64, 127),
  Point(125, 93),
  Point(93, 117),
  Point(117, 121),
  Point(121, 125),
];

class FaceDetectorPainter extends CustomPainter {
  FaceDetectorPainter(this.absoluteImageSize, this.faces);

  final Size absoluteImageSize;
  final List<Face> faces;

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / absoluteImageSize.width;
    final double scaleY = size.height / absoluteImageSize.height;

    final Paint paint = Paint()
      // ..style = PaintingStyle.fill
      // ..colorFilter =
      //     ColorFilter.mode(Colors.amber.withOpacity(0.5), BlendMode.plus)
      ..color = ui.Color.fromARGB(255, 112, 26, 26).withOpacity(1.0)
      ..blendMode = BlendMode.plus;
    // ..strokeWidth = 2;

    for (final Face face in faces) {
      final LLBContour = face.getContour(FaceContourType.lowerLipBottom);
      final LLTContour = face.getContour(FaceContourType.lowerLipTop);
      final ULBContour = face.getContour(FaceContourType.upperLipBottom);
      final ULTContour = face.getContour(FaceContourType.upperLipTop);
      final LEBContour = face.getContour(FaceContourType.leftEyebrowBottom);
      final LETContour = face.getContour(FaceContourType.leftEyebrowTop);
      final REBContour = face.getContour(FaceContourType.rightEyebrowBottom);
      final RETContour = face.getContour(FaceContourType.rightEyebrowTop);

      drawUpperLip(canvas, ULBContour, size, scaleX, scaleY, ULTContour, paint);

      drawLowerLip(canvas, LLBContour, size, scaleX, scaleY, LLTContour, paint);

      drawLeftEyebrow(
          canvas, LEBContour, size, scaleX, scaleY, LETContour, paint);

      drawRightEyebrow(
          canvas, REBContour, size, scaleX, scaleY, RETContour, paint);
    }
  }

  Path getPath(List<Offset> drawPoints) {
    Path path = Path();
    for (int i = 0; i < drawPoints.length; i++) {
      path.lineTo(drawPoints[i].dx, drawPoints[i].dy);
    }
    return path;
  }

  void drawLeftEyebrow(ui.Canvas canvas, FaceContour LEBContour, ui.Size size,
      double scaleX, double scaleY, FaceContour LETContour, ui.Paint paint) {
    List<Offset> drawPoints = LEBContour.positionsList
            .map((offset) =>
                Offset(size.width - (offset.dx * scaleX), offset.dy * scaleY))
            .toList() +
        LETContour.positionsList
            .map((offset) =>
                Offset(size.width - (offset.dx * scaleX), offset.dy * scaleY))
            .toList()
            .reversed
            .toList();
    drawPoints.add(drawPoints.first);

    return canvas.drawPath(getPath(drawPoints), paint);
  }

  void drawRightEyebrow(ui.Canvas canvas, FaceContour REBContour, ui.Size size,
      double scaleX, double scaleY, FaceContour RETContour, ui.Paint paint) {
    List<Offset> drawPoints = REBContour.positionsList
            .map((offset) =>
                Offset(size.width - (offset.dx * scaleX), offset.dy * scaleY))
            .toList() +
        RETContour.positionsList
            .map((offset) =>
                Offset(size.width - (offset.dx * scaleX), offset.dy * scaleY))
            .toList()
            .reversed
            .toList();
    drawPoints.add(drawPoints.first);

    return canvas.drawPath(getPath(drawPoints), paint);
  }

  void drawUpperLip(ui.Canvas canvas, FaceContour ULBContour, ui.Size size,
      double scaleX, double scaleY, FaceContour ULTContour, ui.Paint paint) {
    List<Offset> drawPoints = ULBContour.positionsList
            .map((offset) =>
                Offset(size.width - (offset.dx * scaleX), offset.dy * scaleY))
            .toList() +
        ULTContour.positionsList
            .map((offset) =>
                Offset(size.width - (offset.dx * scaleX), offset.dy * scaleY))
            .toList()
            .reversed
            .toList();
    drawPoints.add(drawPoints.first);

    return canvas.drawPath(getPath(drawPoints), paint);
  }

  void drawLowerLip(ui.Canvas canvas, FaceContour LLBContour, ui.Size size,
      double scaleX, double scaleY, FaceContour LLTContour, ui.Paint paint) {
    List<Offset> drawPoints = LLBContour.positionsList
            .map((offset) =>
                Offset(size.width - (offset.dx * scaleX), offset.dy * scaleY))
            .toList() +
        LLTContour.positionsList
            .map((offset) =>
                Offset(size.width - (offset.dx * scaleX), offset.dy * scaleY))
            .toList()
            .reversed
            .toList();
    drawPoints.add(drawPoints.first);

    return canvas.drawPath(getPath(drawPoints), paint);
  }

  @override
  bool shouldRepaint(FaceDetectorPainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.faces != faces;
  }
}
