// ignore_for_file: file_names

import 'package:advesting/screens/infoWid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:advesting/app_navigator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    List<Widget> banners = <Widget>[];
    PageController controller =
        PageController(viewportFraction: 0.9, initialPage: 0);
    double width = MediaQuery.of(context).size.width;
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
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
              const Padding(
                padding: const EdgeInsets.only(left: 20, top: 40),
                child: Text(
                  'НОВАЯ РЕКЛАМНАЯ ПЛОЩАДКА',
                  style: TextStyle(fontSize: 30),
                ),
              ),
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
                    padding: EdgeInsets.only(top: 40),
                    child: Container(
                      width: width + 200,
                      height: screenHeight / 3.2,
                      child: PageView.builder(
                          controller: controller,
                          scrollDirection: Axis.horizontal,
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
                                        padding: const EdgeInsets.only(top: 180),
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
                                        height: 260,
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
              const Padding(
                padding: const EdgeInsets.only(left: 24, top: 40),
                child: Text(
                  'ГРАФИК СРЕДНЕЙ ПОСЕЩАЕМОСТИ',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Card(
                  color: Colors.white,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 360,
                      height: 200,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Праздничный день',
                                style:
                                    TextStyle(fontSize: 17, color: Colors.black),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 80),
                                child: Text(
                                  '162 000',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: LinearProgressIndicator(
                              value: 0.8,
                              minHeight: 15,
                              backgroundColor: Colors.black,
                              valueColor:
                                  AlwaysStoppedAnimation(Color(0xffC9BEA8)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Выходной день',
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.black),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 80),
                                  child: Text(
                                    '132 000',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: LinearProgressIndicator(
                              value: 0.5,
                              minHeight: 12,
                              backgroundColor: Colors.black,
                              valueColor:
                                  AlwaysStoppedAnimation(Color(0xffC9BEA8)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Будний день',
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.black),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 80),
                                  child: Text(
                                    '95 000',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: LinearProgressIndicator(
                              value: 0.3,
                              minHeight: 15,
                              backgroundColor: Colors.black,
                              valueColor:
                                  AlwaysStoppedAnimation(Color(0xffC9BEA8)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: const EdgeInsets.only(left: 24, top: 40),
                child: Text(
                  'ТЕХНИЧЕСКИЕ ХАРАКТЕРИСТИКИ',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: Color(0xffC9BEA8),
                            ),
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('3.7 X 7.3'),
                              Text('МЕТРА'),
                            ],
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              child: Text(
                                'РАЗМЕР ЭКРАНА',
                                textAlign: TextAlign.center,
                              ),
                              width: 100,
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: Color(0xffC9BEA8),
                            ),
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('00:00'),
                              Text('24:00'),
                            ],
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              child: Text(
                                'ВРЕМЯ ТРАНЦЛИЯЦИИ',
                                textAlign: TextAlign.center,
                              ),
                              width: 100,
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: Color(0xffC9BEA8),
                            ),
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('1920'),
                              Text('1080'),
                            ],
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              child: Text(
                                'РАЗМЕР ВИДЕО ФАЙЛА',
                                textAlign: TextAlign.center,
                              ),
                              width: 100,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: const EdgeInsets.only(left: 24, top: 40),
                child: Text(
                  'СТОИМОСТЬ РАЗМЕЩЕНИЯ',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Card(
                    color: Colors.white,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      children: [
                        Container(
                          width: 300,
                          height: 150,
                          color: Color(0xffC9BEA8),
                          child: Center(
                            child: Text(
                              'БИЗНЕС',
                              style: TextStyle(fontSize: 40, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Container(
                          height: 170,
                          width: 300,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.price_change_outlined,
                                      size: 40,
                                      color: Color(0xffC9BEA8),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text('ЦЕНА : 690 000 тг'),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.remove_red_eye,
                                      size: 40,
                                      color: Color(0xffC9BEA8),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text('21 600 показов / в месяц'),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.remove_red_eye,
                                      size: 40,
                                      color: Color(0xffC9BEA8),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text('720 показов / в сутки'),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Card(
                    color: Colors.white,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      children: [
                        Container(
                          width: 300,
                          height: 150,
                          color: Color(0xffC9BEA8),
                          child: Center(
                            child: Text(
                              'ПРЕМУИМ',
                              style: TextStyle(fontSize: 40, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Container(
                          height: 170,
                          width: 300,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.price_change_outlined,
                                      size: 40,
                                      color: Color(0xffC9BEA8),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text('ЦЕНА : 1 780 000 тг'),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.remove_red_eye,
                                      size: 40,
                                      color: Color(0xffC9BEA8),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text('43 200 показов / в месяц'),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.remove_red_eye,
                                      size: 40,
                                      color: Color(0xffC9BEA8),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text('1440 показов / в сутки'),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    ));
  }
}
