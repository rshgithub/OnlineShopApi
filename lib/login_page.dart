import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../products.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController _userEmailController = new TextEditingController();
  TextEditingController _userPasswordController = new TextEditingController();
  String? userEmail, userPassword;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 140),
                child: const Text(
                  "Fruit Market",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 48,
                    color: Color.fromRGBO(105, 160, 58, 1),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                width: 340,
                margin: const EdgeInsets.fromLTRB(0, 120, 0, 0),
                child: TextField(
                  controller: _userEmailController,
                  onChanged: (inputData) {
                    userEmail = inputData;
                  },
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    hintText: 'Enter Your Email',
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                width: 340,
                margin: const EdgeInsets.fromLTRB(0, 250, 0, 0),
                child: TextField(
                  controller: _userPasswordController,
                  onChanged: (inputData) {
                    userPassword = inputData;
                  },
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    hintText: 'Enter Your Password',
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 500, 20, 0),
                width: 370,
                height: 55,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () async {
                        saveUserLoginData(context);
                      },
                      child: const Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromRGBO(105, 160, 58, 1),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 400),
                child: Image.asset(
                  "./lib/images/store.png",
                  alignment: Alignment.bottomLeft,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  saveUserLoginData(context) async {
    if (_userEmailController.text.isEmpty || _userPasswordController.text.isEmpty) { print("emp"); return; }
    loginUser(_userEmailController.text, _userPasswordController.text, context);
    SharedPreferences shared = await SharedPreferences.getInstance();
    var userToken = shared.get("token");
    shared.commit();
  }


  loginUser(String userEmail, String userPassword, context) async {
    Map data = {'username': userEmail, 'password': userPassword};
    print("user data :" + data.toString());
    String _loginUrl = "https://fakestoreapi.com/auth/login";

    final response = await http.post(Uri.parse(_loginUrl), body: data,);
    SharedPreferences shared = await SharedPreferences.getInstance();

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      shared.setString("token", data['token']);
      print(data['token']);
      print('success');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Products()));
    } else {
      print(response.body);
    }
  }
}