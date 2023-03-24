// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:url_launcher/url_launcher.dart';

// import '../screens/product_details.dart';

// class CustomeListTile extends StatelessWidget {
//   var response;
//   int i;

//   CustomeListTile({super.key, required this.response, required this.i});
//   Future<void> _launchUrl(int index) async {
//     if (!await launchUrl(response[index]["location"])) {
//       throw Exception('Could not launch ${response[index]["location"]}');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
//       child: Container(
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 blurRadius: 2,
//                 offset: const Offset(0, 0),
//                 color: Colors.grey.withOpacity(0.2),
//               )
//             ]),
//         child: Container(
//           padding: const EdgeInsets.all(8),
//           child: Row(
//             children: [
//               Container(
//                 width: 100,
//                 height: 100,
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                   // borderRadius: BorderRadius.circular(10),
//                   image: DecorationImage(
//                     image: NetworkImage(
//                         "https://static.vecteezy.com/system/resources/previews/016/973/351/original/shopping-cart-icon-in-flat-style-trolley-illustration-on-black-round-background-with-long-shadow-effect-basket-circle-button-business-concept-vector.jpg"),
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       RichText(
//                           text: TextSpan(children: [
//                         const TextSpan(
//                             text: "Id : ",
//                             style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               color: Colors.black,
//                             )),
//                         TextSpan(
//                             text: response[i]["_id"],
//                             style: const TextStyle(
//                               color: Colors.black87,
//                             ))
//                       ])),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: const [
//                       Icon(
//                         Icons.done_rounded,
//                         color: Colors.green,
//                         size: 26,
//                       ),
//                       SizedBox(
//                         width: 5,
//                       ),
//                       Text(
//                         "Ordered",
//                         style: TextStyle(
//                             fontSize: 16,
//                             fontFamily: "Avenir",
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.blue,
//                         ),
//                         onPressed: () {
//                           _launchUrl(i);
//                         },
//                         child: const Text("Get Location"),
//                       ),
//                       const SizedBox(
//                         width: 5,
//                       ),
//                       SizedBox(
//                         width: 100,
//                         child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.blue,
//                             ),
//                             onPressed: () {
//                               // ProductDetails
//                               //     productDetails =
//                               //     ProductDetails(
//                               //   id: response[i]["_id"],
//                               //   productId: response[i]
//                               //       ["productId"],
//                               //   arrival: response[i]
//                               //       ['arrival'],
//                               //   ordered: response[i]
//                               //       ['Ordered'],
//                               //   status: response[i]
//                               //       ['status'],
//                               //   location: response[i]
//                               //       ['location'],
//                               //   buyeremail: response[i]
//                               //       ['buyeremail'],
//                               //   v: response[i]['_v'],
//                               // );

//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => ProductDetailsPage(
//                                     id: response[i]["_id"],
//                                     productId: response[i]["productId"],
//                                     arrival: response[i]['arrival'],
//                                     ordered: response[i]['Ordered'],
//                                     status: response[i]['status'],
//                                     location: response[i]['location'],
//                                     buyeremail: response[i]['buyeremail'],
//                                     v: response[i]['_v'],
//                                   ),
//                                 ),
//                               );
//                             },
//                             child: Row(
//                               children: const [
//                                 Text('Details'),
//                                 Icon(Icons.arrow_drop_down),
//                               ],
//                             )),
//                       )
//                     ],
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//     ;
//   }
// }
