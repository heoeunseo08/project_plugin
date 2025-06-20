import 'package:flutter/material.dart';
import 'package:project_plugin/find_id_spalsh_screen.dart';

class FindidScreen extends StatefulWidget {
  const FindidScreen({super.key});

  @override
  State<FindidScreen> createState() => _FindidScreenState();
}

class _FindidScreenState extends State<FindidScreen> {
  final TextEditingController usernamecontroller = TextEditingController();

  final TextEditingController phoneNumbercontroller = TextEditingController();

  String? errorMessage;

  bool obscurePassword = true;

  bool errorstatus = false;

  bool loginremember = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "아이디 찾기",
                    style: TextStyle(
                      color: Color(0xff454545),
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 40),
                  _TextFieldLabel("이메일"),
                  TextFormField(
                    cursorColor: Colors.black,
                    controller: usernamecontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '이메일을 입력해주세요.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "프로필에 등록된 이메일을 입력해주세요",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusColor: Colors.black,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      errorText: errorMessage,
                      errorStyle: TextStyle(color: Colors.red, fontSize: 11),
                    ),
                  ),
                  SizedBox(height: 20),
                  _TextFieldLabel("전화번호"),
                  TextField(
                    obscureText: obscurePassword,
                    cursorColor: Colors.black,
                    controller: phoneNumbercontroller,
                    decoration: InputDecoration(
                      hintText: "프로필에 등록된 전화번호를 입력해주세요",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusColor: Colors.black,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      errorText: errorMessage,
                      errorStyle: TextStyle(color: Colors.red, fontSize: 11),
                    ),
                  ),
                  SizedBox(height: 250),
                  SizedBox(
                    width: double.infinity,
                    height: 57,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => FindIdSpalshScreen(
                                  userName: usernamecontroller.text,
                                ),
                          ),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                          Color(0xffFFE551),
                        ),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      child: Text(
                        "아이디 찾기",
                        style: TextStyle(
                          color: Color(0xff454545),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xff808080),
                            width: 1,
                          ),
                        ),
                      ),
                      child: Text(
                        "로그인 화면으로 이동",
                        style: TextStyle(
                          color: Color(0xff808080),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Align _TextFieldLabel(String text) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
              color: Color(0xff454545),
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          errorstatus
              ? Text(
                "*",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              )
              : Container(),
        ],
      ),
    );
  }
}
