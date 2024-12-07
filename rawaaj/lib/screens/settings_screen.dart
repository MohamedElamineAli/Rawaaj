import 'package:flutter/material.dart';
import 'package:rawaaj/screens/about_rawaaj_screen.dart';
import 'package:rawaaj/screens/address_edit_screen.dart';
import 'package:rawaaj/screens/language_selection_screen.dart';
import 'package:rawaaj/screens/profile_info_edit_screen.dart';
import 'package:rawaaj/screens/terms_and_conditions_screen.dart';
import 'package:rawaaj/widgets/sub_screen_app_bar.dart';
import '../widgets/delete_account_alert_dialog.dart';
import '../widgets/settings_section.dart';
import '../widgets/settings_item.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SubScreenAppBar(name: "Settings"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SettingsSection(
                title: 'Personal',
                items: [
                  SettingsItem(
                    title: 'Profile',
                    onTap: () {
                      Navigator.push( context, MaterialPageRoute(builder: (context) => ProfileInfoEditScreen(),) );
                    },
                  ),
                  SettingsItem(
                    title: 'Shipping Address',
                    onTap: () {
                      Navigator.push( context, MaterialPageRoute(builder: (context) => AddressEditScreen(),) );
                    },
                  ),
                  SettingsItem(
                    title: 'Terms and Conditions',
                    onTap: () {
                      Navigator.push( context, MaterialPageRoute(builder: (context) => TermsAndConditionsScreen(),) );
                    },
                  ),
                ],
              ),

              // Account Section
              SettingsSection(
                title: 'Account',
                items: [
                  SettingsItem(
                    title: 'Language',
                    trailingText: 'English',
                    onTap: () {
                      Navigator.push( context, MaterialPageRoute(builder: (context) => LanguageSelectionScreen(),) );
                    },
                  ),
                  SettingsItem(
                    title: 'About Rawaaj',
                    onTap: () {
                      Navigator.push( context, MaterialPageRoute(builder: (context) => AboutRawaajScreen(),) );
                    },
                  ),
                ],
              ),

              // Delete Account
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return DeleteAccountAlertDialog(
                          onDelete: () {
                            Navigator.of(context).pop(); // Close the dialog
                            // Add delete logic here
                            print("Account deleted");
                          },
                        );
                      },
                    );
                  },
                  child: Text(
                    'Delete My Account',
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(height: 12,),
              const Text(
                'Rawaaj',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const Text(
                'Version 1.0 December, 2024',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
