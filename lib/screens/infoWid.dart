// ignore_for_file: file_names, unnecessary_null_comparison

import 'dart:io';

import 'package:advesting/app_navigator.dart';
import 'package:advesting/screens/AboutWid.dart';
import 'package:advesting/tabview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class InfoWid extends StatefulWidget {
  final int whichWid;
  const InfoWid({Key? key, required this.whichWid}) : super(key: key);

  @override
  _InfoWidState createState() => _InfoWidState();
}

class _InfoWidState extends State<InfoWid> {
  String? imageFile;
  String? videoFile;
  Color a = Colors.white;
  Color b = Colors.white;
  int isClicked = 0;
  int isLoadImage = 0;
  TextEditingController controllName = new TextEditingController();
  TextEditingController controllTel = new TextEditingController();
  TextEditingController controllEmail = new TextEditingController();
  int isClicked2 = 0;
  String type = '';
  final picker = ImagePicker();
  chooseFile(ImageSource source, int what) async {
    final PickedFile;
    setState(() {
      isLoadImage = 1;
      imageFile = 'http://simpleicon.com/wp-content/uploads/loading.png';
    });
    if (what == 0) {
      PickedFile = await picker.getImage(
        source: source == 'gallery' ? ImageSource.camera : ImageSource.gallery,
      );
    } else {
      PickedFile = await picker.getVideo(
        source: source == 'gallery' ? ImageSource.camera : ImageSource.gallery,
      );
    }

    FirebaseStorage storage = FirebaseStorage.instance;
    String mal = '';
    print(File(PickedFile!.path));
    if (File(PickedFile!.path) != '' ) {
      Reference ref;
      if (what == 0) {
        ref = storage.ref().child("image" + DateTime.now().toString());
      } else {
        ref = storage.ref().child("video" + DateTime.now().toString());
      }
      UploadTask uploadTask = ref.putFile(File(PickedFile!.path));

      uploadTask.whenComplete(() async {
        try {
          String mal = await ref.getDownloadURL();
          if (what == 1) {
            setState(() {
              imageFile =
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/6/68/Video_camera_icon.svg/768px-Video_camera_icon.svg.png';
              videoFile = mal;
            });
          } else {
            setState(() {
              imageFile = mal;
            });
          }
        } catch (onError) {
          print("Error");
        }

        print(mal);
      });
    } else {
      imageFile = '';
    }

    // print(File(PickedFile!.path));

    return null;
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    // ignore: deprecated_member_use
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('widgets').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError || !snapshot.hasData) {
          return Container(
            height: screenHeight * .8,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        PageController controller =
            PageController(viewportFraction: 0.6, initialPage: 1);

        String image = snapshot.data?.docs[widget.whichWid]['image'];
        String address = snapshot.data?.docs[widget.whichWid]['address'];
        String text = snapshot.data?.docs[widget.whichWid]['text'];

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Stack(
                fit: StackFit.passthrough,
                alignment: Alignment.topLeft,
                children: <Widget>[
                  Image.network(
                    image,
                    fit: BoxFit.cover,
                    height: 280,
                    width: double.infinity,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0, left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius:
                                        20.0, // has the effect of softening the shadow
                                    spreadRadius: 2.0,
                                    offset: Offset(
                                      5.0, // horizontal, move right 10
                                      5.0, // vertical, move down 10
                                    ),
                                  ),
                                ],
                                color: Colors.black45),
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 24.0,
                              ),
                              onPressed: () {
                                AppNavigator.pushToPage(context, TabView());
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 62,
                        ),
                        Container(
                          height: 24,
                          width: 72,
                          decoration: BoxDecoration(
                              color: Color(0xffffffffff),
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Center(
                            child: Text(
                              "Billboard",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Product_Sans_Regular",
                                  fontSize: 12.0,
                                  height: 1.4),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            address,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 32.0,
                                fontFamily: "Product_Sans_Bold"),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(16.0),
                              topLeft: Radius.circular(16.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 16.0,
                            ),
                          ],
                          color: Colors.white),
                      margin: EdgeInsets.only(top: 266),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 24,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            child: Text(
                              text,
                              style: TextStyle(
                                  height: 1.4,
                                  color: Color(0xff464646),
                                  fontSize: 18.0,
                                  fontFamily: "Product_Sans_Regular"),
                            ),
                          ),
                          Padding( padding: EdgeInsets.only(top: 20),
                            child: Column(
                              children:[
                                Text("Выберите пакет:",style:TextStyle(fontSize: 24))
                              ],
                            ),),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isClicked = 1;
                                      isClicked2 = 0;
                                      a = Color(0xffC9BEA8);
                                      b = Colors.white;
                                      type = 'Buisness';
                                      print(a);
                                      print(b);
                                    });
                                  },
                                  child: Card(
                                    color: a,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 15.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Buisness',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20)),
                                            Text(
                                              '690 000тг',
                                              style: TextStyle(fontSize: 17),
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  '21 600 показов / в месяц',
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                                Text('720 показов / в сутки',
                                                    style:
                                                        TextStyle(fontSize: 12))
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isClicked2 = 1;
                                      isClicked = 0;
                                      b = Color(0xffC9BEA8);
                                      a = Colors.white;

                                      type = 'Premium';
                                      print(a);
                                      print(b);
                                    });
                                  },
                                  child: Card(
                                    color: b,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 12.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Premium',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20)),
                                            Text(
                                              '1 780 000тг',
                                              style: TextStyle(fontSize: 17),
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  '43 200 показов / в месяц',
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                                Text('1440 показов / в сутки',
                                                    style:
                                                        TextStyle(fontSize: 12))
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 12.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //Image
                                Container(
                                  width: 360,
                                  height: 230,
                                  decoration: new BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(.5),
                                        blurRadius: 20.0, // soften the shadow
                                        spreadRadius: 0.0, //extend the shadow
                                        offset: Offset(
                                          5.0, // Move to right 10  horizontally
                                          5.0, // Move to bottom 10 Vertically
                                        ),
                                      )
                                    ],
                                  ),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 70),
                                          child: (isLoadImage != 0)
                                              ? Image.network(
                                                  imageFile.toString(),
                                                )
                                              : Icon(
                                                  Icons.photo_camera_back,
                                                  size: 200,
                                                  color: Color(0xffC9BEA8),
                                                ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            width: width,
                                            height: 40,

                                            // margin: const EdgeInsets.all(15.0),
                                            // padding: const EdgeInsets.all(3.0),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.6),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(4,
                                                      3), // changes position of shadow
                                                ),
                                              ],
                                            ),

                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                (imageFile != null)
                                                    ? InkWell(
                                                        onTap: () {
                                                          chooseFile(
                                                              ImageSource.gallery,
                                                              0);
                                                        },
                                                        child: Text(
                                                          'Поменять картинку',
                                                          style: TextStyle(
                                                              fontSize: 15),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      )
                                                    : InkWell(
                                                        onTap: () {
                                                          chooseFile(
                                                              ImageSource.gallery,
                                                              0);
                                                        },
                                                        child: Text(
                                                          'Добавить картинку',
                                                          style: TextStyle(
                                                              fontSize: 15),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                (imageFile != null)
                                                    ? InkWell(
                                                        onTap: () {
                                                          chooseFile(
                                                              ImageSource.gallery,
                                                              1);
                                                        },
                                                        child: Text(
                                                          'Поменять видео',
                                                          style: TextStyle(
                                                              fontSize: 15),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      )
                                                    : InkWell(
                                                        onTap: () {
                                                          chooseFile(
                                                              ImageSource.gallery,
                                                              1);
                                                        },
                                                        child: Text(
                                                          'Добавить видео',
                                                          style: TextStyle(
                                                              fontSize: 15),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  width: width - 20,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        // filled: true,
                                        // fillColor: Color(0xFFF2F2F2),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4)),
                                          borderSide: BorderSide(
                                              width: 2, color: Color(0xffC9BEA8)),
                                        ),
                                        border: new OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Color(0xffC9BEA8))),
                                        prefixIcon: Icon(Icons.people,
                                            color: Color(0xffC9BEA8)),
                                        labelText: 'Имя',
                                        labelStyle:
                                            TextStyle(color: Colors.black)),
                                    controller: controllName,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: width - 20,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        // filled: true,
                                        // fillColor: Color(0xFFF2F2F2),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4)),
                                          borderSide: BorderSide(
                                              width: 2, color: Color(0xffC9BEA8)),
                                        ),
                                        border: new OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Color(0xffC9BEA8))),
                                        prefixIcon: Icon(Icons.phone,
                                            color: Color(0xffC9BEA8)),
                                        labelText: 'Телефон',
                                        labelStyle:
                                            TextStyle(color: Colors.black)),
                                    controller: controllTel,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: width - 20,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        // filled: true,
                                        // fillColor: Color(0xFFF2F2F2),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4)),
                                          borderSide: BorderSide(
                                              width: 2, color: Color(0xffC9BEA8)),
                                        ),
                                        border: new OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Color(0xffC9BEA8))),
                                        prefixIcon: Icon(Icons.email,
                                            color: Color(0xffC9BEA8)),
                                        labelText: 'Емайл',
                                        labelStyle:
                                            TextStyle(color: Colors.black)),
                                    controller: controllEmail,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                RaisedButton(
                                    color: Color(0xffC9BEA8),
                                    child: Text(
                                      'Отправить',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                    onPressed: () async {
                                      print(imageFile);
                                      print(controllName.text.toString());
                                      print(controllTel.text.toString());
                                      if (imageFile != null && imageFile != 'http://simpleicon.com/wp-content/uploads/loading.png' &&
                                          controllName.text.toString() != '' &&
                                          controllTel.text.toString() != '' && type != '') {
                                        final Directory directory =
                                            await getApplicationDocumentsDirectory();
                                        final File file =
                                            File('${directory.path}/my_id.txt');

                                        text = await file.readAsString();
                                        print('nut null');
                                        final firebase =
                                            FirebaseFirestore.instance;
                                        DateTime now = new DateTime.now();
                                        DateTime date = new DateTime(
                                            now.day,
                                            now.month,
                                            now.year,
                                            now.hour,
                                            now.minute);
                                        DocumentReference refs = await firebase
                                            .collection('zakazy')
                                            .doc();
                                        String toGo = '';
                                        if (imageFile
                                            .toString()
                                            .contains('wikimedia')) {
                                          toGo = videoFile.toString();
                                        } else {
                                          toGo = imageFile.toString();
                                        }
                                        refs.set({
                                          'tel': controllTel.text.toString(),
                                          'name': controllName.text.toString(),
                                          'email': controllEmail.text.toString(),
                                          'image': toGo,
                                          'type': type,
                                          'id': text,
                                          'data': date.toString(),
                                          'location': widget.whichWid.toString(),
                                          'id_del': refs.id.toString(),
                                        });
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text('Успешно'),
                                                content: Text(
                                                    'Успешно отправлено! Ждите ответ от админа!'),
                                                actions: <Widget>[
                                                  FlatButton(
                                                      child: Text('OK'),
                                                      onPressed: () async {
                                                        controllEmail.text = '';
                                                        controllName.text = '';
                                                        controllTel.text = '';

                                                        Navigator.pop(
                                                            context, true);
                                                      }),
                                                ],
                                              );
                                            });
                                      } else {
                                        print('alert');
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text('Ошибка'),
                                                content: Text(
                                                    'Вы не выбирали картину или не все поля заполнены!'),
                                                actions: <Widget>[
                                                  FlatButton(
                                                      child: Text('OK'),
                                                      onPressed: () async {

                                                        Navigator.pop(
                                                            context, true);
                                                      }),
                                                ],
                                              );
                                            });

                                      }
                                    })
                              ],
                            ),
                          ),
                        ],
                      )),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 242, right: 32),
                      child: Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(24.0)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius:
                                    20.0, // has the effect of softening the shadow
                                spreadRadius: 2.0,
                                offset: Offset(
                                  5.0, // horizontal, move right 10
                                  5.0, // vertical, move down 10
                                ),
                              ),
                            ],
                            color: Colors.white),
                        child: IconButton(
                          icon: Icon(
                            Icons.bookmark_border,
                            color: Colors.black,
                            size: 24.0,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),

                  // Align(
                  //   alignment: Alignment.bottomCenter,
                  //   child: Container(
                  //       height: MediaQuery.of(context).size.height * .27,
                  //       width: double.infinity,
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.only(
                  //               topRight: Radius.circular(16.0),
                  //               topLeft: Radius.circular(16.0)),
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: Colors.black12,
                  //               blurRadius: 20.0,
                  //             ),
                  //           ],
                  //           color: Colors.white),
                  //       child: Padding(
                  //         padding: const EdgeInsets.only(top: 16.0),
                  //         child: Column(
                  //           children: <Widget>[
                  //             ClipRRect(
                  //                 borderRadius: BorderRadius.circular(16),
                  //                 child: Container(
                  //                   color: Color(0xffd8d8d8),
                  //                   height: 5,
                  //                   width: 80,
                  //                 )),
                  //             Padding(
                  //               padding: const EdgeInsets.only(
                  //                 left: 24.0,
                  //                 top: 16,
                  //               ),
                  //               child: Align(
                  //                 alignment: Alignment.topLeft,
                  //                 child: Text(
                  //                   "Read premium article.",
                  //                   style: TextStyle(
                  //                       color: Colors.black,
                  //                       fontSize: 24.0,
                  //                       fontFamily: "Product_Sans_Bold"),
                  //                 ),
                  //               ),
                  //             ),
                  //             Padding(
                  //               padding: const EdgeInsets.only(
                  //                 left: 24.0,
                  //                 top: 4,
                  //               ),
                  //               child: Align(
                  //                 alignment: Alignment.topLeft,
                  //                 child: Text(
                  //                   "Upgrade to premium in just 5\$/month.",
                  //                   style: TextStyle(
                  //                       color: Color(0xff9b9b9b),
                  //                       fontSize: 14.0,
                  //                       fontFamily: "Product_Sans_Regular"),
                  //                 ),
                  //               ),
                  //             ),
                  //             Container(
                  //               width: double.infinity,
                  //               child: Padding(
                  //                 padding: const EdgeInsets.all(16.0),
                  //                 child: RaisedButton(
                  //                   color: Colors.black,
                  //                   shape: RoundedRectangleBorder(
                  //                     borderRadius: BorderRadius.circular(6.0),
                  //                   ),
                  //                   child: Padding(
                  //                     padding: const EdgeInsets.all(16.0),
                  //                     child: Text(
                  //                       "Upgrade Now",
                  //                       style: TextStyle(
                  //                           color: Colors.white,
                  //                           fontSize: 24.0,
                  //                           fontFamily: "Product_Sans_Bold"),
                  //                     ),
                  //                   ),
                  //                   onPressed: () {},
                  //                 ),
                  //               ),
                  //             )
                  //           ],
                  //         ),
                  //       )),
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
