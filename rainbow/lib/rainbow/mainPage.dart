// @dart=2.17
import 'package:flutter/material.dart';
import 'package:rainbow/rainbow/camera.dart';
import 'package:rainbow/rainbow/rainbow.dart';
import 'package:rainbow/rainbow/virtualMakeUp.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Positioned(
              top: 50,
              child: Image.asset(
                'assets/mainPage.jpg',
                width: 250,
              ),
            ),
            Positioned(
              bottom: 50,
              child: Column(children: [
                ElevatedButton(
                    onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: ((context) => Camera())),
                        ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: rainbowPrimaryColor,
                        fixedSize: Size.fromWidth(200)),
                    child: Text(
                      '퍼스널 컬러 측정하기',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )),
                ElevatedButton(
                    onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => VirtualMakeUp())),
                        ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: rainbowPrimaryColor,
                        fixedSize: Size.fromWidth(200)),
                    child: Text(
                      '퍼스널 컬러 가상 메이크업',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
