import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProductDetails extends StatelessWidget {
  final String imgPath;
  final String trackingId;
  final String productName;
  final String address;
  final String status;
  const ProductDetails(
      {super.key,
      required this.imgPath,
      required this.trackingId,
      required this.productName,
      required this.address,
      required this.status});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            
          ],
        ),
      ),
    );
  }
}
