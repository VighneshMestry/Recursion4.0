import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:recursion_hackathon/common/custom_textfield.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../constants/app_colors.dart' as AppColors;

import '../constants/tab.dart';
import '../enum/menu_action.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late List popularBooks;
  late List books;

  var selectedTabView = 1;

  final TextEditingController _searchBarController = TextEditingController();
  late ScrollController _scrollController;
  late TabController _tabController;

// final Uri _url = Uri.parse('https://flutter.dev');
  final Uri _url = Uri.parse(
      'https://www.google.com/maps?q=Gharkul+Society,+Bharat+Nagar,+Versova,+Andheri+West,+Mumbai,+Maharashtra+400061&ftid=0x3be7c9e13ef9c8f1:0xb1c2f0f83e476d54&hl=en-IN&gl=in&entry=gps&lucs=47062714&g_ep=CAISBjYuNTcuMRgAINeCAyoINDcwNjI3MTRCAklO&g_st=ic');
  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  // void launchMap(String address) async {
  //   String query = Uri.encodeComponent(address);
  //   String googleUrl = "https://www.google.com/maps/search/?api=1&query=$query";

  //   if (await canLaunchUrlString(googleUrl)) {
  //     await launchUrlString(googleUrl);
  //   }
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
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabController = TabController(length: 3, vsync: this);
    ReadData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.black,
          title: const Text('UniEx Seller'),
          actions: [
            PopupMenuButton<MenuAction>(
              onSelected: (value) async {
                switch (value) {
                  case MenuAction.logout:
                  // final showLogout = await showLogOutDialog(context);
                  // if(showLogout){
                  //   // ignore: use_build_context_synchronously
                  //   context.read<AuthBloc>().add(const AuthEventLogOut(),);
                  //   // Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (_) => false);
                  // }
                }
              },
              itemBuilder: (context) {
                return const [
                  PopupMenuItem<MenuAction>(
                    value: MenuAction.logout,
                    child: Text('My Accout'),
                  ),
                  PopupMenuItem<MenuAction>(
                    value: MenuAction.logout,
                    child: Text('Log out'),
                  )
                ];
              },
            )
          ],
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
                              AppTab(color: Colors.black54, text: "All"),
                              AppTab(color: Colors.black54, text: "Ordered"),
                              AppTab(color: Colors.black87, text: "Out For Delivery"),

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
                      itemCount: books.length,
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
                                                text: books[i]["id"],
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
                                          (books[i]['status'] == 'Delivered')
                                              ? const Icon(
                                                  Icons.done_rounded,
                                                  color: Colors.green,
                                                  size: 26,
                                                )
                                              : Icon(
                                                  Icons.local_shipping,
                                                  color: Colors.amber[400],
                                                ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            books[i]["status"],
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontFamily: "Avenir",
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue,
                                          ),
                                          onPressed: () {
                                            _launchUrl();
                                          },
                                          child: const Text("Get Location")),
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
                      itemCount: books.length,
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
                                                text: books[i]["id"],
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
                                            const Icon(
                                                  Icons.done_rounded,
                                                  color: Colors.green,
                                                  size: 26,
                                                ),
                                              
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            books[i]["status"],
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontFamily: "Avenir",
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue,
                                          ),
                                          onPressed: () {
                                            _launchUrl();
                                          },
                                          child: const Text("Get Location")),
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
                      itemCount: books.length,
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
                                                text: books[i]["id"],
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
                                                  color: Colors.amber[400],
                                                  size: 26,
                                                ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            books[i]["status"],
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontFamily: "Avenir",
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue,
                                          ),
                                          onPressed: () {
                                            _launchUrl();
                                          },
                                          child: const Text("Get Location")),
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
              ),
            )
            //Expanded over
          ],
        ),
      ),
    );
  }
}