import 'package:flutter/material.dart';
import 'package:rainbow/rainbow/help.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'home.dart';
import 'myPage.dart';
import 'camera.dart';
import 'whatIsPC.dart';

Color rainbowPrimaryColor = Color.fromARGB(255, 38, 103, 240);

class Rainbow extends StatefulWidget {
  const Rainbow({Key? key}) : super(key: key);

  @override
  _Rainbow createState() => _Rainbow();
}

class _Rainbow extends State<Rainbow> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Image.asset(
          'assets/splash.png',
          height: 40,
        ),
        centerTitle: true,
      ),
      body: IndexedStack(
        index: currentIndex, // index 순서에 해당하는 child를 맨 위에 보여줌
        children: [
          Home(),
          Camera(),
          MyPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex, // 현재 보여주는 탭
        onTap: (newIndex) {
          print("selected newIndex : $newIndex");
          // 다른 페이지로 이동
          setState(() {
            currentIndex = newIndex;
          });
        },
        selectedItemColor: rainbowPrimaryColor, // 선택된 아이콘 색상
        unselectedItemColor: Colors.grey, // 선택되지 않은 아이콘 색상
        showSelectedLabels: false, // 선택된 항목 label 숨기기
        showUnselectedLabels: false, // 선택되지 않은 항목 label 숨기기
        type: BottomNavigationBarType.fixed, // 선택시 아이콘 움직이지 않기
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/splash.png',
                height: 20,
              ),
              label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Stack(children: [
            Column(
              children: [
                DrawerHeader(
                    margin: EdgeInsets.all(0),
                    decoration: BoxDecoration(color: Colors.amber),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 36,
                              backgroundColor: Colors.white,
                              child: Image.network(
                                "https://i.ibb.co/CwzHq4z/trans-logo-512.png",
                                width: 40,
                              ),
                            ),
                          ),
                          Text(
                            "닉네임",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "내 퍼스널컬러 : 겨울쿨톤",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => WhatIsPC()))),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "퍼스널컬러란?",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => Help()))),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "도움말",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
                bottom: 0,
                child: IconButton(
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    print("exit");
                  },
                ))
          ]),
        ),
      ),
    ));
  }
}
