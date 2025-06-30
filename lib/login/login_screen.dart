import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_plugin/login/check_auth.dart';
import 'package:project_plugin/login/find_id_screen.dart';
import 'package:project_plugin/login/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController useridcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  String? errorMessage;

  bool obscurePassword = true;

  bool errorstatus = false;
  bool loginremember = false;
  void showmessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: Duration(milliseconds: 500)),
    );
  }

  Future<void> login(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('keepLogin', loginremember);
      Navigator.of(
        // ignore: use_build_context_synchronously
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => CheckAuth()));
      showmessage('로그인 성공!');
    } on FirebaseAuthException {
      setState(() {
        errorMessage = "로그인에 실패하셨습니다. 다시 시도해주세요";
        errorstatus = true;
      });
    }
  }

  Widget toggleObscurePassword() {
    return IconButton(
      icon:
          obscurePassword
              ? Image.asset('assets/icon/eyes_off.png')
              : Image.asset('assets/icon/eyes_on.png'),
      onPressed: () {
        setState(() {
          obscurePassword = !obscurePassword;
        });
      },
    );
  }

  void checkLogin() {
    if (useridcontroller.text.isEmpty) {
      setState(() {
        errorMessage = "아이디를 입력해주세요.";
        errorstatus = true;
      });
    } else if (useridcontroller.text.contains(" ")) {
      setState(() {
        errorMessage = "아이디에 공백이 포함될 수 없습니다.";
        errorstatus = true;
      });
    } else if (useridcontroller.text.contains("#") ||
        useridcontroller.text.contains("!") ||
        useridcontroller.text.contains("\$") ||
        useridcontroller.text.contains("%") ||
        useridcontroller.text.contains("^") ||
        useridcontroller.text.contains("&") ||
        useridcontroller.text.contains("*")) {
      setState(() {
        errorMessage = "아이디에 특수문자가 포함될 수 없습니다.";
        errorstatus = true;
      });
    } else if (passwordcontroller.text.isEmpty) {
      setState(() {
        errorMessage = "비밀번호를 입력해주세요.";
        errorstatus = true;
      });
    } else if (passwordcontroller.text.length < 8 ||
        passwordcontroller.text.length > 16) {
      setState(() {
        errorMessage = "비밀번호는 8자 이상 16자 이하로 입력해주세요.";
        errorstatus = true;
      });
    } else {
      setState(() {
        errorMessage = null;
        errorstatus = false;
      });
      login(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "로그인",
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
              controller: useridcontroller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '이메일을 입력해주세요.';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "이메일을 입력해주세요",
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
            _TextFieldLabel("비밀번호"),
            TextField(
              obscureText: obscurePassword,
              cursorColor: Colors.black,
              controller: passwordcontroller,
              decoration: InputDecoration(
                hintText: "비밀번호를 입력해주세요",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusColor: Colors.black,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                errorText: errorMessage,
                errorStyle: TextStyle(color: Colors.red, fontSize: 11),
                suffixIcon: toggleObscurePassword(),
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        loginremember = !loginremember;
                      });
                    },
                    icon: Image.asset(
                      loginremember
                          ? "assets/icon/save_id_on.png"
                          : "assets/icon/save_id_off.png",
                    ),
                  ),
                  Text(
                    "로그인 유지",
                    style: TextStyle(
                      color: Color(0xff454545),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: 230,
              height: 17,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 81,
                    height: 1,
                    child: Container(color: Color(0xffD9D9D9)),
                  ),
                  Text(
                    '간편 로그인',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color(0xff808080),
                    ),
                  ),
                  SizedBox(
                    width: 81,
                    height: 1,
                    child: Container(color: Color(0xffD9D9D9)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Image.asset('assets/icon/naver_login.png'),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset("assets/icon/google_login.png"),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset("assets/icon/kakao_login.png"),
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 57,
              child: ElevatedButton(
                onPressed: () {
                  checkLogin();
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
                  "로그인",
                  style: TextStyle(
                    color: Color(0xff454545),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return RegisterScreen();
                        },
                      ),
                    );
                  },
                  child: Text(
                    "회원가입",
                    style: TextStyle(
                      color: Color(0xff808080),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0xff808080),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return FindidScreen();
                        },
                      ),
                    );
                  },
                  child: Text(
                    "아이디 찾기",
                    style: TextStyle(
                      color: Color(0xff808080),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0xff808080),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return FindidScreen();
                        },
                      ),
                    );
                  },
                  child: Text(
                    "비밀번호 재설정",
                    style: TextStyle(
                      color: Color(0xff808080),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0xff808080),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
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
