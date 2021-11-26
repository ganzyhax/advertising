import 'package:advesting/screens/AboutWid.dart';
import 'package:advesting/screens/HomeScreen.dart';
import 'package:advesting/screens/Korzina.dart';
import 'package:advesting/screens/infoWid.dart';
import 'package:flutter/material.dart';

class TabView extends StatefulWidget {
  @override
  _TabViewState createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[HomeScreen(), AboutWid(), Korzina()];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                title: Text('Главная'),
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
              icon: Icon(Icons.sell_outlined),
              title: Text('Заказ'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket_outlined),
              title: Text('Корзина'),
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTap,
          selectedFontSize: 13.0,
          unselectedFontSize: 13.0,
          unselectedItemColor: Color(0xffC9BEA8),
          selectedItemColor: Color(0xffC9BEA8),
        ));
  }
}
