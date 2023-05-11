import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rainbow/rainbow/developmentInfo.dart';
import '../main.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  TextEditingController textController = TextEditingController();
  String? error;

  @override
  void initState() {
    super.initState();
    textController.text = nickName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: Colors.amber,
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: textController,
                    autovalidateMode: AutovalidateMode.always,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: '닉네임',
                      labelStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      // 유저의 기존 아이디로 변경해야함.
                      hintText: nickName,
                    ),
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return '닉네임을 입력해주세요.';
                      }
                      if (2 > input.length) {
                        return '닉네임이 너무 짧습니다.';
                      }
                      if (input.length > 16) {
                        return '닉네임이 너무 깁니다.';
                      }
                      return null;
                    },
                    onFieldSubmitted: (input) {
                      setState(() {
                        if (input != null &&
                            input.length >= 2 &&
                            input.length <= 16) {
                          nickName = textController.text;
                          print(nickName);
                        } else {
                          textController.text = nickName;
                        }
                        print(nickName);
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text(
                        "내 퍼스널컬러 : ",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      DropdownButton(
                        alignment: Alignment.topLeft,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        value: cur_pc_type,
                        items: pc_type
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            cur_pc_type = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DevelopmentInfo()),
            ),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "개발자 정보",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
