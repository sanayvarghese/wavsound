import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:wavsound/classes/colors.dart';

class NowPlaying extends StatefulWidget {
  const NowPlaying({Key? key}) : super(key: key);

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  var isFav = false;
  onLike(isLiked) {
    setState(() {
      isFav = !isLiked;
    });
  }

  var isRepeat = false;
  onRepeat() {
    setState(() {
      isRepeat = !isRepeat;
    });
  }

  var volume = 0;

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
                    const Text("Now Playing",
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.primaryTextColor,
                        )),
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
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                            image: AssetImage("assets/img/raining.jpg"),
                            fit: BoxFit.cover)),
                  ),
                  // Time Bar
                  Container(
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
                                  color: AppColors.dimTextColor, fontSize: 15),
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

                  // Music Manager
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Raining",
                            style: TextStyle(
                                color: AppColors.dimTextColor, fontSize: 25),
                          ),
                          Text(
                            "Source: In App",
                            style: TextStyle(
                                color: AppColors.primaryTextColor,
                                fontSize: 13),
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: onRepeat,
                        icon: const Icon(
                          Icons.repeat,
                        ),
                        iconSize: 32,
                        color: isRepeat
                            ? AppColors.secondaryColor
                            : AppColors.iconColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      LikeButton(
                        onTap: ((isLiked) async {
                          onLike(isLiked);
                          return !isLiked;
                        }),
                        isLiked: isFav,
                        likeBuilder: (isLiked) {
                          return Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked ? Colors.red : AppColors.iconColor,
                            size: 28,
                          );
                        },
                      ),
                    ],
                  ),

                  // Volume Controller
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            if (volume >= 10) {
                              setState(() {
                                volume -= 10;
                              });
                            }
                          },
                          icon: const Icon(
                            Icons.volume_down,
                          ),
                          iconSize: 32,
                          color: AppColors.iconColor,
                        ),
                        Expanded(
                            child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 5.0),
                            overlayShape: const RoundSliderOverlayShape(
                                overlayRadius: 15),
                            trackHeight: 1.5,
                          ),
                          child: Slider(
                              value: volume.toDouble(),
                              min: 0,
                              max: 100,
                              activeColor:
                                  const Color.fromRGBO(220, 219, 219, 1),
                              inactiveColor:
                                  const Color.fromRGBO(75, 75, 75, 1),
                              label: 'Set volume value',
                              onChanged: (double newValue) {
                                setState(() {
                                  volume = newValue.round();
                                });
                              },
                              semanticFormatterCallback: (double newValue) {
                                return '${newValue.round()} dollars';
                              }),
                        )),
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            if (volume <= 90) {
                              setState(() {
                                volume += 10;
                              });
                            }
                          },
                          icon: const Icon(
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
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {},
                        icon: const Icon(
                          Icons.replay_10,
                        ),
                        iconSize: 50,
                        color: AppColors.primaryTextColor,
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {},
                        icon: const Icon(
                          Icons.play_circle,
                        ),
                        iconSize: 70,
                        color: AppColors.primaryTextColor,
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {},
                        icon: const Icon(
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
