import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wavsound/classes/colors.dart';
import 'package:wavsound/components/library_item.dart';
import 'package:wavsound/components/search.dart';
import 'package:wavsound/pages/sound_import.dart';
import 'package:wavsound/pages/sound_stream.dart';

class Library extends StatefulWidget {
  const Library({Key? key, this.onTap}) : super(key: key);
  final Function()? onTap;
  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: RefreshIndicator(
        onRefresh: () {
          return Future<void>.delayed(const Duration(seconds: 3));
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            margin: const EdgeInsets.only(right: 20, left: 20, top: 25),
            child: Column(children: [
              // Header
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text("Library",
                    style: TextStyle(
                        fontSize: 28,
                        color: AppColors.primaryTextColor,
                        fontWeight: FontWeight.w600)),
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        showSearch(
                            context: context,
                            delegate: CustomSearchDelegate(searchItems: [
                              "Raining",
                              "Thunder Storm",
                              "Snow Fall",
                              "Morning Forest",
                              "Night Forest",
                            ]));
                      },
                      icon: const Icon(Icons.search),
                      iconSize: 35,
                      color: AppColors.iconColor,
                    ),
                    // const SizedBox(
                    //   width: 10,
                    // ),
                    // IconButton(
                    //   padding: EdgeInsets.zero,
                    //   constraints: const BoxConstraints(),
                    //   onPressed: () {},
                    //   icon: const Icon(Icons.add),
                    //   iconSize: 40,
                    //   color: AppColors.iconColor,
                    // ),
                    PopupMenuButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        splashRadius: 1,
                        iconSize: 40,
                        icon: const Icon(
                          Icons.add,
                          color: AppColors.iconColor,
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0),
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                          ),
                        ),
                        color: const Color.fromARGB(248, 34, 32, 32),
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem<int>(
                              value: 0,
                              textStyle: const TextStyle(
                                  color: AppColors.primaryTextColor),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Icon(
                                    Icons.file_download_outlined,
                                    color: AppColors.iconColor,
                                  ),
                                  Text("Import Sounds"),
                                ],
                              ),
                            ),
                            PopupMenuItem<int>(
                              value: 1,
                              textStyle: const TextStyle(
                                  color: AppColors.primaryTextColor),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Icon(
                                    Icons.sensors_rounded,
                                    color: AppColors.iconColor,
                                  ),
                                  Text("Stream Sound"),
                                ],
                              ),
                            ),
                            PopupMenuItem<int>(
                              value: 2,
                              textStyle: const TextStyle(
                                  color: AppColors.primaryTextColor),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Icon(
                                    Icons.video_file,
                                    color: AppColors.iconColor,
                                  ),
                                  Text("Extract audio"),
                                ],
                              ),
                            ),
                          ];
                        },
                        onSelected: (value) {
                          if (value == 0) {
                            Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) => const SoundImport(),
                            ));
                          } else if (value == 1) {
                            Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) => const SoundStream(),
                            ));
                          } else if (value == 2) {
                            Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) => const SoundImport(),
                            ));
                          }
                        }),
                  ],
                )
              ]),

              // Ads
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                padding: const EdgeInsets.symmetric(vertical: 15),
                color: const Color.fromARGB(255, 59, 59, 59),
                child: const Center(child: Text("Ads")),
              ),

              LibItem(
                song: "Favorite",
                img: "assets/img/raining.jpg",
                isPlaylist: true,
                onTap: widget.onTap,
              ),
              LibItem(
                song: "Downloads",
                img: "assets/img/raining.jpg",
                isPlaylist: true,
                onTap: widget.onTap,
              ),
              LibItem(
                song: "Raining",
                img: "assets/img/raining.jpg",
                isPlaylist: false,
                onTap: widget.onTap,
              ),
              LibItem(
                song: "Thunder Storm",
                isPlaylist: false,
                img: "assets/img/thunder.jpg",
                onTap: widget.onTap,
              ),

              LibItem(
                song: "Snow Fall",
                isPlaylist: false,
                img: "assets/img/snow.jpg",
                onTap: widget.onTap,
              ),

              LibItem(
                song: "Morning Forest",
                isPlaylist: false,
                img: "assets/img/forest.jpg",
                onTap: widget.onTap,
              ),

              LibItem(
                song: "Night Forest",
                isPlaylist: false,
                img: "assets/img/nightforest.jpg",
                onTap: widget.onTap,
              ),

              LibItem(
                song: "Music",
                isPlaylist: false,
                img: "assets/img/music.jpg",
                onTap: widget.onTap,
              ),

              const SizedBox(
                height: 20,
              )
            ]),
          ),
        ),
      ),
    );
  }
}
