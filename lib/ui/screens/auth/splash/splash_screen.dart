import 'dart:async';

import 'package:energize_flutter/conustant/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}


class _SplashScreen extends State<SplashScreen>{

  @override
  void initState() {
    super.initState();
    time();
  }

  time() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await Timer(
      Duration(seconds: 5),
          () {
        if (prefs.getBool("isLogin") == true) {
          Navigator.pushNamedAndRemoveUntil(
              context, "/home_screen", ModalRoute.withName('/home_screen'));
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, "/login_screen", ModalRoute.withName('/login_screen'));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.MAINCOLORS,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/logo2.png')
          ),
        ),
      ),
      /*Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/background.png')
              ),
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/logo2.png')
                ),
              ),
            ),
          ),
        ],
      ),*/
    );
  }

}