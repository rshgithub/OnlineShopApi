import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'helpers/webservice_manager.dart';
import 'models/product.dart';

class ProductSingle extends StatelessWidget{

  var id ;
  ProductSingle(this.id);

  @override
  Widget build(BuildContext context) {
    print(id);
    return Scaffold(

        appBar: AppBar(
          backgroundColor: Color(0xFF769E49),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text("Details"),
          centerTitle: false,
        ),

        body: ListView(
          children:[
            Container(
            margin: const EdgeInsets.only(left: 20),
            child: FutureBuilder<Product>(
              future: Service().getProductDetails(id),
              builder: (context,snapshot)  {
                if(snapshot.hasData){
                  print("id");
                  return  Column(
                    children: [
                  Container(
                    margin: const EdgeInsets.only(top: 30, right: 40),
                    child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20, 16, 0, 0),
                            child: Image.network(
                              snapshot.data!.image!,
                              fit: BoxFit.fitWidth,
                              alignment: Alignment.bottomLeft,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25, left: 290),
                            child: Container(
                              width: 30,
                              height: 30,
                              child: FavoriteButton(
                                iconSize: 40,
                                isFavorite: false,
                                valueChanged: (_isFavorite) {
                                  print(
                                      'Is Favorite : $_isFavorite');
                                },
                              ),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(50)),
                              ),
                            ),
                          ),
                        ],
                      ),
                ]
                  ),
                ),

                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            children: [
                              Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 15, top: 15),
                                    child:  Text(
                                      snapshot.data!.title!,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  )),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  child:
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.circle,
                                        size: 8,
                                        color: Color.fromRGBO(131, 129, 129, 1),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Text(
                                          'Description',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                // margin: const EdgeInsets.only(top: 20),
                                margin: const EdgeInsets.only(left: 5, top: 10, right: 5),
                                width: 350,
                                child:  Text(
                                  snapshot.data!.description!,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 20,bottom: 20),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.currency_rupee,
                                      size: 20,
                                    ),
                                    Text(
                                      snapshot.data!.price.toString(),
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Expanded(child: Container()),
                                    Container(
                                      margin: const EdgeInsets.only(right: 20),
                                      child: ElevatedButton(
                                        onPressed: () {
                                        },
                                        child: const Center(
                                          child: Text('Buy Now'),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          primary:
                                          const Color.fromRGBO(105, 160, 58, 1),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 50, vertical: 15),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ))
                    ],
                  );
                }
                else{

                  return const Center(child: CircularProgressIndicator());

                }
              },

            ),
          ),
    ]
        )
    );
  }

}