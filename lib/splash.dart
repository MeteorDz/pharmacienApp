import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sqlitedatabase/dbhelper.dart';
import 'package:sqlitedatabase/main.dart';

class SplashView extends StatefulWidget {
  SplashView({Key? key, required DbHelper db}) : super(key: key);
  final DbHelper db = DbHelper();

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: 3), _redirect);
  }

  @override
  Widget build(BuildContext context) {
    String logoIc = 'assets/icons/icon.png';
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(185, 70, 134, 93),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(logoIc)
                    .animate()
                    .fade(duration: 500.ms)
                    .then()
                    .slideY(
                        delay: 50.ms,
                        duration: 500.ms,
                        curve: Curves.easeInOutSine),
                Container(
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: Text(' phrase phrase phrase phrase phrase phrase ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 30))
                        .animate()
                        .shake(delay: 1000.ms),
                  ),
                ), 
              ],
            ),
          ),
        ],
      ),
    );
  }

  _redirect() {
     Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>   MyHomePage(
                db: widget.db, title: 'فرمسيــــان'
                )));
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
