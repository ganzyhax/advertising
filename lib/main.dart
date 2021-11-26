import 'dart:io';
import 'dart:math';

import 'package:advesting/tabview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _createLevelFile();
  _read();
  await Firebase.initializeApp();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SDU',
      theme: ThemeData(
        primaryColor: const Color(0xff43537d),
        appBarTheme: const AppBarTheme(color: Colors.white, elevation: 0),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: TabView(),
    );
  }
}

Future<File> _createLevelFile() async {
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocDir.path;
  File file = File('$appDocPath/my_id.txt');
  return await file.create();
}

Future<String?> _read() async {
  String text;
  String check;
  try {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/my_id.txt');

    text = await file.readAsString();
    if (text == null || text == '') {
      DateTime now = new DateTime.now();
      DateTime date =
          new DateTime(now.year, now.month, now.day, now.hour, now.second);

      String time = date.toString();
      Random random = new Random();
      int randomNumber = random.nextInt(100);
      time = time + randomNumber.toString();
      await file.writeAsString(time);
    }
    check = text = await file.readAsString();
    print(check);
  } catch (e) {
    print("Couldn't read file");
  }
  return null;
}
