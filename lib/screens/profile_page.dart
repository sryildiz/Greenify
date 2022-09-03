import 'package:farming_guide/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 55, left: 11, right: 11),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 155,
              width: 155,
              child: Stack(
                clipBehavior: Clip.none,
                fit: StackFit.expand,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/images/serdar.jpg"),
                  ),
                  Positioned(
                      bottom: 0,
                      right: -25,
                      child: RawMaterialButton(
                        onPressed: () {},
                        elevation: 2.0,
                        fillColor: Color(0xFFF5F6F9),
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.green,
                        ),
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Serdar Yıldız',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Signed in with: ',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 14,
                  ),
                ),
                Text(
                  user.email!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 44,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  customButton('Edit Profile'),
                  line(),
                  customButton('Language'),
                  line(),
                  customButton('Privacy Rights'),
                  line(),
                  customButton('Terms and Conditions'),
                  line(),
                  TextButton(
                      style: TextButton.styleFrom(
                          maximumSize: Size(double.maxFinite, 45),
                          minimumSize: Size(double.maxFinite, 45)),
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Log out',
                          style: TextStyle(fontSize: 24, color: Colors.red),
                        ),
                      )),
                ],
              ),
            )
          ],
        ));
  }

  Widget line() {
    return Container(
      alignment: Alignment.centerLeft,
      width: double.maxFinite,
      height: 1,
      color: Colors.green,
    );
  }

  Widget customButton(String label) {
    return TextButton(
        style: TextButton.styleFrom(
            maximumSize: Size(double.maxFinite, 45),
            minimumSize: Size(double.maxFinite, 45)),
        onPressed: () {},
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ));
  }
}
