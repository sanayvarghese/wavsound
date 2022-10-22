import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wavsound/colors.dart';

class SoundImport extends StatefulWidget {
  const SoundImport({Key? key}) : super(key: key);

  @override
  State<SoundImport> createState() => _SoundImportState();
}

class _SoundImportState extends State<SoundImport> {
  String? url;
  String source = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(children: [
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
                child: Text("Import",
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
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            padding: const EdgeInsets.symmetric(vertical: 15),
            color: const Color.fromARGB(255, 59, 59, 59),
            child: const Center(child: Text("Ads")),
          ),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Input
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 15, bottom: 0),
                    child: const Text(
                      "URL:",
                      style: TextStyle(
                          fontSize: 20, color: AppColors.dimTextColor),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: AppColors.primaryTextColor),
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.secondaryColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.secondaryColor),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          url = value;
                        });

                        if (value.contains("youtube.com/") ||
                            value.contains("youtu.be/")) {
                          setState(() {
                            source = "YouTube";
                          });
                        } else if (value.contains("open.spotify.com/")) {
                          setState(() {
                            source = "Spotify";
                          });
                        } else if (value.isEmpty) {
                          setState(() {
                            source = "";
                          });
                        } else {
                          setState(() {
                            source = "Direct Link";
                          });
                        }
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // Source
              Text("Source: $source"),

              const SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 41, 32, 32),
                        onSurface: Colors.amber,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {},
                    child: const Center(
                      child: Text(
                        "Download",
                        style: TextStyle(color: AppColors.primaryTextColor),
                      ),
                    )),
              )
            ]),
          ),
        ]),
      ),
    );
  }
}
