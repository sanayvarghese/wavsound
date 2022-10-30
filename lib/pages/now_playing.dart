import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:like_button/like_button.dart';
import 'package:marquee/marquee.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:wavsound/classes/colors.dart';
import 'package:wavsound/classes/player.dart';
import 'package:wavsound/components/time_item.dart';
import 'package:wavsound/functions/player.dart';
import 'package:wavsound/functions/shared_pref.dart';

class NowPlaying extends StatefulWidget {
  const NowPlaying({Key? key}) : super(key: key);

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  PlayingSound nowPlaying = PlayingSound(
      "song",
      "https://sanayvarghese.tk/images/wavsounds/raining.jpg",
      "",
      false,
      false,
      1,
      "");

  // bool playing = false;
  void newDataGeter() {
    StreamingSharedPreferences pref = SharePrefFunc.pref;
    Preference<String> nowPlayingData =
        pref.getString("nowPlaying", defaultValue: "");

    // PlayerFunc.player.playingStream.listen((event) {
    //   if (mounted) {
    //     setState(() {
    //       playing = event;
    //     });
    //   }
    // });

    nowPlayingData.listen((value) {
      Map<String, dynamic> decodedData = json.decode(value);
      var song = decodedData['song'] ?? "";
      var image = decodedData['image'] ?? "";
      var url = decodedData['url'] ?? "";
      var paused = decodedData['paused'] ?? false;
      var loop = decodedData['loop'] ?? true;
      var timer = decodedData['timer'] ?? 0;
      var source = decodedData['source'] ?? "";
      var newNowPlaying =
          PlayingSound(song, image, url, paused, loop, timer, source);
      if (mounted) {
        setState(() {
          nowPlaying = newNowPlaying;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    newDataGeter();
  }

  @override
  void dispose() {
    super.dispose();
    newDataGeter();
  }

  var isRepeat = false;
  onRepeat() {
    setState(() {
      isRepeat = !isRepeat;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(children: [
              // Header
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_down_sharp,
                      ),
                      iconSize: 40,
                      color: AppColors.iconColor,
                    ),
                    Column(
                      children: [
                        const Text("Now Playing",
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColors.primaryTextColor,
                            )),
                        Text(
                          "Source: ${nowPlaying.source}",
                          style: const TextStyle(
                              color: AppColors.dimTextColor, fontSize: 8),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    )
                  ]),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: MediaQuery.of(context).size.height / 2.5,
                    margin: const EdgeInsets.only(bottom: 30, top: 30),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                            image: NetworkImage(nowPlaying.image),
                            fit: BoxFit.cover)),
                  ),
                  // Time Bar
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: AppColors.primaryColor,
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25.0),
                          ),
                        ),
                        builder: (context) {
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Center(
                                      child: Text(
                                    "Stop sound in",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TimeItem(
                                    time: 5,
                                    timePrefix: "minutes",
                                  ),
                                  TimeItem(
                                    time: 15,
                                    timePrefix: "minutes",
                                  ),
                                  TimeItem(
                                    time: 30,
                                    timePrefix: "minutes",
                                  ),
                                  TimeItem(
                                    time: 1,
                                    timePrefix: "hour",
                                  ),
                                  TimeItem(
                                    time: 4,
                                    timePrefix: "hour",
                                  ),
                                  TimeItem(
                                    time: 8,
                                    timePrefix: "hour",
                                  ),
                                  TimeItem(
                                    timePrefix: "End of Track",
                                  ),
                                ]),
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              // Time
                              Text(
                                "Stops in 30min",
                                style: TextStyle(
                                    color: AppColors.dimTextColor,
                                    fontSize: 15),
                              ),
                              Text(
                                "9:20 am",
                                style: TextStyle(
                                    color: AppColors.primaryTextColor,
                                    fontSize: 13),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text("30 min",
                                  style: TextStyle(fontSize: 24)),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.timer_outlined,
                                  color: AppColors.blueColor,
                                ),
                                iconSize: 32,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),

                  // Music Manager
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SoundTitle(context, nowPlaying.song),
                      const SizedBox(
                        width: 30,
                      ),
                      Row(
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: onRepeat,
                            icon: isRepeat
                                ? const Icon(
                                    Icons.download_done_rounded,
                                  )
                                : const Icon(
                                    Icons.downloading_outlined,
                                  ),
                            iconSize: 32,
                            color: isRepeat
                                ? Color.fromARGB(255, 38, 187, 50)
                                : AppColors.iconColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          LikeButton(
                            onTap: ((isLiked) async {
                              SharePrefFunc.updateLike(nowPlaying.song);
                              return !isLiked;
                            }),
                            isLiked:
                                SharePrefFunc.checkIsLiked(nowPlaying.song),
                            likeBuilder: (isLiked) {
                              return Icon(
                                isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color:
                                    isLiked ? Colors.red : AppColors.iconColor,
                                size: 28,
                              );
                            },
                          ),
                        ],
                      ),
                      // Spacer(),
                    ],
                  ),

                  // Volume Controller
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          onPressed: PlayerFunc.decVolume,
                          icon: Icon(
                            Icons.volume_down,
                          ),
                          iconSize: 32,
                          color: AppColors.iconColor,
                        ),
                        StreamBuilder<double>(
                            stream: PlayerFunc.player.volumeStream,
                            builder: (context, snapshot) {
                              return Expanded(
                                  child: SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                        thumbShape: const RoundSliderThumbShape(
                                            enabledThumbRadius: 5.0),
                                        overlayShape:
                                            const RoundSliderOverlayShape(
                                                overlayRadius: 15),
                                        trackHeight: 1.5,
                                      ),
                                      child: Slider(
                                        value: snapshot.data != null
                                            ? snapshot.data! * 100
                                            : 100,
                                        min: 0,
                                        max: 100,
                                        activeColor: const Color.fromRGBO(
                                            220, 219, 219, 1),
                                        inactiveColor:
                                            const Color.fromRGBO(75, 75, 75, 1),
                                        label: 'Set volume value',
                                        onChanged: PlayerFunc.setVolume,
                                      )));
                            }),
                        const IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          onPressed: PlayerFunc.incVolume,
                          icon: Icon(
                            Icons.volume_up,
                          ),
                          iconSize: 32,
                          color: AppColors.iconColor,
                        ),
                      ],
                    ),
                  ),

                  // PlayBack Controlles
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        onPressed: PlayerFunc.rewind,
                        icon: Icon(
                          Icons.replay_10,
                        ),
                        iconSize: 50,
                        color: AppColors.primaryTextColor,
                      ),
                      StreamBuilder<PlayerState>(
                        stream: PlayerFunc.player.playerStateStream,
                        builder: (context, snapshot) {
                          final playerState = snapshot.data;
                          final processingState = playerState?.processingState;
                          final playing = playerState?.playing;
                          if (processingState == ProcessingState.loading ||
                              processingState == ProcessingState.buffering) {
                            return Container(
                              margin: const EdgeInsets.all(8.0),
                              width: 60.0,
                              height: 60.0,
                              child: const CircularProgressIndicator(),
                            );
                          } else if (playing != true) {
                            return IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: PlayerFunc.player.play,
                              icon: const Icon(
                                Icons.play_circle,
                              ),
                              iconSize: 70,
                              color: AppColors.primaryTextColor,
                            );
                          } else if (processingState !=
                              ProcessingState.completed) {
                            return IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: PlayerFunc.player.pause,
                              icon: const Icon(
                                Icons.pause_circle,
                              ),
                              iconSize: 70,
                              color: AppColors.primaryTextColor,
                            );
                          } else {
                            return IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: () =>
                                  PlayerFunc.player.seek(Duration.zero),
                              icon: const Icon(
                                Icons.replay,
                              ),
                              iconSize: 70,
                              color: AppColors.primaryTextColor,
                            );
                          }
                        },
                      ),
                      const IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        onPressed: PlayerFunc.skip,
                        icon: Icon(
                          Icons.forward_10,
                        ),
                        iconSize: 50,
                        color: AppColors.primaryTextColor,
                      ),
                    ],
                  )
                ]),
              ),

              // Ads
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                padding: const EdgeInsets.symmetric(vertical: 15),
                color: const Color.fromARGB(255, 59, 59, 59),
                child: const Center(child: Text("Ads")),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

Widget SoundTitle(context, String song) {
  return song.length > 18
      ? Expanded(
          child: Container(
              height: 30,
              width: 50,
              child: Marquee(
                text: song,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                scrollAxis: Axis.horizontal, //scroll direction
                crossAxisAlignment: CrossAxisAlignment.start,
                blankSpace: 30.0,
                velocity: 50.0, //speed
                pauseAfterRound: const Duration(seconds: 4),
                startPadding: 10.0,
                accelerationDuration: const Duration(seconds: 1),
                accelerationCurve: Curves.linear,
                decelerationDuration: const Duration(milliseconds: 500),
                decelerationCurve: Curves.easeOut,
              )),
        )
      : Text(
          song,
          style: TextStyle(color: AppColors.dimTextColor, fontSize: 25),
        );
}
