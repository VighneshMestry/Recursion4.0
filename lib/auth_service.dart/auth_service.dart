import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:recursion_hackathon/product.dart';

class AuthService{

  Future searchProducts({
    required BuildContext context,
    required String id,
  }) async {
    http.Response res = await http.post(Uri.parse("https://recursion4-0-backend-server.onrender.com/api/track/getalltrackers"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
      print(res.body);
      return json.decode(res.body);
      // Iterable l = json.decode(res.body);
      // List<Product> posts = List<Product>.from(l.map((model)=> Product.fromJson(model)));
      
      
      // List<dynamic> dataList = json.decode(res.body);

// convert the List<dynamic> to List<Map<String, dynamic>>
      // Future<List> futureList = dataList as Future<List>;
      // return futureList;
  }

}