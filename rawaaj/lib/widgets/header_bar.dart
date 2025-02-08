import 'package:flutter/material.dart';
import 'package:rawaaj/screens/filter_screen.dart';
import 'package:rawaaj/screens/specific_shop_screen.dart';
import 'package:rawaaj/themes/colors.dart';

class HeaderBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isFiltered;

  const HeaderBar({Key? key, required this.title, required this.isFiltered}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shadowColor: const Color(0xFFF4F4F4),
      flexibleSpace: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 25),
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search",
                        suffixIcon: GestureDetector(
                          onTap: () {
                            if (!isFiltered) return;
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const FilterScreen()),
                            );
                          },
                          child: Icon(
                            Icons.filter_alt_outlined,
                            color: isFiltered ? primaryColor : Colors.transparent,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: searchBarColor,
                        hintStyle: const TextStyle(color: searchTextColor),
                      ),
                      onSubmitted: (value) {
                        if(value.isEmpty) {
                          return;
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SpecificShopScreen(name: 'Search', searchType: 0, searchValue: value,)),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}