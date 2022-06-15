import 'package:api_task/profile.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../ProductSingle.dart';
import 'helpers/webservice_manager.dart';
import 'models/product.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var market = List.empty(growable: true);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leadingWidth: double.infinity,
          elevation: 0,
          backgroundColor: Color(0xFF69A03A),
          leading: Container(
            margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
            alignment: Alignment.center,
            child: const Text(
              'FruitMarket',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
              alignment: Alignment.center,
              child: IconButton(
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile()));
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 30,
                        color: Color(0xFF69A03A),
                      ),
                      searchBar(),
                    ],
                  ),
                ),

                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                      child: Row(
                        children: [
                          FutureBuilder<List<Product>>(
                              future: Service().getElectronics(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    snapshot.data![0].category!,
                                    style: const TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  );
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              }),
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: const Text(
                              '(10% Off)',
                              style: TextStyle(
                                  color: Color(0xFF69A03A),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Container(
                    //   margin: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                    //   alignment: Alignment.topLeft,
                    //   child: FutureBuilder<List<Product>>(
                    //       future: Service().getElectronics(),
                    //       builder: (context, snapshot) {
                    //         if (snapshot.hasData) {
                    //           return Text(
                    //             snapshot.data![0].description!,
                    //             style: const TextStyle(
                    //                 color: Color(0xFF000000),
                    //                 fontSize: 16,
                    //                 fontWeight: FontWeight.bold),
                    //           );
                    //         } else {
                    //           return const CircularProgressIndicator();
                    //         }
                    //       }),
                    // ),
                  ],
                ),

                Container(
                    width: double.infinity,
                    height: 240,
                    child: FutureBuilder<List<Product>>(
                        future: Service().getElectronics(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 16, 0, 0),
                                                child: Image.network(
                                                  snapshot.data![index].image!,
                                                  width: 118,
                                                  height: 143,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        103, 22, 0, 0),
                                                child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  child: FavoriteButton(
                                                    iconSize: 25,
                                                    isFavorite: false,
                                                    valueChanged:
                                                        (_isFavorite) {
                                                      print(
                                                          'Is Favorite : $_isFavorite');
                                                    },
                                                  ),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                50)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          20, 8, 0, 0),
                                                  child: RatingBarIndicator(
                                                    rating: snapshot
                                                        .data![index]
                                                        .rating!
                                                        .rate!,
                                                    itemBuilder: (context,
                                                            index) =>
                                                        const Icon(Icons.star,
                                                            color:
                                                                Colors.amber),
                                                    itemCount: 5,
                                                    itemSize: 18.0,
                                                    direction: Axis.horizontal,
                                                  ),
                                                ),
                                                Container(
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          20, 8, 0, 0),
                                                  child: Text(
                                                    snapshot
                                                        .data![index].title!,
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xFF393939),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Container(
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          20, 8, 0, 0),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: 6,
                                                        height: 10,
                                                        child: Image.asset(
                                                            'assets/images/money.jpeg'),
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                6, 0, 0, 0),
                                                        child: Text(
                                                          snapshot.data![index]
                                                              .price!
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProductSingle(
                                                snapshot.data![index].id))));
                              },
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        })),

                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                      child: Row(
                        children: [
                          FutureBuilder<List<Product>>(
                              future: Service().getJeweleries(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    snapshot.data![0].category!,
                                    style: const TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  );
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              }),
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: const Text(
                              '(10% Off)',
                              style: TextStyle(
                                  color: Color(0xFF69A03A),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Container(
                    //   margin: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                    //   alignment: Alignment.topLeft,
                    //   child: FutureBuilder<List<Product>>(
                    //       future: Service().getJeweleries(),
                    //       builder: (context, snapshot) {
                    //         if (snapshot.hasData) {
                    //           return Text(
                    //             snapshot.data![1].description!,
                    //             style: const TextStyle(
                    //                 color: Color(0xFF000000),
                    //                 fontSize: 16,
                    //                 fontWeight: FontWeight.bold),
                    //           );
                    //         } else {
                    //           return const CircularProgressIndicator();
                    //         }
                    //       }),
                    // ),
                  ],
                ),

                Container(
                    width: double.infinity,
                    height: 240,
                    child: FutureBuilder<List<Product>>(
                        future: Service().getJeweleries(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 16, 0, 0),
                                                child: Image.network(
                                                  snapshot.data![index].image!,
                                                  width: 118,
                                                  height: 143,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        103, 22, 0, 0),
                                                child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  child: FavoriteButton(
                                                    iconSize: 25,
                                                    isFavorite: false,
                                                    valueChanged:
                                                        (_isFavorite) {
                                                      print(
                                                          'Is Favorite : $_isFavorite');
                                                    },
                                                  ),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                50)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          20, 8, 0, 0),
                                                  child: RatingBarIndicator(
                                                    rating: snapshot
                                                        .data![index]
                                                        .rating!
                                                        .rate!,
                                                    itemBuilder: (context,
                                                            index) =>
                                                        const Icon(Icons.star,
                                                            color:
                                                                Colors.amber),
                                                    itemCount: 5,
                                                    itemSize: 18.0,
                                                    direction: Axis.horizontal,
                                                  ),
                                                ),
                                                Container(
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          20, 8, 0, 0),
                                                  child: Text(
                                                    snapshot
                                                        .data![index].title!,
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xFF393939),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Container(
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          20, 8, 0, 0),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: 6,
                                                        height: 10,
                                                        child: Image.asset(
                                                            'assets/images/money.jpeg'),
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                6, 0, 0, 0),
                                                        child: Text(
                                                          snapshot.data![index]
                                                              .price!
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProductSingle(
                                                snapshot.data![index].id))));
                              },
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        })),

                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                      child: Row(
                        children: [
                          FutureBuilder<List<Product>>(
                              future: Service().getMenProducts(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    snapshot.data![2].category!,
                                    style: const TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  );
                                } else {
                                  return CircularProgressIndicator();
                                }
                              }),
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: const Text(
                              '(10% Off)',
                              style: TextStyle(
                                  color: Color(0xFF69A03A),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Container(
                    //   margin: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                    //   alignment: Alignment.topLeft,
                    //   child: FutureBuilder<List<Product>>(
                    //       future: Service().getMenProducts(),
                    //       builder: (context, snapshot) {
                    //         if (snapshot.hasData) {
                    //           return Text(
                    //             snapshot.data![2].description!,
                    //             style: const TextStyle(
                    //                 color: Color(0xFF000000),
                    //                 fontSize: 16,
                    //                 fontWeight: FontWeight.bold),
                    //           );
                    //         } else {
                    //           return CircularProgressIndicator();
                    //         }
                    //       }),
                    // ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 240,
                  child: FutureBuilder<List<Product>>(
                      future: Service().getMenProducts(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 16, 0, 0),
                                              child: Image.network(
                                                snapshot.data![index].image!,
                                                width: 118,
                                                height: 143,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      103, 22, 0, 0),
                                              child: Container(
                                                width: 30,
                                                height: 30,
                                                child: FavoriteButton(
                                                  iconSize: 25,
                                                  isFavorite: false,
                                                  valueChanged: (_isFavorite) {
                                                    print(
                                                        'Is Favorite : $_isFavorite');
                                                  },
                                                ),
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(50)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 8, 0, 0),
                                                child: RatingBarIndicator(
                                                  rating: snapshot.data![index]
                                                      .rating!.rate!,
                                                  itemBuilder: (context,
                                                          index) =>
                                                      const Icon(Icons.star,
                                                          color: Colors.amber),
                                                  itemCount: 5,
                                                  itemSize: 18.0,
                                                  direction: Axis.horizontal,
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 8, 0, 0),
                                                child: Text(
                                                  snapshot.data![index].title!,
                                                  style: const TextStyle(
                                                      color: Color(0xFF393939),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 8, 0, 0),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: 6,
                                                      height: 10,
                                                      child: Image.asset(
                                                          'assets/images/money.jpeg'),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(6, 0, 0, 0),
                                                      child: Text(
                                                        snapshot
                                                            .data![index].price!
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductSingle(
                                              snapshot.data![index].id))));
                            },
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      }),
                ),


                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                      child: Row(
                        children: [
                          FutureBuilder<List<Product>>(
                              future: Service().getWomenProducts(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    snapshot.data![3].category!,
                                    style: const TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  );
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              }),
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: const Text(
                              '(10% Off)',
                              style: TextStyle(
                                  color: Color(0xFF69A03A),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Container(
                    //   margin: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                    //   alignment: Alignment.topLeft,
                    //   child: FutureBuilder<List<Product>>(
                    //       future: Service().getWomenProducts(),
                    //       builder: (context, snapshot) {
                    //         if (snapshot.hasData) {
                    //           return Text(
                    //             snapshot.data![3].description!,
                    //             style: const TextStyle(
                    //                 color: Color(0xFF000000),
                    //                 fontSize: 16,
                    //                 fontWeight: FontWeight.bold),
                    //           );
                    //         } else {
                    //           return const CircularProgressIndicator();
                    //         }
                    //       }),
                    // ),
                  ],
                ),

                Container(
                    width: double.infinity,
                    height: 240,
                    child: FutureBuilder<List<Product>>(
                        future: Service().getWomenProducts(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 16, 0, 0),
                                                child: Image.network(
                                                  snapshot.data![index].image!,
                                                  width: 118,
                                                  height: 143,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        103, 22, 0, 0),
                                                child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  child: FavoriteButton(
                                                    iconSize: 25,
                                                    isFavorite: false,
                                                    valueChanged:
                                                        (_isFavorite) {
                                                      print(
                                                          'Is Favorite : $_isFavorite');
                                                    },
                                                  ),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                50)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          20, 8, 0, 0),
                                                  child: RatingBarIndicator(
                                                    rating: snapshot
                                                        .data![index]
                                                        .rating!
                                                        .rate!,
                                                    itemBuilder: (context,
                                                            index) =>
                                                        const Icon(Icons.star,
                                                            color:
                                                                Colors.amber),
                                                    itemCount: 5,
                                                    itemSize: 18.0,
                                                    direction: Axis.horizontal,
                                                  ),
                                                ),
                                                Container(
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          20, 8, 0, 0),
                                                  child: Text(
                                                    snapshot
                                                        .data![index].title!,
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xFF393939),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Container(
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          20, 8, 0, 0),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: 6,
                                                        height: 10,
                                                        child: Image.asset(
                                                            'assets/images/money.jpeg'),
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                6, 0, 0, 0),
                                                        child: Text(
                                                          snapshot.data![index]
                                                              .price!
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProductSingle(
                                                snapshot.data![index].id))));
                              },
                            );
                          } else {
                            return Center(
                                child: const CircularProgressIndicator());
                          }
                        })),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget searchBar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 15,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.all(const Radius.circular(6)),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: "Search",
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xFFC3C3C3),
          ),
        ),
      ),
    );
  }
}
