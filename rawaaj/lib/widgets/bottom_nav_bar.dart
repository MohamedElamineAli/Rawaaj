import 'package:flutter/material.dart';
import 'package:rawaaj/themes/colors.dart';
import 'package:rawaaj/themes/icons.dart';

class BottomNavBar extends StatelessWidget {
  final int selected;

  const BottomNavBar({Key? key, required this.selected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lastNavBarIcons = navBarIcons;
    lastNavBarIcons.replaceRange(selected, selected+1, [selectedNavBarIcons[selected]]);
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        for(int i=0; i<5; i++) BottomNavigationBarItem(icon: navBarIcons[i], label: ""),
      ],
    );
  }
}
