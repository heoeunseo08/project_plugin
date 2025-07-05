import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_plugin/login/check_auth.dart';
import 'package:project_plugin/login/find_id_screen.dart';
import 'package:project_plugin/login/passwordReset_screen.dart';
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

  String? emailError;
  String? passwordError;
  bool obscurePassword = true;
  bool loginremember = true;
  bool isLoading = false;

  void showmessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: Duration(milliseconds: 800)),
    );
  }

  Future<void> login(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: useridcontroller.text.trim(),
        password: passwordcontroller.text.trim(),
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('keepLogin', loginremember);

      // ignore: use_build_context_synchronously
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => CheckAuth()));
      showmessage('로그인 성공!');
    } on FirebaseAuthException catch (e) {
      showmessage('로그인 실패: ${e.message ?? "다시 시도해주세요"}');
    } finally {
      setState(() {
        isLoading = false;
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
    final email = useridcontroller.text.trim();
    final password = passwordcontroller.text;

    setState(() {
      emailError = null;
      passwordError = null;
    });

    if (email.isEmpty) {
      setState(() => emailError = "이메일을 입력해주세요.");
    } else if (email.contains(" ")) {
      setState(() => emailError = "이메일에 공백이 포함될 수 없습니다.");
    } else if (RegExp(r'[!#\$%^&*()]').hasMatch(email)) {
      setState(() => emailError = "이메일에 특수문자가 포함될 수 없습니다.");
    } else if (password.isEmpty) {
      setState(() => passwordError = "비밀번호를 입력해주세요.");
    } else if (password.length < 8 || password.length > 16) {
      setState(() => passwordError = "비밀번호는 8자 이상 16자 이하로 입력해주세요.");
    } else {
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
            _TextFieldLabel("이메일", emailError != null),
            TextFormField(
              cursorColor: Colors.black,
              controller: useridcontroller,
              decoration: InputDecoration(
                hintText: "이메일을 입력해주세요",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                errorText: emailError,
                errorStyle: TextStyle(color: Colors.red, fontSize: 11),
              ),
            ),
            SizedBox(height: 20),
            _TextFieldLabel("비밀번호", passwordError != null),
            TextField(
              obscureText: obscurePassword,
              cursorColor: Colors.black,
              controller: passwordcontroller,
              decoration: InputDecoration(
                hintText: "비밀번호를 입력해주세요",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                errorText: passwordError,
                errorStyle: TextStyle(color: Colors.red, fontSize: 11),
                suffixIcon: toggleObscurePassword(),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                IconButton(
                  onPressed:
                      () => setState(() => loginremember = !loginremember),
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
            SizedBox(height: 30),
            SizedBox(
              width: 230,
              height: 17,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 81, height: 1, color: Color(0xffD9D9D9)),
                  Text(
                    '간편 로그인',
                    style: TextStyle(fontSize: 12, color: Color(0xff808080)),
                  ),
                  Container(width: 81, height: 1, color: Color(0xffD9D9D9)),
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
                onPressed: isLoading ? null : checkLogin,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Color(0xffFFE551)),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                child:
                    isLoading
                        ? CircularProgressIndicator(color: Colors.black)
                        : Text(
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
                _LinkButton("회원가입", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => RegisterScreen()),
                  );
                }),
                SizedBox(width: 10),
                _LinkButton("아이디 찾기", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => FindidScreen()),
                  );
                }),
                SizedBox(width: 10),
                _LinkButton("비밀번호 재설정", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => PasswordresetScreen()),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Align _TextFieldLabel(String text, bool isError) {
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
          if (isError)
            Text(
              "*",
              style: TextStyle(
                color: Colors.red,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }

  Widget _LinkButton(String text, VoidCallback onTap) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        text,
        style: TextStyle(
          color: Color(0xff808080),
          fontSize: 14,
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.underline,
          decorationColor: Color(0xff808080),
        ),
      ),
    );
  }
}
