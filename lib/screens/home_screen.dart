import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:recursion_hackathon/auth_service.dart/auth_service.dart';
import 'package:recursion_hackathon/common/custom_textfield.dart';
import 'package:recursion_hackathon/screens/product_details.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../constants/app_colors.dart' as AppColors;

import 'package:flutter_svg/flutter_svg.dart';
import '../constants/tab.dart';
import '../enum/menu_action.dart';
import '../product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // AuthService authService = AuthService();
  late List popularBooks;
  late List books;
  late List productDetails;

  var selectedTabView = 1;

  final TextEditingController _searchBarController = TextEditingController();
  late ScrollController _scrollController;
  late TabController _tabController;

// final Uri _url = Uri.parse('https://flutter.dev');
  // final Uri _url = Uri.parse(
  //     'https://www.google.com/maps?q=Gharkul+Society,+Bharat+Nagar,+Versova,+Andheri+West,+Mumbai,+Maharashtra+400061&ftid=0x3be7c9e13ef9c8f1:0xb1c2f0f83e476d54&hl=en-IN&gl=in&entry=gps&lucs=47062714&g_ep=CAISBjYuNTcuMRgAINeCAyoINDcwNjI3MTRCAklO&g_st=ic');
  final Uri _url = Uri.parse(
      'https://www.google.com/maps/place/Our+Lady+of+Grace+Cathedral+(Papdy)/@19.3509312,72.809657,17z/data=!3m1!4b1!4m6!3m5!1s0x3be7ae7c47a97af9:0x7efb4fb078612422!8m2!3d19.3509312!4d72.8118457!16s%2Fg%2F1hdzl32qv');
  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  // late final temp;
  // Future<dynamic> demo () {
  //   temp = authService.searchProducts(context: context, id: '');
  //   return temp;
  // }

  ReadData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/popularBooks.json")
        .then(
      (s) {
        setState(
          () {
            popularBooks = json.decode(s);
          },
        );
      },
    );
    await DefaultAssetBundle.of(context).loadString("json/books.json").then(
      (s) {
        setState(
          () {
            books = json.decode(s);
          },
        );
      },
    );
    await DefaultAssetBundle.of(context)
        .loadString("json/productDetails.json")
        .then(
      (s) {
        setState(
          () {
            productDetails = json.decode(s);
          },
        );
      },
    );
  }

  // late List<String> productList;
  // late final allList;

  // Future<List<String>> fetchData() async {
  //   // your async code here
  //   List<String> myList =
  //       await authService.searchProducts(context: context, id: '');
  //   return myList;
  // }

  // void main() async {
  //   productList = await fetchData(); // prints [apple, banana, orange]
  // }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabController = TabController(length: 3, vsync: this);
    // authService.searchProducts(context: context, id: '');
    // demo();
    ReadData();
  }
  //

// void main(Future<List> list) async {
//   List _futureOfList = await list;
//   productList =  _futureOfList ;
//    // will print [1, 2, 3, 4] on console.
// }

// void searchProducts() async {
//   final list = await authService.searchProducts(context: context, id: '') as List;
//   productList = list.map((e) => Product.fromMap(e)).toList();
//   print(productList);
// }

// List<dynamic> productList= [];
// void main(Future<List> list) async {
//   List<Future<dynamic>> _selectedItems = <Future<dynamic>>[];

//                                     _selectedItems.forEach((element) {
//                                       element.then((value) => productList.add(value));
//                                     });
// }
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    print('build');
    // searchProducts();
    log('printing List');

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
                    child: SvgPicture.network("https://www.logo.wine/a/logo/E-mart/E-mart-Logo.wine.svg", height: 45,),
                  )
            ],

          ),
          
        ),
        body: Column(
          children: [
            Container(
                padding: const EdgeInsets.only(
                    bottom: 10, left: 10, right: 10, top: 10),
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
                    ListView.builder(
                      itemCount: productDetails.length,
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
                                                text: productDetails[i]["trackingId"],
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
                                            style:  TextStyle(
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
                                              _launchUrl();
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
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) => ProductDetails(
                                                            imgPath:
                                                                productDetails[i]
                                                                    ["imgPath"],
                                                            trackingId:
                                                                productDetails[i]
                                                                    [
                                                                    "trackingId"],
                                                            productName:
                                                                productDetails[i]
                                                                    [
                                                                    "productName"],
                                                            address:
                                                                productDetails[i]
                                                                    ["address"],
                                                            status:
                                                                productDetails[
                                                                        i][
                                                                    "status"])),
                                                  );
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
                      itemCount: productDetails.length,
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
                                                text: productDetails[i]["trackingId"],
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
                                            style:  TextStyle(
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
                                              _launchUrl();
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
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) => ProductDetails(
                                                            imgPath:
                                                                productDetails[i]
                                                                    ["imgPath"],
                                                            trackingId:
                                                                productDetails[i]
                                                                    [
                                                                    "trackingId"],
                                                            productName:
                                                                productDetails[i]
                                                                    [
                                                                    "productName"],
                                                            address:
                                                                productDetails[i]
                                                                    ["address"],
                                                            status:
                                                                productDetails[
                                                                        i][
                                                                    "status"])),
                                                  );
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
                      itemCount: productDetails.length
                      ,
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
                                                text: productDetails[i]["trackingId"],
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
                                        children:  [
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
                                            style:  TextStyle(
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
                                              _launchUrl();
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
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) => ProductDetails(
                                                            imgPath:
                                                                productDetails[i]
                                                                    ["imgPath"],
                                                            trackingId:
                                                                productDetails[i]
                                                                    [
                                                                    "trackingId"],
                                                            productName:
                                                                productDetails[i]
                                                                    [
                                                                    "productName"],
                                                            address:
                                                                productDetails[i]
                                                                    ["address"],
                                                            status:
                                                                productDetails[
                                                                        i][
                                                                    "status"])),
                                                  );
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
