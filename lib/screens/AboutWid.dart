// ignore_for_file: file_names

import 'package:advesting/app_navigator.dart';
import 'package:advesting/screens/infoWid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AboutWid extends StatefulWidget {
  const AboutWid({Key? key}) : super(key: key);

  @override
  _AboutWidState createState() => _AboutWidState();
}

class _AboutWidState extends State<AboutWid> {
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    List<Widget> banners = <Widget>[];
    PageController controller =
        PageController(viewportFraction: 0.9, initialPage: 1);
    double width = MediaQuery.of(context).size.width;
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'LED',
                          style: TextStyle(
                              fontSize: 30,
                              color: Color(0xffC9BEA8),
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        Text('BILLBOARD',
                            style: TextStyle(
                                fontSize: 35,
                                color: Color(0xffC9BEA8),
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    Container(
                      child: Text(
                        '2021',
                        style: TextStyle(
                            fontSize: 55,
                            color: Color(0xffC9BEA8),
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
              'ВЫБЕРИТЕ РЕКЛАМНУЮ ПЛОЩАДКУ',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25),
            )),
            StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('widgets').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError || !snapshot.hasData) {
                  return Container(
                    height: screenHeight * .8,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                return Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Container(
                    width: width,
                    height: screenHeight,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          PageController controller = PageController(
                              viewportFraction: 0.6, initialPage: 1);

                          String image = snapshot.data?.docs[index]['image'];
                          String address =
                              snapshot.data?.docs[index]['address'];

                          return InkWell(
                              onTap: () {
                                AppNavigator.pushToPage(
                                    context, InfoWid(whichWid: index));
                              },
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 170),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Container(
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    size: 40,
                                                    color: Colors.white,
                                                  ),
                                                  Text(
                                                    address,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Ink.image(
                                      image: NetworkImage(image),
                                      height: 220,
                                      fit: BoxFit.cover,
                                    )
                                  ],
                                ),
                              ));
                        }),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ));
  }
}
