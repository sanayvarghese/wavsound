import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:wavsound/constants/colors.dart';

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
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                image: DecorationImage(
                                    image: AssetImage("assets/img/raining.jpg"),
                                    fit: BoxFit.cover)),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Raining",
                                style: TextStyle(
                                    color: AppColors.primaryTextColor,
                                    fontSize: 18),
                              ),
                              Text(
                                "Source: InApp",
                                style: TextStyle(
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
                              widget.likeTap(isLiked);
                              return !isLiked;
                            }),
                            isLiked: widget.favorite,
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
                            onPressed: widget.playTap,
                            icon: widget.playing
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
