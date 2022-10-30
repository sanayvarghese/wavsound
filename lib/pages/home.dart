import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wavsound/classes/colors.dart';
import 'package:wavsound/components/rec_list.dart';
import 'package:wavsound/components/sub_header_home.dart';
import 'package:wavsound/functions/player.dart';
import 'package:wavsound/pages/playlist.dart';
import 'package:wavsound/pages/settings.dart';
import 'package:wavsound/pages/sound_import.dart';
import 'package:wavsound/pages/sound_stream.dart';

class Home extends StatefulWidget {
  const Home({Key? key, this.onTap}) : super(key: key);
  final Function()? onTap;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void changeNowPlaying(song) {
    Map<String, dynamic> data = {
      "song": song["song"],
      "image": song["image"],
      "url": song["url"],
      "paused": false,
      "timer": 1800,
      "source": song["source"],
    };
    PlayerFunc.onNewSongClick(data, widget.onTap);
  }

  List<Map<String, dynamic>> topSongs = [
    {
      "song": "Raining",
      "image": "https://sanayvarghese.tk/images/wavsounds/raining.jpg",
      "url":
          "https://github.com/sanayvarghese/portfolio_v3/blob/main/public/images/wavsounds/rain.mp3?raw=true",
      "source": "In App",
    },
    {
      "song": "Thunder",
      "image": "https://sanayvarghese.tk/images/wavsounds/thunder.jpg",
      "url":
          "https://samples.audible.com/or/orig/000937/or_orig_000937_sample.mp3",
      "source": "In App",
    },
    {
      "song": "Snow Fall",
      "image": "https://sanayvarghese.tk/images/wavsounds/snow.jpg",
      "url":
          "https://github.com/sanayvarghese/portfolio_v3/blob/main/public/images/wavsounds/rain.mp3?raw=true",
      "source": "In App",
    },
    {
      "song": "Night Forest",
      "image": "https://sanayvarghese.tk/images/wavsounds/nightforest.jpg",
      "url":
          "https://github.com/sanayvarghese/portfolio_v3/blob/main/public/images/wavsounds/rain.mp3?raw=true",
      "source": "In App",
    },
  ];

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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Good Morning",
                        style: TextStyle(
                            fontSize: 20, color: AppColors.primaryTextColor)),
                    Text("Sanay George Varghese",
                        style: TextStyle(
                            fontSize: 15, color: AppColors.dimTextColor))
                  ],
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) => const Settings()));
                  },
                  icon: const Icon(Icons.settings_outlined),
                  iconSize: 40,
                  color: AppColors.iconColor,
                )
              ]),

              // Ads
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                padding: const EdgeInsets.symmetric(vertical: 15),
                color: const Color.fromARGB(255, 59, 59, 59),
                child: const Center(child: Text("Ads")),
              ),

              // Home Bar
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                margin: const EdgeInsets.symmetric(vertical: 15),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.darkBlueColor,
                          Color.fromARGB(151, 25, 19, 63)
                        ])),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        // Time
                        Text(
                          "9:20 am",
                          style: TextStyle(
                              color: AppColors.primaryTextColor, fontSize: 22),
                        ),
                        Text(
                          "Currently Playing",
                          style: TextStyle(
                              color: AppColors.dimTextColor, fontSize: 14),
                        ),
                        Text(
                          "Stops in 30min",
                          style: TextStyle(
                              color: AppColors.dimTextColor, fontSize: 13),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              // Import Audios
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(CupertinoPageRoute(
                      builder: ((context) => SoundImport())));
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 0, 0, 0),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
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
              ),

              // Stream Play
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(CupertinoPageRoute(
                      builder: ((context) => SoundStream())));
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 0, 0, 0),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
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
              ),

              // Playlist Header
              const SubHeader(title: "Playlists"),

              // PlayList
              GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3.5,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 20),
                children: [
                  GestureDetector(
                    onTap: (() {
                      Navigator.of(context, rootNavigator: true)
                          .push(CupertinoPageRoute(
                              builder: (context) => const PlayList(
                                    song: "Favorite",
                                  )));
                    }),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 32, 32, 32),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Row(children: [
                        Container(
                          width: 50,
                          height: 50,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color.fromARGB(204, 195, 46, 46),
                                    Color.fromARGB(150, 63, 19, 19)
                                  ])),
                          child: const Center(
                            child: Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        const Text(
                          "Favourites",
                          style: TextStyle(
                              color: AppColors.primaryTextColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )
                      ]),
                    ),
                  ),
                  GestureDetector(
                    onTap: (() {
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) => const PlayList(
                                song: "Downloads",
                              )));
                    }),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 32, 32, 32),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Row(children: [
                        Container(
                          width: 50,
                          height: 50,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color.fromRGBO(121, 46, 195, 1),
                                    Color.fromRGBO(58, 46, 195, 0),
                                  ])),
                          child: const Center(
                            child: Icon(
                              Icons.download,
                              color: Color.fromRGBO(126, 69, 161, 1),
                            ),
                          ),
                        ),
                        const Text(
                          "Downloads",
                          style: TextStyle(
                              color: AppColors.primaryTextColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )
                      ]),
                    ),
                  ),
                ],
              ),

              // TopSongs Header
              const SubHeader(title: "Top Sounds"),

              GridView.builder(
                  shrinkWrap: true,
                  itemCount: topSongs.length,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3.5,
                      crossAxisSpacing: 30,
                      mainAxisSpacing: 30),
                  itemBuilder: (context, index) {
                    return RecBoxList(
                        image: topSongs[index]["image"],
                        title: topSongs[index]["song"],
                        onTap: () {
                          changeNowPlaying(topSongs[index]);
                        });
                  }),
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
