import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: -113,
            left: -81,
            child: Stack(
              children: [
                Container(
                  width: 297,
                  height: 297,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(233, 231, 116, 0.498),
                        blurRadius: 100,
                        spreadRadius: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 574,
            left: 133,
            child: Stack(
              children: [
                Container(
                  width: 341,
                  height: 324,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(255, 128, 94, 0.5),
                        blurRadius: 100,
                        spreadRadius: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 40.1,
            left: 60,
            child: Icon(
              Icons.handshake,
              size: 150,
            ),
            width: 282.13,
            height: 291.24,
          ),
          Positioned(
            top: 400,
            left: 55,
            width: 283,
            height: 185,
            child: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Welcome to',
                      style: TextStyle(
                        fontSize: 36,
                        fontFamily: 'Bebas Neue',
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(0, 0, 0, 1),
                        letterSpacing: -0.4,
                      ),
                    ),
                    TextSpan(
                      text: ' QuickDone',
                      style: TextStyle(
                        fontSize: 40,
                        fontFamily: 'Bebas Neue',
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(176, 201, 41, 1),
                        letterSpacing: -0.4,
                      ),
                    ),
                    TextSpan(
                      text: ' Done Your Work Quickly',
                      style: TextStyle(
                        fontSize: 38,
                        fontFamily: 'Bebas Neue',
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(0, 0, 0, 1),
                        letterSpacing: -0.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 690,
            left: 125.01,
            width: 150,
            height: 35,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/First');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color.fromARGB(255, 0, 0, 0), // Text color
                  textStyle: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'DM Sans',
                  ),
                  minimumSize: Size(150, 45), // Button size
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10), // Button corner radius
                  ),
                ),
                child: Text('Continue'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
