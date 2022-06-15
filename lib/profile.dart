import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'helpers/webservice_manager.dart';
import 'login_page.dart';
import 'models/Profile.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<String> items = [
    "My Orders",
    "Favourites",
    "Settings",
    "My Cart",
    "Rate us",
    "Refer a Friend",
    "Help",
    "Log Out"
  ];
  List<IconData> icons = [
    Icons.shopping_bag,
    Icons.favorite,
    Icons.settings,
    Icons.add_shopping_cart,
    Icons.star_rate,
    Icons.share,
    Icons.help,
    Icons.logout,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<profile>(
              future: Service().getUserInfo(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 250,
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 90),
                              height: 250,
                              color: const Color.fromRGBO(105, 160, 58, 1),
                              child: Row(
                                children: [
                                  Expanded(child: Container()),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ))
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                margin: const EdgeInsets.only(
                                    left: 25, right: 25, bottom: 80),
                                child: Image.asset('assets/images/user.png'),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                margin: const EdgeInsets.only(
                                    left: 25, right: 25, bottom: 50),
                                child: Text(
                                  snapshot.data!.username,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                margin: const EdgeInsets.only(
                                    left: 25, right: 25, bottom: 25),
                                child: Text(
                                  snapshot.data!.email,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
          Container(
            margin: const EdgeInsets.only(top: 250),
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.only(bottom: 15),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color.fromRGBO(209, 209, 209, 1),
                      ),
                    ),
                  ),
                  margin: const EdgeInsets.only(top: 5, bottom: 20),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 25),
                        child: Icon(
                          icons[index],
                          size: 35,
                          color: const Color.fromRGBO(105, 160, 58, 1),
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.only(left: 25),
                          child: Text(
                            items[index],
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        onTap: () async {
                          if (items[index] == "Log Out") {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            // prefs.remove('email');
                            // prefs.remove('password');
                            prefs.remove('token');
                            Navigator.pushReplacement(context, MaterialPageRoute( builder: (BuildContext ctx) => LoginPage()));
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
