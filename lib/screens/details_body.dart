import 'package:farming_guide/data/list_data.dart';
import 'package:farming_guide/detail_screens/harvest.dart';
import 'package:farming_guide/detail_screens/plant.dart';
import 'package:farming_guide/detail_screens/preplant.dart';
import 'package:flutter/material.dart';

class DetailsBody extends StatelessWidget {
  int index;
  DetailsBody({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var detailData = ListData().getData;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: SizedBox(
                height: size.height * 0.8,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                padding: EdgeInsets.symmetric(horizontal: 30),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.arrow_back),
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PrePlant(
                                            index: index,
                                          )),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 55),
                                padding: EdgeInsets.all(5),
                                height: 62,
                                width: 62,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(22),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 10),
                                        blurRadius: 22,
                                        color: Colors.grey),
                                    BoxShadow(
                                        offset: Offset(-15, -15),
                                        blurRadius: 20,
                                        color: Colors.white)
                                  ],
                                ),
                                child: Image(
                                  image: AssetImage('assets/icons/dirt.png'),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Plant(
                                            index: index,
                                          )),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 55),
                                padding: EdgeInsets.all(5),
                                height: 62,
                                width: 62,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(22),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 10),
                                        blurRadius: 22,
                                        color: Colors.grey),
                                    BoxShadow(
                                        offset: Offset(-15, -15),
                                        blurRadius: 20,
                                        color: Colors.white)
                                  ],
                                ),
                                child: Image(
                                  image: AssetImage('assets/icons/water.png'),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Harvest(
                                            index: index,
                                          )),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 55),
                                padding: EdgeInsets.all(5),
                                height: 62,
                                width: 62,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(22),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 10),
                                        blurRadius: 22,
                                        color: Colors.grey),
                                    BoxShadow(
                                        offset: Offset(-15, -15),
                                        blurRadius: 20,
                                        color: Colors.white)
                                  ],
                                ),
                                child: Image(
                                  image: AssetImage('assets/icons/plant.png'),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: size.height * 0.8,
                      width: size.width * 0.75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(63),
                            bottomLeft: Radius.circular(63)),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 60,
                              color: Colors.grey.withOpacity(0.8))
                        ],
                        image: DecorationImage(
                          alignment: Alignment.centerLeft,
                          fit: BoxFit.cover,
                          scale: 0.2,
                          image: NetworkImage(detailData[index]['image']),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: detailData[index]['title'] + '\n',
                          style: TextStyle(
                              color: Colors.green[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 32),
                        ),
                        TextSpan(
                          text: 'Growing Details',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.green[900],
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Text(
                    "Greenify",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.green[800],
                      fontFamily: 'KaushanScript',
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
