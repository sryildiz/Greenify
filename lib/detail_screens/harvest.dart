import 'package:farming_guide/data/list_data.dart';
import 'package:farming_guide/screens/first_screen.dart';
import 'package:farming_guide/screens/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class Harvest extends StatefulWidget {
  int index;
  Harvest({Key? key, required this.index}) : super(key: key);

  @override
  State<Harvest> createState() => _HarvestState();
}

class _HarvestState extends State<Harvest> {
  DatabaseReference ref = FirebaseDatabase.instance.ref("itemsList");

  String _isFav = '';
  var authId;

  List dataList = [];

  Future<List> readData() async {
    await ref.once().then((snapshot) {
      Map fetchedData = {};
      fetchedData = snapshot.snapshot.value as Map;
      fetchedData.forEach((key, value) {
        dataList.add(value);
      });
    });
    ref
        .child('${dataList[widget.index]['title']}/${authId.uid}/isFav')
        .onValue
        .listen((event) {
      _isFav = event.snapshot.value.toString();
    });
    return dataList;
  }

  @override
  void didChangeDependencies() {
    FirebaseAuth auth = FirebaseAuth.instance;
    authId = auth.currentUser!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var dynamicData = ListData().getData;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder(
        future: readData(),
        builder: (context, snapshot) => snapshot.hasData
            ? Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(63),
                              bottomRight: Radius.circular(63)),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 60,
                                color: Colors.grey.withOpacity(0.8))
                          ],
                          color: Colors.green),
                      width: screenWidth / 8,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 35, bottom: 15),
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          FutureBuilder(
                            future: readData(),
                            builder: (context, snapshot) => Container(
                              child: _isFav == '' || _isFav == 'false'
                                  ? IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _isFav = 'true';
                                          ref
                                              .child(dataList[widget.index]
                                                  ['title'])
                                              .child(authId.uid)
                                              .child("isFav")
                                              .set("true");
                                        });
                                      },
                                      icon: Icon(
                                        Icons.favorite_border,
                                        color: Colors.red,
                                      ),
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _isFav = 'false';
                                          ref
                                              .child(dataList[widget.index]
                                                  ['title'])
                                              .child(authId.uid)
                                              .child("isFav")
                                              .set("false");
                                        });
                                      },
                                      icon: Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      ),
                                    ),
                            ),
                          ),
                          Spacer(),
                          RotatedBox(
                            quarterTurns: 3,
                            child: Text(
                              'Greenify',
                              style: TextStyle(
                                  fontSize: 26,
                                  color: Colors.white70,
                                  fontFamily: 'KaushanScript',
                                  letterSpacing: 5.0),
                            ),
                          ),
                          Spacer(),
                          Container(
                            margin: EdgeInsets.only(bottom: 25),
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FirstScreen()));
                              },
                              icon: Icon(
                                Icons.home,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(top: 35, bottom: 15),
                                child: Text(
                                  dataList[widget.index]['title'] + ' Harvest',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Center(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  width: screenWidth / 1.35,
                                  child: Container(
                                    height: size.height * 0.4,
                                    width: size.width * 0.3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(43),
                                        //topRight: Radius.circular(43),
                                        //bottomRight: Radius.circular(43),
                                        bottomLeft: Radius.circular(43),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(0, 10),
                                            blurRadius: 60,
                                            color: Colors.grey.withOpacity(0.8))
                                      ],
                                      image: DecorationImage(
                                        alignment: Alignment.centerLeft,
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            dataList[widget.index]
                                                ['harvestImage']),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 20, top: 15),
                              child: Text(
                                'Procedures to Follow',
                                style: TextStyle(
                                    color: Colors.green[700],
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              width: screenWidth / 1.5,
                              margin: EdgeInsets.only(left: 20, top: 15),
                              child: RichText(
                                  text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                  text: 'When to Harvest: ',
                                  style: TextStyle(
                                      color: Colors.green[700],
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text:
                                      'Harvest potatoes on dry days. Dig up gently, being careful not to puncture the tubers. Avoid cutting or bruising potato skin. \n Harvest ???new??? potatoes, small ones with tender skin, 2 to 3 weeks after plants stop flowering. Eat new potatoes within a few days (curing is not necessary); they will not keep for much longer. \n Harvest larger, mature potatoes 2 to 3 weeks after the foliage has died back. Cut down the brown foliage.',
                                  style: TextStyle(
                                    color: Colors.green[700],
                                    fontSize: 16,
                                  ),
                                )
                              ])),
                            ),
                            Container(
                              width: screenWidth / 1.5,
                              margin: EdgeInsets.only(left: 20, top: 15),
                              child: RichText(
                                  text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                  text: 'Extra Tips: ',
                                  style: TextStyle(
                                      color: Colors.green[700],
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text:
                                      'Toughen up potatoes for storage before harvest by not watering them much after mid-August. After you cut down the brown foliage, leave the potatoes for 10 to 14 more days before you harvest. This allows the potatoes to develop a thicker skin. Don???t wait too long, though, or the potatoes may rot (especially in moisture-laden soil).',
                                  style: TextStyle(
                                    color: Colors.green[700],
                                    fontSize: 16,
                                  ),
                                )
                              ])),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
