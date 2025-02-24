import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_task/screens/main_screen.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _textPosition = -300;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _textPosition = MediaQuery.of(context).size.width / 2 - 150;
      });
    });

    Future.delayed(Duration(seconds: 3), () {
      Get.off(() => MainScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg_splash.png"),
                // Ensure image path is correct
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Text(
                "My Store",
                style: TextStyle(
                  fontSize: 40, // Adjusted font size
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontFamily: 'Times New Roman',
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            left: _textPosition, // Center horizontally
            bottom: MediaQuery.of(context).size.height *
                0.2, // Adjusted bottom position
            child: Container(
              width: MediaQuery.of(context).size.width *
                  0.8, // Ensure text stays readable
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, // Center text
                children: [
                  Text(
                    "Välkommen",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Hos oss kan du boka tid hos nästan alla Sveriges salonger och mottagningar.Boka frisör, massage, skönhetsbehandlingar, friskvård och mycket mer.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
