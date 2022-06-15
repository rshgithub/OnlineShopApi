import 'package:api_task/products.dart';
import 'package:api_task/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';

void main() => {runApp(const MyApp())};

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      SharedPreferences shared = await SharedPreferences.getInstance();
      if(shared.getString("token") == null) { Get.to(LoginPage());} else {Get.to(Products());};
    });
  }


  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF69A03A),
    ));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            const Center(
              child: Text(
                "Fruit Market",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 45,
                    color: Colors.white),
              ),
            ),
            Positioned(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Image.asset(
                  "./lib/images/fruit.png",
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.bottomLeft,
                  width: 500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromRGBO(105, 160, 58, 1),
      ),
    );
  }
}
