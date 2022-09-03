import 'package:farming_guide/data/list_data.dart';
import 'package:farming_guide/screens/details_body.dart';
import 'package:farming_guide/screens/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int cardIndex = 0;
  var cardData = ListData().getData;
  List<String> fetchedData = [];

  final items = List.generate(20, (counter) => 'Item: $counter');
  DatabaseReference ref = FirebaseDatabase.instance.ref("itemsList");

  List listData = [];
  readData() async {
    List dataList = [];
    await ref.once().then((snapshot) {
      Map fetchedData = {};
      fetchedData = snapshot.snapshot.value as Map;
      fetchedData.forEach((key, value) {
        dataList.add(value);
      });
      listData = dataList;
    });
  }

  @override
  void initState() {
    FirebaseAuth auth = FirebaseAuth.instance;
    var authId = auth.currentUser!;
    ref.child("Carrot").child(authId.uid).child("isCreated").set("true");
    ref.child("Potato").child(authId.uid).child("isCreated").set("true");
    ref.child("Tomato").child(authId.uid).child("isCreated").set("true");
    ref.child("Onion").child(authId.uid).child("isCreated").set("true");
    ref.child("Cucumber").child(authId.uid).child("isCreated").set("true");

    //readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Stream<DatabaseEvent> stream = ref.onValue;
    // stream.listen((DatabaseEvent event) {
    //   print(event.snapshot.value);
    // });

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          Container(
            height: screenHeight * 0.2,
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: screenHeight * 0.2 - 27,
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
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 35),
                    height: 54,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: TextField(
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: TextStyle(color: Colors.green[800]),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          suffixIcon: Icon(
                            Icons.search,
                            color: Colors.green[800],
                          ),
                        ),
                      ),
                    ),
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
              future: readData(),
              builder: (context, snapshot) => ListView.builder(
                itemCount: listData.length,
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
                            horizontal: screenWidth / 15, vertical: 10),
                        color: Colors.green[800],
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                listData[index]['image'],
                              ),
                            ),
                            Container(
                              width: screenWidth / 2.5,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    listData[index]['title'],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  Text(listData[index]['subtitle'],
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15))
                                ],
                              ),
                            ),
                            Container()
                          ],
                        )),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
