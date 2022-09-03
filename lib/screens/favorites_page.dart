import 'dart:async';

import 'package:farming_guide/screens/details_body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<String> fetchedData = [];

  final items = List.generate(20, (counter) => 'Item: $counter');
  DatabaseReference ref = FirebaseDatabase.instance.ref("itemsList");
  var authId;
  late Future<List> myFuture;

  List listData = [];
  List newList = [];

  Future<List> readData() async {
    List dataList = [];
    await ref.once().then((snapshot) {
      Map fetchedData = {};
      fetchedData = snapshot.snapshot.value as Map;
      fetchedData.forEach((key, value) {
        dataList.add(value);
      });
    });
    for (int i = 0; i < dataList.length; i++) {
      ref
          .child('${dataList[i]['title']}/${authId.uid}/isFav')
          .onValue
          .listen((event) {
        if (event.snapshot.value.toString() == 'true') {
          newList.add(dataList[i]);
        }
      });
    }
    listData = dataList;
    return newList;
  }

  @override
  void initState() {
    FirebaseAuth auth = FirebaseAuth.instance;
    authId = auth.currentUser!;
    myFuture = readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return FutureBuilder(
      future: Future.wait([myFuture]),
      builder: (BuildContext context, AsyncSnapshot snapshot) => snapshot
                      .connectionState ==
                  ConnectionState.done &&
              snapshot.hasData
          ? Scaffold(
              extendBody: true,
              backgroundColor: Colors.grey[800],
              body: Column(
                children: [
                  Container(
                    height: screenHeight * 0.14,
                    child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          height: screenHeight * 0.2 - 45,
                          decoration: BoxDecoration(
                            color: Colors.green[800],
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(36),
                              bottomRight: Radius.circular(36),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Greenify',
                                style: TextStyle(
                                    fontFamily: 'KaushanScript',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32,
                                    letterSpacing: 2),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: FutureBuilder(
                      future: Future.wait([myFuture]),
                      builder: (context, snapshot) => snapshot
                                      .connectionState ==
                                  ConnectionState.done &&
                              snapshot.hasData
                          ? ListView.builder(
                              itemCount: newList.length,
                              itemBuilder: (context, index) {
                                final item = items[index];
                                return Container(
                                  height: screenHeight / 4,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailsBody(index: index)));
                                    },
                                    child: Card(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: screenWidth / 15,
                                          vertical: 10),
                                      color: Colors.green[800],
                                      child: Center(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.network(
                                              newList[index]['image'],
                                            ),
                                          ),
                                          Container(
                                            width: screenWidth / 2.5,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  newList[index]['title'],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                ),
                                                Text(newList[index]['subtitle'],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15))
                                              ],
                                            ),
                                          ),
                                          Container()
                                        ],
                                      )),
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: CircularProgressIndicator(),
                            ),
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            ),
    );
  }
}
