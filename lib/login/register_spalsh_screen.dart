import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_plugin/login/login_screen.dart';

class RegisterSpalshScreen extends StatefulWidget {
  final String userId;
  const RegisterSpalshScreen({super.key, required this.userId});

  @override
  State<RegisterSpalshScreen> createState() => _RegisterSpalshScreenState();
}

class _RegisterSpalshScreenState extends State<RegisterSpalshScreen> {
  String now = DateFormat('yyyy. MM. dd').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "회원가입 완료",
              style: TextStyle(
                color: Color(0xff454545),
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 90),
            Text(
              "회원가입이 완료되었어요",
              style: TextStyle(
                color: Color(0xff454545),
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "로그인 화면에서 로그인을 진행해주세요",
              style: TextStyle(
                color: Color(0xff454545),
                fontSize: 16,
                fontWeight: FontWeight.w400,
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
                    "회원가입 아이디: ${widget.userId}",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color(0xff454545),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "가입일: $now ",
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
              width: double.infinity,
              height: 57,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
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
                  "로그인 화면으로 이동",
                  style: TextStyle(
                    color: Color(0xff454545),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
