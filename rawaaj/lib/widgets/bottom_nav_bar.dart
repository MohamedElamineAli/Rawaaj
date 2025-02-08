import 'package:flutter/material.dart';
import 'package:rawaaj/cubit/main_index_cubit.dart';
import '../themes/icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBar extends StatelessWidget {
  final int selected;

  const BottomNavBar({
    Key? key,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> icons = List.generate(
      5,
      (index) =>
          index == selected ? selectedNavBarIcons[index] : navBarIcons[index],
    );

    return BottomNavigationBar(
          onTap: (newIndex) => context.read<MainIndexCubit>().changeMainIndex(newIndex),
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
