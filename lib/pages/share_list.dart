import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:wavsound/constants/colors.dart';
import 'package:wavsound/constants/share_page_list.dart';
import 'package:wavsound/pages/sound_import.dart';
import 'package:wavsound/pages/sound_stream.dart';

class ShareListingScreen extends StatefulWidget {
  final String? text;
  final SharedMediaFile? file;
  const ShareListingScreen({Key? key, this.text = "", this.file})
      : super(key: key);
  @override
  ShareListingScreenState createState() => ShareListingScreenState();
}

class ShareListingScreenState extends State<ShareListingScreen> {
  List<SharePageDetails> pages = [
    SharePageDetails(pageTitle: "Import Sounds", isSelected: false),
    SharePageDetails(pageTitle: "Stream Sounds", isSelected: false),
    SharePageDetails(pageTitle: "Extract Sounds from Video", isSelected: false),
  ];
  bool isSelected = false;
  List<String?> selectedNames = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.text);
    print(widget.file);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
                  child: Text("Select",
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

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Import Audios

                    widget.text!.isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(CupertinoPageRoute(
                                  builder: ((context) => SoundImport(
                                        text: widget.text,
                                      ))));
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 15),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 0, 0, 0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.file_download_outlined,
                                    color: AppColors.iconColor,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Import Sounds",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox(),

                    // Stream Play
                    widget.text!.isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(CupertinoPageRoute(
                                  builder: ((context) => SoundStream())));
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 0, 0, 0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.sensors_outlined,
                                    color: AppColors.iconColor,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Stream Play",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox(),

                    // Audio Extractor

                    widget.file! != null
                        ? GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(CupertinoPageRoute(
                                  builder: ((context) => const SoundStream())));
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 0, 0, 0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.video_file,
                                    color: AppColors.iconColor,
                                    size: 25,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Extract Audio From Video",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ]),
            ),
          ]),
        ),
      ),
    );
  }
}
