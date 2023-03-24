import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:recursion_hackathon/auth_service.dart/auth_service.dart';
import 'package:recursion_hackathon/common/custom_textfield.dart';
import 'package:recursion_hackathon/product.dart';
import 'package:recursion_hackathon/screens/demo.dart';
import 'package:recursion_hackathon/screens/product_details.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_colors.dart' as AppColors;

import 'package:flutter_svg/flutter_svg.dart';
import '../constants/tab.dart';
import '../models/product_details_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AuthService authService = AuthService();
  late List popularBooks;
  late List books;
  // List productDetails = [];

  var selectedTabView = 1;

  final TextEditingController _searchBarController = TextEditingController();
  late ScrollController _scrollController;
  late TabController _tabController;

// final Uri _url = Uri.parse('https://flutter.dev');
  // final Uri _url = Uri.parse(
  //     'https://www.google.com/maps?q=Gharkul+Society,+Bharat+Nagar,+Versova,+Andheri+West,+Mumbai,+Maharashtra+400061&ftid=0x3be7c9e13ef9c8f1:0xb1c2f0f83e476d54&hl=en-IN&gl=in&entry=gps&lucs=47062714&g_ep=CAISBjYuNTcuMRgAINeCAyoINDcwNjI3MTRCAklO&g_st=ic');
  // final Uri _url = Uri.parse(
  //     'https://www.google.com/maps/place/Our+Lady+of+Grace+Cathedral+(Papdy)/@19.3509312,72.809657,17z/data=!3m1!4b1!4m6!3m5!1s0x3be7ae7c47a97af9:0x7efb4fb078612422!8m2!3d19.3509312!4d72.8118457!16s%2Fg%2F1hdzl32qv');

  // ReadData() async {
  //   await DefaultAssetBundle.of(context)
  //       .loadString("json/popularBooks.json")
  //       .then(
  //     (s) {
  //       setState(
  //         () {
  //           popularBooks = json.decode(s);
  //         },
  //       );
  //     },
  //   );
  //   await DefaultAssetBundle.of(context).loadString("json/books.json").then(
  //     (s) {
  //       setState(
  //         () {
  //           books = json.decode(s);
  //         },
  //       );
  //     },
  //   );
  //   await DefaultAssetBundle.of(context)
  //       .loadString("json/productDetails.json")
  //       .then(
  //     (s) {
  //       setState(
  //         () {
  //           productDetails = json.decode(s);
  //         },
  //       );
  //     },
  //   );
  // }

  var response,_fetchProduct;

  Future<List<ProductDetails>> getProductDetailsMethod() async {
    List<ProductDetails> products=[];
    try {
      
      var response = await authService.getAllTrackers() as List;
      products= response.map((e) => ProductDetails.fromJson(e)).toList();
    } catch (error) {
      print(error);
    }

    return products;
  }

  Future<void> _launchUrl(int index) async {
    if (!await launchUrl(response[index]["location"])) {
      throw Exception('Could not launch ${response[index]["location"]}');
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabController = TabController(length: 3, vsync: this);
    _fetchProduct= getProductDetailsMethod();
    // ReadData();
  }

  @override
  Widget build(BuildContext context) {
    getProductDetailsMethod();
    log('_________________printing fetch Product__________');
    print(_fetchProduct);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.black,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: SvgPicture.network(
                  "https://www.logo.wine/a/logo/E-mart/E-mart-Logo.wine.svg",
                  height: 45,
                ),
              )
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
                padding: const EdgeInsets.only(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  top: 10,
                ),
                height: 100,
                color: Colors.grey[100],
                child: Row(
                  children: [
                    Row(
                      children: [
                        CustomTextField(
                            controller: _searchBarController,
                            hintText: "Search"),
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Icon(Icons.search),
                  ],
                )),
            //Expanded start
            Expanded(
              child: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder: (BuildContext context, bool isScroll) {
                  return [
                    SliverAppBar(
                      pinned: true,
                      backgroundColor: AppColors.sliverBackground,

                      //Creates a widget that has a preferred size that the parent can query. A space is can be left blank with respect to the parent widget.
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(50),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20, left: 10),
                          child: TabBar(
                            indicatorPadding: const EdgeInsets.all(0),
                            indicatorSize: TabBarIndicatorSize.label,
                            labelPadding: const EdgeInsets.only(right: 10),
                            controller: _tabController,
                            isScrollable: true,
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 7,
                                    offset: const Offset(0, 0),
                                  )
                                ]),
                            tabs: const [
                              AppTab(color: Colors.black87, text: "Ordered"),
                              AppTab(color: Colors.black87, text: "Dispatched"),
                              AppTab(
                                  color: Colors.black87,
                                  text: "Out For Delivery"),
                            ],
                          ),
                        ),
                      ),
                    )
                  ];
                },
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    FutureBuilder(
                      future: _fetchProduct,
                      builder: (context,AsyncSnapshot<List<ProductDetails>> snapshot) {

                        if(snapshot.connectionState==ConnectionState.waiting || snapshot.hasError){
                          return const Center(child: CircularProgressIndicator());
                        }

                        return ListView.builder(
                          // itemCount: response.length,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (_, i) {
                            ProductDetails p = snapshot.data![i];
                            log('*********************');
                            print(p.status);
                            return Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 2,
                                        offset: const Offset(0, 0),
                                        color: Colors.grey.withOpacity(0.2),
                                      )
                                    ]),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          // borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                "https://static.vecteezy.com/system/resources/previews/016/973/351/original/shopping-cart-icon-in-flat-style-trolley-illustration-on-black-round-background-with-long-shadow-effect-basket-circle-button-business-concept-vector.jpg"),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              RichText(
                                                  text: TextSpan(children: [
                                                const TextSpan(
                                                    text: "Id : ",
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.black,
                                                    )),
                                                TextSpan(
                                                    text: p.id,
                                                    style: const TextStyle(
                                                      color: Colors.black87,
                                                    ))
                                              ])),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: const [
                                              Icon(
                                                Icons.done_rounded,
                                                color: Colors.green,
                                                size: 26,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "Ordered",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: "Avenir",
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.blue,
                                                ),
                                                onPressed: () {
                                                  // _launchUrl(i);
                                                },
                                                child: const Text("Get Location"),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              SizedBox(
                                                width: 100,
                                                child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: Colors.blue,
                                                    ),
                                                    onPressed: () {
                                                      ProductDetails
                                                          productDetails =
                                                          ProductDetails(
                                                        id: p.id,
                                                        productId: p.productId,
                                                        // arrival: response[i]
                                                        //     ['arrival'],
                                                        // ordered: response[i]
                                                        //     ['Ordered'],
                                                        status: p.status,
                                                        location: p.location,
                                                        buyeremail: p.buyeremail,
                                                        // v: response[i]['_v'],
                                                      );
                                                      log('printing productDetails.......');
                                                      print(productDetails);
                                                      log('Done');
                                                      // var tpList = getProductDetailsMethod();
                                                      // setState(() {
                                                      //   p.status = tpList;
                                                      // });
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context) => ProductDetailsPage(productDetails: productDetails,)),
                                                      );
                                                      // Navigator.push(context, MaterialPageRoute(builder: (context) => const DemoPage()));
                                                    },
                                                    child: Row(
                                                      children: const [
                                                        Text('Details'),
                                                        Icon(Icons.arrow_drop_down),
                                                      ],
                                                    )),
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    ),
                    ListView.builder(
                      // itemCount: response.length,
                      itemCount: 4,
                      itemBuilder: (_, i) {
                        return Container(
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 2,
                                    offset: const Offset(0, 0),
                                    color: Colors.grey.withOpacity(0.2),
                                  )
                                ]),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      // borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "https://static.vecteezy.com/system/resources/previews/016/973/351/original/shopping-cart-icon-in-flat-style-trolley-illustration-on-black-round-background-with-long-shadow-effect-basket-circle-button-business-concept-vector.jpg"),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          RichText(
                                              text: TextSpan(children: [
                                            const TextSpan(
                                                text: "Id : ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                )),
                                            TextSpan(
                                                text: response[i]["_id"],
                                                style: const TextStyle(
                                                  color: Colors.black87,
                                                ))
                                          ])),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: const [
                                          Icon(
                                            Icons.send_outlined,
                                            color: Colors.blue,
                                            size: 26,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Dispatched',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: "Avenir",
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue,
                                            ),
                                            onPressed: () {
                                              // _launchUrl(i);
                                            },
                                            child: const Text("Get Location"),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          SizedBox(
                                            width: 100,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.blue,
                                                ),
                                                onPressed: () {
                                                  // Navigator.of(context).push(
                                                  //   MaterialPageRoute(
                                                  //       builder: (context) => ProductDetails(
                                                  //           imgPath:
                                                  //               productDetails[i]
                                                  //                   ["imgPath"],
                                                  //           trackingId:
                                                  //               productDetails[i]
                                                  //                   [
                                                  //                   "trackingId"],
                                                  //           productName:
                                                  //               productDetails[i]
                                                  //                   [
                                                  //                   "productName"],
                                                  //           address:
                                                  //               productDetails[i]
                                                  //                   ["address"],
                                                  //           status:
                                                  //               productDetails[
                                                  //                       i][
                                                  //                   "status"])),
                                                  // );
                                                },
                                                child: Row(
                                                  children: const [
                                                    Text('Details'),
                                                    Icon(Icons.arrow_drop_down),
                                                  ],
                                                )),
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    ListView.builder(
                      // itemCount: response.length,
                      itemCount: 4,
                      itemBuilder: (_, i) {
                        return Container(
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 2,
                                    offset: const Offset(0, 0),
                                    color: Colors.grey.withOpacity(0.2),
                                  )
                                ]),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      // borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "https://static.vecteezy.com/system/resources/previews/016/973/351/original/shopping-cart-icon-in-flat-style-trolley-illustration-on-black-round-background-with-long-shadow-effect-basket-circle-button-business-concept-vector.jpg"),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          RichText(
                                              text: TextSpan(children: [
                                            const TextSpan(
                                                text: "Id : ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                )),
                                            TextSpan(
                                                text: response[i]["id"],
                                                style: const TextStyle(
                                                  color: Colors.black87,
                                                ))
                                          ])),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.local_shipping,
                                            color: Colors.amber[300],
                                            size: 26,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const Text(
                                            'Out For Delivery',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: "Avenir",
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue,
                                            ),
                                            onPressed: () {
                                              // _launchUrl(i);
                                            },
                                            child: const Text("Get Location"),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          SizedBox(
                                            width: 100,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.blue,
                                                ),
                                                onPressed: () {
                                                  // Navigator.of(context).push(
                                                  //   MaterialPageRoute(
                                                  //       builder: (context) => ProductDetails(
                                                  //           imgPath:
                                                  //               productDetails[i]
                                                  //                   ["imgPath"],
                                                  //           trackingId:
                                                  //               productDetails[i]
                                                  //                   [
                                                  //                   "trackingId"],
                                                  //           productName:
                                                  //               productDetails[i]
                                                  //                   [
                                                  //                   "productName"],
                                                  //           address:
                                                  //               productDetails[i]
                                                  //                   ["address"],
                                                  //           status:
                                                  //               productDetails[
                                                  //                       i][
                                                  //                   "status"])),
                                                  // );
                                                },
                                                child: Row(
                                                  children: const [
                                                    Text('Details'),
                                                    Icon(Icons.arrow_drop_down),
                                                  ],
                                                )),
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),

                //add here
              ),
            ),

            //Expanded over
          ],
        ),
      ),
    );
  }
}
