import 'package:flutter/material.dart';

class FavoritePostScreen extends StatefulWidget {
  const FavoritePostScreen({super.key});

  @override
  State<FavoritePostScreen> createState() => _FavoritePostScreenState();
}

class _FavoritePostScreenState extends State<FavoritePostScreen> {
  bool heart = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Image.asset("assets/icon/arrow_forward.png"),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: '지금까지 좋아요한 글 검색',
                        hintStyle: TextStyle(
                          color: Color(0xffB7B7B7),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        prefixIcon: Image.asset("assets/icon/serech.png"),
                        prefixIconColor: Color(0xffD0D0D0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                "지금까지 좋아요한 글 검색",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 16),
              favoritePostList(),
              SizedBox(height: 16),
              favoritePostList(),
              SizedBox(height: 16),
              favoritePostList(),
              SizedBox(height: 16),
              favoritePostList(),
              SizedBox(height: 16),
              favoritePostList(),
              SizedBox(height: 16),
              favoritePostList(),
              SizedBox(height: 16),
              favoritePostList(),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector favoritePostList() {
    return GestureDetector(
      child: SizedBox(
        width: 364,
        height: 44,
        child: Row(
          children: [
            Text(
              '류수봉..',
              style: TextStyle(
                color: Color(0xff808080),
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            SizedBox(width: 5),
            Flexible(
              child: Text(
                softWrap: true,
                '전기차 전손 사고당했는데 합의금 얼마 정도가 적당한가요',
                style: TextStyle(
                  color: Color(0xff454545),
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  heart = !heart;
                });
              },
              child: Image.asset(
                heart ? 'assets/icon/heart.png' : 'assets/icon/heart_on.png',
              ),
            ),
            Text('14'),
          ],
        ),
      ),
    );
  }
}
