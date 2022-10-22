import 'package:flutter/material.dart';
import 'package:wavsound/colors.dart';
import 'package:wavsound/components/library_item.dart';
import 'package:wavsound/components/rec_list.dart';
import 'package:wavsound/components/sub_header_home.dart';

class PlayList extends StatefulWidget {
  const PlayList({Key? key, required this.song, this.onTap}) : super(key: key);
  final String song;
  final Function()? onTap;
  @override
  State<PlayList> createState() => _LibraryState();
}

class _LibraryState extends State<PlayList> {
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
              Row(children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_outlined),
                  iconSize: 30,
                  color: AppColors.iconColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text("Library",
                    style: TextStyle(
                        fontSize: 28,
                        color: AppColors.primaryTextColor,
                        fontWeight: FontWeight.w600)),
              ]),

              // Ads
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                padding: const EdgeInsets.symmetric(vertical: 15),
                color: const Color.fromARGB(255, 59, 59, 59),
                child: const Center(child: Text("Ads")),
              ),

              // PlayList Cover Page
              Row(
                children: [
                  Hero(
                    tag: widget.song,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: widget.song == "Favorite"
                                ? [
                                    Color.fromARGB(149, 95, 23, 23),
                                    Color.fromARGB(204, 195, 46, 46),
                                  ]
                                : [
                                    Color.fromARGB(80, 45, 38, 117),
                                    Color.fromRGBO(121, 46, 195, 1),
                                  ],
                          )),
                      child: Center(
                        child: Icon(
                          widget.song == "Favorite"
                              ? Icons.favorite
                              : Icons.download_outlined,
                          color: widget.song == "Favorite"
                              ? Colors.red
                              : Color.fromRGBO(126, 69, 161, 1),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                          tag: "name${widget.song}",
                          child: Text(
                            widget.song,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w600),
                          )),
                      const Text(
                        "50 audios files",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
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
