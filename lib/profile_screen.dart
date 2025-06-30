import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_plugin/edit_profile_screen.dart';
import 'package:project_plugin/favorite_post_screen.dart';
import 'package:project_plugin/login/login_screen.dart';
import 'package:project_plugin/my_comment_screen.dart';
import 'package:project_plugin/my_post_screen.dart';
import 'package:project_plugin/login/passwordReset_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = '';
  String profileImage = '';
  String email = '';
  String name = '';
  String phoneNumber = '';

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    email = user.email ?? "";
    profileImage = user.photoURL ?? "assets/icon/default_user_image.png";

    final doc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
    final date = doc.data();
    if (date != null) {
      setState(() {
        username = date['username'] ?? "";
        email = date['email'] ?? email;
        name = date['name'] ?? "";
        profileImage = date['profileImage'] ?? profileImage;
        phoneNumber = date['phoneNumber'] ?? "";
      });
    }
  }

  void logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('keepLogin');
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (route) => false,
    );
  }

  void logoutDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: SizedBox(
            width: 340,
            height: 164,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '로그아웃',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),
                Text(
                  '로그아웃 하시겠어요?',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      child: Text('취소', style: TextStyle(color: Colors.black)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffFFE551),
                      ),
                      child: Text(
                        '로그아웃',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        logout(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 108,
                        height: 108,
                        child: Image.asset(
                          "assets/icon/default_user_image.png",
                        ),
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            username,
                            style: TextStyle(
                              color: Color(0xff454545),
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            email,
                            style: TextStyle(
                              color: Color(0xff454545),
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            name,
                            style: TextStyle(
                              color: Color(0xff454545),
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            phoneNumber,
                            style: TextStyle(
                              color: Color(0xff454545),
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: Color(0xffB7B7B7),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              child: SizedBox(
                height: 320,
                width: 412,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        GestureDetectorUnit(unitName: '쓴 글'),
                        SizedBox(height: 15),
                        GestureDetectorUnit(unitName: '좋아요 한 글'),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetectorUnit(unitName: '프로필 편집'),
                        SizedBox(height: 15),
                        GestureDetectorUnit(unitName: '비밀번호 재설정'),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        logoutDialog(context);
                      },
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '로그아웃',
                              style: TextStyle(
                                color: Color(0xffBE3300),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Image.asset("assets/icon/arrow.png"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GestureDetectorUnit extends StatelessWidget {
  final String unitName;
  const GestureDetectorUnit({super.key, required this.unitName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        switch (unitName) {
          case '쓴 글':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyPostScreen()),
            );
            break;
          case '좋아요 한 글':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FavoritePostScreen()),
            );
            break;
          case '내 댓글':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyCommentScreen()),
            );
            break;
          case '프로필 편집':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditProfileScreen()),
            );
            break;
          case '비밀번호 재설정':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PasswordresetScreen()),
            );
            break;
          default:
        }
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              unitName,
              style: TextStyle(
                color: Color(0xff454545),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Image.asset("assets/icon/arrow.png"),
          ],
        ),
      ),
    );
  }
}
