import 'package:flutter/material.dart';
import 'package:wavsound/classes/colors.dart';
import 'package:wavsound/components/setting_item.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: const EdgeInsets.only(right: 20, left: 20, top: 25),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Navigator.of(context).canPop()
                    ? IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.chevron_left),
                        iconSize: 40,
                        color: AppColors.iconColor,
                      )
                    : const SizedBox(),
                const Center(
                  child: Text("Settings",
                      style: TextStyle(
                          fontSize: 25,
                          color: AppColors.primaryTextColor,
                          fontWeight: FontWeight.w600)),
                ),
                const SizedBox(
                  width: 10,
                )
              ],
            ),

            // Ads
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              padding: const EdgeInsets.symmetric(vertical: 15),
              color: const Color.fromARGB(255, 59, 59, 59),
              child: const Center(child: Text("Ads")),
            ),

            // Profile
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                        width: 1, color: AppColors.primaryTextColor),
                    backgroundColor: AppColors.navColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    primary: AppColors.dimTextColor),
                onPressed: () {},
                child: const Center(child: Text("Sign Up"))),
            TextButton(
                onPressed: (() {}),
                style: TextButton.styleFrom(primary: AppColors.dimTextColor),
                child: const Center(
                  child: Text("Sign in"),
                )),

            // Account
            // Plan

            //Sub Header
            const Text(
              "Account",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),

            const SettingItem(
              title: "Plan",
              discription: "View your Plan",
            ),

            //Sub Header
            // Downloads
            const Text(
              "Downloads",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            SettingItem(
              title: "Download Folder",
              discription: "/storage/0/emulated/WavSound/Imports",
              sideButton: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 41, 32, 32),
                      onSurface: Colors.amber,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {},
                  child: const Center(
                    child: Text(
                      "Change",
                      style: TextStyle(color: AppColors.primaryTextColor),
                    ),
                  )),
            ),

            //Sub Header
            // Storage
            const Text(
              "Storage",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            const SettingItem(
              title: "Clear Cache",
              discription:
                  "You can free up storage by clearing your cache. You'r downloads won't be removed.",
            ),

            //Sub Header
            // About

            const Text(
              "About",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            const SettingItem(
              title: "Version",
              discription: "v1.0.0",
            ),
            SettingItem(
              title: "Terms and Conditions",
              sideButton: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.chevron_right_sharp,
                    color: AppColors.iconColor,
                  )),
            ),
            SettingItem(
              title: "Privacy and Policy",
              sideButton: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.chevron_right_sharp,
                    color: AppColors.iconColor,
                  )),
            ),
            SettingItem(
              title: "Contact",
              sideButton: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.chevron_right_sharp,
                    color: AppColors.iconColor,
                  )),
            ),

            // Sub Header
            // Other
            const Text(
              "Other",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            const SettingItem(
              title: "Log Out",
              discription: "Logout from WavSound",
            ),
            const SizedBox(
              height: 10,
            )
          ]),
        ),
      ),
    );
  }
}
