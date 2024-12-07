import 'package:flutter/material.dart';
import '../themes/icons.dart';

class BottomNavBar extends StatelessWidget {
  final int selected;
  final ValueChanged<int> changeIndex;

  const BottomNavBar({
    Key? key,
    required this.selected,
    required this.changeIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> icons = List.generate(
      5,
          (index) => index == selected
          ? selectedNavBarIcons[index]
          : navBarIcons[index],
    );

    return BottomNavigationBar(
      onTap: changeIndex,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: selected,
      items: List.generate(
        5,
            (index) => BottomNavigationBarItem(
          icon: icons[index],
          label: "",
        ),
      ),
    );
  }
}
