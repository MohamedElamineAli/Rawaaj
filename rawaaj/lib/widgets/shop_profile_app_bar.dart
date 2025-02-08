import 'package:flutter/material.dart';

class ShopProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ShopProfileAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black87),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_horiz, color: Colors.black87),
          onPressed: () {},
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
