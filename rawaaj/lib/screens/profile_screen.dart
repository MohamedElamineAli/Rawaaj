import 'package:flutter/material.dart';
import 'package:rawaaj/widgets/profile_info.dart';
import '../widgets/followed_shops.dart';
import '../widgets/horizontal_list.dart';
import '../widgets/outfit_line.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, top: 42),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileInfo(),
              SizedBox(height: 16,),
              FollowedShops(),
              SizedBox(height: 16,),
              HorizontalListSection(title: "Recently Viewed", itemsCount: 6, padding: 0,),
              SizedBox(height: 16,),
              OutfitLine(title: "Recently Viewed Outfits"),
              SizedBox(height: 16,),
            ],
          ),
        ),
      ),
    );
  }
}
