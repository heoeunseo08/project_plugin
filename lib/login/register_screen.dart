import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_plugin/login/register_spalsh_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController useridcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController checkpasswordcontroller = TextEditingController();

  bool obscurePassword = true;
  bool obscureCheckPassword = true;
  bool errorstatus = false;
  String? errorMessage;
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

  Widget toggleObscureCheckPassword() {
    return IconButton(
      icon:
          obscureCheckPassword
              ? Image.asset('assets/icon/eyes_off.png')
              : Image.asset('assets/icon/eyes_on.png'),
      onPressed: () {
        setState(() {
          obscureCheckPassword = !obscureCheckPassword;
        });
      },
    );
  }

  void showmessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: Duration(milliseconds: 500)),
    );
  }

  Future<void> register(BuildContext context) async {
    try {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (context) => RegisterSpalshScreen(userId: useridcontroller.text),
        ),
      );
    } on FirebaseAuthException catch (e) {
      showmessage("회원가입 실패: ${e.message}");
    }
  }

  void checkRegister() {
    if (useridcontroller.text.isEmpty) {
      setState(() {
        errorMessage = "아이디를 입력해주세요.";
        errorstatus = true;
      });
    } else if (passwordcontroller.text.isEmpty) {
      setState(() {
        errorMessage = "비밀번호를 입력해주세요.";
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
    } else if (passwordcontroller.text.length < 8 ||
        passwordcontroller.text.length > 16) {
      setState(() {
        errorMessage = "영문과 숫자를 포함하여 8~16자리 비밀번호를 입력해주세요.";
        errorstatus = true;
      });
    } else if (passwordcontroller.text != checkpasswordcontroller.text) {
      setState(() {
        errorMessage = "비밀번호가 일치하지 않아요.";
        errorstatus = true;
      });
    } else {
      setState(() {
        errorMessage = null;
        errorstatus = false;
      });
      register(context);
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
              "회원가입",
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
            SizedBox(height: 20),
            _TextFieldLabel("비밀번호 확인"),
            TextField(
              obscureText: obscureCheckPassword,
              cursorColor: Colors.black,
              controller: checkpasswordcontroller,
              decoration: InputDecoration(
                hintText: "비밀번호를 다시 입력해주세요",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusColor: Colors.black,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                errorText: errorMessage,
                errorStyle: TextStyle(color: Colors.red, fontSize: 11),
                suffixIcon: toggleObscureCheckPassword(),
              ),
            ),
            SizedBox(height: 120),
            SizedBox(
              width: double.infinity,
              height: 57,
              child: ElevatedButton(
                onPressed: () {
                  checkRegister();
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
                  "회원가입",
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
                    bottom: BorderSide(color: Color(0xff808080), width: 1),
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
