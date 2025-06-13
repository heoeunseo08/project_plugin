import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_plugin/findID_screen.dart';
import 'package:project_plugin/passwordReset_screen.dart';
import 'package:project_plugin/register_screen.dart';

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

  bool loginremember = false;
  void showmessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: Duration(milliseconds: 500)),
    );
  }

  Future<void> login(BuildContext context) async {
    // 여기에 로그인 로직을 추가하세요.
    // 예를 들어, Firebase Auth를 사용하여 로그인할 수 있습니다.
    // 로그인 성공 시 다음 화면으로 이동하거나 성공 메시지를 표시합니다.

    // 예시: 로그인 성공 후 메시지 표시
    showmessage("로그인 성공!");

    // 로그인 성공 후 다른 화면으로 이동하려면 아래 코드를 사용하세요.
    // Navigator.pushReplacementNamed(context, '/home');
  }

  Widget toggleObscurePassword() {
    return IconButton(
      icon:
          obscurePassword
              ? Image.asset('assets/icon/eyes_off.png')
              : SvgPicture.asset('assets/icon/eye_on.svg'),
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
      });
    } else if (passwordcontroller.text.isEmpty) {
      setState(() {
        errorMessage = "비밀번호를 입력해주세요.";
      });
    } else {
      setState(() {
        errorMessage = null;
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
            _TextFieldLabel("아이디"),
            TextFormField(
              cursorColor: Colors.black,
              controller: useridcontroller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '아이디를 입력해주세요.';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "아이디를 입력해주세요",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusColor: Colors.black,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                errorText: errorMessage,
                errorStyle: TextStyle(color: Colors.red, fontSize: 14),
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
                suffixIcon: toggleObscurePassword(),
              ),
            ),
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
                    "아이디 저장",
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
                  login(context);
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
                      fontSize: 16,
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
                          return PasswordresetScreen();
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
      child: Text(
        text,
        style: TextStyle(
          color: Color(0xff454545),
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
