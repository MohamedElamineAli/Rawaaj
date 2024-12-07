import 'package:flutter/material.dart';
import 'package:rawaaj/screens/filter_screen.dart';
import 'package:rawaaj/themes/colors.dart';

class HeaderBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool isFiltered;

  const HeaderBar({Key? key, required this.title, required this.isFiltered}) : super(key: key);

  @override
  State<HeaderBar> createState() => _HeaderBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}

class _HeaderBarState extends State<HeaderBar> {
  @override
  Widget build(BuildContext context) {
    bool isFiltered = widget.isFiltered;

    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shadowColor: Color(0xFFF4F4F4),
      flexibleSpace: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 25,),
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search",
                        suffixIcon: GestureDetector(
                          onTap: () {
                            if(!isFiltered) return;
                            Navigator.push( context, MaterialPageRoute(builder: (context) => FilterScreen()), );
                          },
                          child: Icon(Icons.filter_alt_outlined, color: isFiltered ? primaryColor : Colors.transparent),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: searchBarColor,
                        hintStyle: TextStyle(color: searchTextColor)
                      ),
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

