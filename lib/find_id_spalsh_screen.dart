import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_plugin/login_screen.dart';

class FindIdSpalshScreen extends StatefulWidget {
  final String userName;
  const FindIdSpalshScreen({super.key, required this.userName});

  @override
  State<FindIdSpalshScreen> createState() => _FindIdSpalshScreenState();
}

class _FindIdSpalshScreenState extends State<FindIdSpalshScreen> {
  String now = DateFormat('yyyy. MM. dd').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "이메일 찾기",
              style: TextStyle(
                color: Color(0xff454545),
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 90),
            Text(
              "서비스에 가입된 이메일 찾기가",
              style: TextStyle(
                color: Color(0xff454545),
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "완료되었어요",
              style: TextStyle(
                color: Color(0xff454545),
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20),
            Container(
              color: Color(0xffFBFBFB),
              width: double.infinity,
              height: 115,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "가입 이메일:  ${widget.userName}",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color(0xff454545),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "가입일:    $now",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color(0xff454545),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
              width: 364,
              child: Row(
                children: [
                  SizedBox(
                    width: 174,
                    height: 57,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Color(0xffFFE551)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "로그인 화면으로 이동",
                        style: TextStyle(
                          color: Color(0xff454545),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 174,
                    height: 57,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                          (route) => false,
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
                        "비밀번호 재설정",
                        style: TextStyle(
                          color: Color(0xff454545),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
