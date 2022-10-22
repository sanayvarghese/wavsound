import 'package:flutter/material.dart';
import 'package:wavsound/colors.dart';
import 'package:wavsound/components/library_item.dart';
import 'package:wavsound/components/rec_list.dart';
import 'package:wavsound/components/sub_header_home.dart';

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
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                      iconSize: 35,
                      color: AppColors.iconColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                      iconSize: 40,
                      color: AppColors.iconColor,
                    ),
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
