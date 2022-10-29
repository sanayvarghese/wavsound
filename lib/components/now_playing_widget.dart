import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:like_button/like_button.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:wavsound/classes/colors.dart';
import 'package:wavsound/classes/player.dart';
import 'package:wavsound/functions/player.dart';
import 'package:wavsound/functions/shared_pref.dart';

class NowPlayingWidget extends StatefulWidget {
  const NowPlayingWidget(
      {Key? key,
      this.onTap,
      required this.favorite,
      required this.playing,
      required this.nowplaying,
      required this.likeTap,
      this.playTap})
      : super(key: key);
  final Function()? onTap;
  final Function(bool) likeTap;
  final Function()? playTap;
  final bool favorite;
  final bool playing;
  final bool nowplaying;
  @override
  State<NowPlayingWidget> createState() => _NowPlayingWidgetState();
}

class _NowPlayingWidgetState extends State<NowPlayingWidget> {
  PlayingSound nowPlaying = PlayingSound(
      "song",
      "https://sanayvarghese.tk/images/wavsounds/raining.jpg",
      "",
      false,
      false,
      1,
      "");

  bool playing = false;
  void newDataGeter() {
    StreamingSharedPreferences pref = Get.find();
    Preference<String> nowPlayingData =
        pref.getString("nowPlaying", defaultValue: "");

    PlayerFunc.player.playingStream.listen((event) {
      setState(() {
        playing = event;
      });
    });

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
      setState(() {
        nowPlaying = newNowPlaying;
      });
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

  @override
  Widget build(BuildContext context) {
    return widget.nowplaying
        ? Material(
            child: GestureDetector(
              onTap: widget.onTap,
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0,
                    ),
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 33,
                            height: 29,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                image: DecorationImage(
                                    image: NetworkImage(nowPlaying.image),
                                    fit: BoxFit.cover)),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                nowPlaying.song,
                                style: const TextStyle(
                                    color: AppColors.primaryTextColor,
                                    fontSize: 18),
                              ),
                              Text(
                                "Source: ${nowPlaying.source}",
                                style: const TextStyle(
                                    color: AppColors.dimTextColor,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          // Like Button
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

                          const SizedBox(width: 10),

                          // Play/Pause Button

                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () {
                              if (playing) {
                                PlayerFunc.player.stop();
                              } else {
                                PlayerFunc.player.play();
                              }
                            },
                            icon: playing
                                ? const Icon(Icons.pause)
                                : const Icon(Icons.play_arrow_sharp),
                            iconSize: 33,
                            color: AppColors.iconColor,
                          )
                        ],
                      )
                    ],
                  )),
            ),
          )
        : const SizedBox();
  }
}
