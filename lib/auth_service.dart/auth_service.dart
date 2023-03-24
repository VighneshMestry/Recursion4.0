import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recursion_hackathon/models/product_details_model.dart';

class AuthService {
  // Future<ProductDetails> searchProducts({
  //   required String id,
  // }) async {
  //   try{
  //     final res = await http.post(Uri.parse("https://recursion4-0-backend-server.onrender.com/api/track/getalltrackers"),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json',
  //     });
  //     if(res.statusCode == 201){
  //       String str = res.body;
  //       return productDetailsFromJson(res.body);
  //     } else {
  //       throw Exception();
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  var response;

  Future<dynamic> getAllTrackers() async {
    var url = Uri.parse(
      'https://recursion4-0-backend-server.onrender.com/api/track/getalltrackers',
    );
    response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      // parsing to JSON
      log(response.body);
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load trackers');
    }
  }

  Future<dynamic> updatedStatus(dynamic updatedStatus, ProductDetails productDetails) async {
    log('api request');
    var url = Uri.parse(
        'https://recursion4-0-backend-server.onrender.com/api/track/update');

    var responseStatus = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {
          'product': productDetails.productId,
          'status': updatedStatus,
        },
      ),
    );
    if(responseStatus.statusCode == 200){
      log('Updated from api request function');
      return (responseStatus.body);

    } else {
      throw Exception();
    }
  }
}
