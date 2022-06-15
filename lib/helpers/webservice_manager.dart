import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/Profile.dart';
import '../models/product.dart';

class Service {

  static String _mainUrl = "https://fakestoreapi.com/products/";
  static String _domain = "fakestoreapi.com";
  static String _userId = "users/1";


  Future<profile> getUserInfo() async {
    var response = await http.get(Uri.https(_domain, _userId));
    if (response.statusCode == 200) {
      return profile.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error fetching User Info");
    }
  }


  Future<List<Product>> getJeweleries() async {
    var responce =  await http.get(Uri.parse(_mainUrl+"category/jewelery"));
    if(responce.statusCode == 200){
      final json = jsonDecode(responce.body);
      final List productList = json;
      return productList.map((item){
        return Product.fromJson(item);
      }).toList();
    }else{
      throw Exception("Error fetching Jeweleries");
    }
  }


  Future<List<Product>> getElectronics() async{
    var responce =  await http.get(Uri.parse(_mainUrl+"category/electronics"));
    print("---------------------------------------------------------electronics------------------------------------"+responce.statusCode.toString());
    if(responce.statusCode == 200){
      final json = jsonDecode(responce.body);
      final List productList = json;
      print("---------------------------------------------------------"+productList.toString());

      return productList.map((item){
        return Product.fromJson(item);
      }).toList();
    }else{
      throw Exception("Error fetching Electronics");
    }
  }

  Future<List<Product>> getMenProducts() async{
    var responce =  await http.get(Uri.parse(_mainUrl+"category/men's%20clothing"));
    if(responce.statusCode == 200){
      final json = jsonDecode(responce.body);
      final List productList = json;
      return productList.map((item){
        return Product.fromJson(item);
      }).toList();
    }else{
      throw Exception("Error fetching Men Products");
    }
  }


  Future<List<Product>> getWomenProducts() async{
    var responce =  await http.get(Uri.parse(_mainUrl+"category/women's%20clothing"));
    if(responce.statusCode == 200){
      final json = jsonDecode(responce.body);
      final List productList = json;
      return productList.map((item){
        return Product.fromJson(item);
      }).toList();
    }else{
      throw Exception("Error Women Products");
    }
  }


  Future<Product> getProductDetails(int id) async{
    var response = await http.get(Uri.parse(_mainUrl+"$id"));
    if(response.statusCode==200){
      return Product.fromJson(jsonDecode(response.body));

    }else{
      throw Exception("Error fetching this Product");
    }
  }

}