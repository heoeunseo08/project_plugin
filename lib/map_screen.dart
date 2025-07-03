import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool isloading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri("https://map.kakao.com")),
            onProgressChanged: (controller, progress) {
              if (mounted) {
                setState(() {
                  isloading = progress < 100;
                });
              }
            },
            onLoadStop: (controller, url) {
              if (mounted) {
                setState(() {
                  isloading = false;
                });
              }
            },
          ),
          if (isloading) Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
