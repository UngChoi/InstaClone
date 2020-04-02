import 'package:flutter/material.dart';

import 'account_page.dart';
import 'home_page.dart';
import 'search_page.dart';
import 'package:firebase_auth/firebase_auth.dart';


class TabPage extends StatefulWidget {
  final FirebaseUser user;

  TabPage(this.user);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _selectedIndex = 0;
  List _pages;

  @override
  void initState() { // 빌드 전 생성자 전에 실행 - 초기화 류
    // TODO: implement initState
    super.initState();
    _pages = [
      HomePage(widget.user),
      SearchPage(widget.user),
      AccountPage(widget.user),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Center(child: _pages[_selectedIndex],),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor:  Colors.black,
        onTap: _onItemTaped,
        currentIndex: _selectedIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(icon: Icon(Icons.search), title: Text('Search')),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), title: Text('account')),
      ],),
    );
  }

  void _onItemTaped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }
}
