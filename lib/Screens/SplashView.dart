import 'dart:async';

import 'package:flutter/material.dart';
import 'package:incidencias_reportes/Screens/loginPage.dart';
import 'package:get/get.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 1), () {
      Get.to(LoginPage());
    });
    return Scaffold(
      body: Center(
        child:
          Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 30),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 162, 6, 189),
                  Color.fromARGB(255, 83, 5, 97)
                ],
              ),
            ),
            child: Image.asset(
              'assets/logo2.png',
              //color: Colors.white,
              height: 400,
            ),
            
          ),
      ),
    );
  }
}