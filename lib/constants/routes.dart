import 'package:flutter/material.dart';
import 'package:recursion_hackathon/screens/product_details.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case ProductDetails.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ProductDetails(),
      );

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}
