import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_icecream/ice_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 2;

  Widget getWidgets(int index) {
    // kısım kısım sayfaları oluşturmak için;
    switch (index) {
      case 0:
        return const Center(
          child: Text("Setting"),
        );
      case 1:
        return const Center(
          child: Text("Notification"),
        );
      case 2:
        return const Center(
          child: IceCreamHomePage(),
        );
      case 3:
        return const Center(
          child: Text("Favorite"),
        );
      case 4:
        return const Center(
          child: Text("Profile"),
        );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        // 1- Curved Navigation Bar
        bottomNavigationBar: CurvedNavigationBar(
          index: _selectedIndex,
          backgroundColor: Colors.white,
          color: Color.fromARGB(255, 238, 100, 7),
          buttonBackgroundColor: Colors.purple,
          height: 62,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            Icon(Icons.settings, color: Colors.white),
            Icon(Icons.notifications, color: Colors.white),
            Icon(Icons.home, color: Colors.white),
            Icon(Icons.favorite, color: Colors.white),
            Icon(Icons.person, color: Colors.white),
          ],
        ),
        body: getWidgets(_selectedIndex),
      ),
    );
  }
}
