import 'package:flutter/material.dart';
import 'package:tugas_akhir/screen/home.dart';
import 'package:tugas_akhir/screen/list.dart';
import 'package:tugas_akhir/screen/user.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedNavbar = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const ListManga(),
    const UserProfile()
  ];

//TODO : Navbar perlu di fix
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.explore), label: "Rekomendasi"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Top List"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "User")
        ],
        currentIndex: _selectedNavbar,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            _selectedNavbar = index;
          });
        },
      ),
      body: _widgetOptions.elementAt(_selectedNavbar),
    );
  }
}
