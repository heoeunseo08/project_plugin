import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart'; // ✅ 추가
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_plugin/app_screen.dart';
import 'package:project_plugin/main.dart';

Future<void> saveUserData({
  required String name,
  required String username,
  required String phoneNumber,
  required String image,
  required String region,
}) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  final uid = user.uid;

  await FirebaseFirestore.instance.collection('users').doc(uid).set({
    'uid': uid,
    'name': name.trim(),
    'image': image.trim(),
    'username': username.trim(),
    'phoneNumber': phoneNumber.trim(),
    'region': region.trim(),
  });
}

class NumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text.replaceAll(' - ', ' ');
    var buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if ((i == 2 || i == 6) && i != text.length - 1) {
        buffer.write(' - ');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  String dropdownValue = list.first;

  bool errorstatus = false;
  String? errorMessage;
  XFile? file;

  Future<void> _pickImage() async {
    ImagePicker().pickImage(source: ImageSource.gallery).then((image) {
      if (image != null) {
        setState(() {
          file = image;
        });
        Navigator.pop(context);
      }
    });
  }

  // ✅ 수정된 이미지 업로드 함수
  Future<String?> _uploadImageToFirebase(XFile image) async {
    try {
      final fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
      // final ref = FirebaseStorage.instance.ref().child('profile_image/$fileName');
      // final uploadTask = await ref.putFile(File(image.path));
      // return await ref.getDownloadURL();
    } catch (e) {
      print("이미지 업로드 실패: $e");
      return null;
    }
    return null;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: Text(
                  "프로필 등록",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                width: 144,
                height: 144,
                child: Stack(
                  children: [
                    file != null
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.file(
                            File(file!.path),
                            width: 144,
                            height: 144,
                            fit: BoxFit.cover,
                          ),
                        )
                        : Image.asset(
                          "assets/icon/default_user_image.png",
                          width: 144,
                          height: 144,
                        ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        onPressed: () {
                          dialog(context);
                        },
                        icon: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset("assets/icon/add_image_background.png"),
                            Image.asset("assets/icon/add_image_camera.png"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _TextFieldLabel("이름"),
              TextFormField(
                cursorColor: Colors.black,
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '이름을 입력해주세요.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "이름을 입력해주세요",
                  hintStyle: TextStyle(
                    color: Color(0xffB7B7B7),
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  errorText: errorMessage,
                  errorStyle: TextStyle(color: Colors.red, fontSize: 11),
                ),
              ),
              SizedBox(height: 20),
              _TextFieldLabel("닉네임"),
              TextField(
                cursorColor: Colors.black,
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: "커뮤니티에서 사용할 닉네임을 입력해주세요",
                  hintStyle: TextStyle(
                    color: Color(0xffB7B7B7),
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  errorText: errorMessage,
                  errorStyle: TextStyle(color: Colors.red, fontSize: 11),
                ),
              ),
              SizedBox(height: 20),
              _TextFieldLabel("전화번호"),
              TextFormField(
                cursorColor: Colors.black,
                keyboardType: TextInputType.phone,
                controller: phoneNumberController,
                decoration: InputDecoration(
                  hintText: "전화번호를 입력해주세요",
                  hintStyle: TextStyle(
                    color: Color(0xffB7B7B7),
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  errorText: errorMessage,
                  errorStyle: TextStyle(color: Colors.red, fontSize: 11),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  NumberFormatter(),
                  LengthLimitingTextInputFormatter(17),
                ],
              ),
              SizedBox(height: 20),
              _TextFieldLabel("거주 시 또는 도"),
              Container(
                width: double.infinity,
                height: 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffB7B7B7),
                        width: 2.0,
                      ), // outline 색상과 너비 설정
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffB7B7B7),
                        width: 1.0,
                      ), // 활성화 상태에서의 outline
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffB7B7B7),
                        width: 1.0,
                      ),
                    ),
                  ),
                  value: dropdownValue,
                  icon: Icon(Icons.keyboard_arrow_down),
                  elevation: 5,
                  borderRadius: BorderRadius.circular(8),
                  dropdownColor: Colors.white,
                  style: TextStyle(color: Color(0xffB7B7B7)),
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  items:
                      list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 57,
                child: ElevatedButton(
                  onPressed: () async {
                    String? imageUrl = '';

                    if (file != null) {
                      imageUrl = await _uploadImageToFirebase(file!);
                    }

                    await saveUserData(
                      name: nameController.text,
                      username: usernameController.text,
                      phoneNumber: phoneNumberController.text,
                      image: imageUrl ?? '',
                      region: '',
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AppScreen()),
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
                    "프로필 등록",
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
      ),
    );
  }

  void dialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            SizedBox(height: 20),
            Center(
              child: TextButton(
                child: const Text(
                  '앨범에서 사진 선택',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  _pickImage();
                },
              ),
            ),
            Center(
              child: TextButton(
                child: const Text(
                  '기본 프로필 적용',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
