import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditCommunityScreen extends StatefulWidget {
  const EditCommunityScreen({super.key});

  @override
  State<EditCommunityScreen> createState() => _EditCommunityScreenState();
}

class _EditCommunityScreenState extends State<EditCommunityScreen> {
  final List<XFile> _imageFiles = [];
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _postname = TextEditingController();
  final TextEditingController _post = TextEditingController();

  Future<void> _pickImages() async {
    final List<XFile> selectedImages = await _picker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      setState(() {
        _imageFiles.addAll(selectedImages);
      });
    }
  }

  Widget _buildImagePreview() {
    if (_imageFiles.isEmpty) {
      return Text('No images selected.');
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children:
            _imageFiles.map((image) {
              return Stack(
                children: [
                  Image.file(
                    File(image.path),
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _imageFiles.remove(image); // 이미지 삭제
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.close, color: Colors.white, size: 16),
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "글쓰기",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    LabelText("제목"),
                    TextField(
                      controller: _postname,
                      cursorColor: Color(0xffB7B7B7),
                      decoration: InputDecoration(
                        hintText: "글 제목을 입력해 주세요.",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color(0xffB7B7B7),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffB7B7B7)),
                        ),

                        focusColor: Color(0xffB7B7B7),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    LabelText("글 내용"),
                    TextField(
                      controller: _post,
                      maxLines: null,
                      minLines: 5,
                      decoration: InputDecoration(
                        hintText: "글 내용을 입력해 주세요.",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color(0xffB7B7B7),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffB7B7B7)),
                        ),

                        focusColor: Color(0xffB7B7B7),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),

                    SizedBox(height: 16),
                    LabelText("이미지 등록"),
                    _buildImagePreview(),
                    SizedBox(height: 16),
                    OutlinedButton(
                      onPressed: _pickImages,
                      style: ButtonStyle(
                        minimumSize: WidgetStateProperty.all(
                          Size(double.infinity, 54),
                        ),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        backgroundColor: WidgetStateProperty.all(Colors.white),
                        side: WidgetStateProperty.all(
                          BorderSide(color: Color(0xffFFE551)),
                        ),
                      ),

                      child: Text(
                        "이미지 등록",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color(0xff454545),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      minimumSize: WidgetStateProperty.all(
                        Size(double.infinity, 54),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      backgroundColor: WidgetStateProperty.all(
                        Color(0xffFFE551),
                      ),
                    ),
                    child: Text(
                      '글 등록하기',
                      style: TextStyle(
                        color: Color(0xff454545),
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Align LabelText(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
      ),
    );
  }
}
