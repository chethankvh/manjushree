import 'package:flutter/material.dart';
import 'package:manjushree_constructions/service/constant.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({
    Key key,
    @required this.cIndex,
  }) : super(key: key);

  int cIndex;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        // sets the background color of the `BottomNavigationBar`
        canvasColor: const Color(maincolor),
        // sets the active color of the `BottomNavigationBar` if `Brightness` is light
        primaryColor: Colors.white,
      ),
      child: BottomNavigationBar(
          currentIndex: cIndex,
          onTap: (value) {
            final List<String> routes = [
              '/dashboard',
              '/projects',
              '/vehicles',
            ];
            cIndex = value;
            // print(cIndex);
            Navigator.of(context)
                .pushNamedAndRemoveUntil(routes[value], (route) => false);
          },
          items: [
            BottomNavigationBarItem(
                icon: buildIcon(Icons.home, 0), label: 'Home'),
            BottomNavigationBarItem(
                icon: buildIcon(Icons.local_grocery_store, 1),
                label: 'Projects'),
            BottomNavigationBarItem(
                icon: buildIcon(Icons.local_taxi_sharp, 0), label: 'Vehicals'),
          ]),
    );
  }

  Icon buildIcon(icon, index) {
    // print('cindex$cIndex');
    // print(index);
    return Icon(
      icon,
      color: (cIndex == index) ? Colors.white : Colors.white,
    );
  }
}
