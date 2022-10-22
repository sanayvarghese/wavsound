import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wavsound/constants/colors.dart';
import 'package:wavsound/pages/playlist.dart';

class LibItem extends StatelessWidget {
  const LibItem(
      {Key? key,
      required this.song,
      required this.img,
      required this.isPlaylist,
      this.onTap})
      : super(key: key);
  final String song;
  final String img;
  final bool isPlaylist;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isPlaylist) {
          Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) => PlayList(
              song: song,
              onTap: onTap,
            ),
          ));
        } else {
          onTap!();
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        // padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  isPlaylist
                      ? Hero(
                          tag: song,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: song == "Favorite"
                                      ? [
                                          const Color.fromARGB(149, 95, 23, 23),
                                          const Color.fromARGB(
                                              204, 195, 46, 46),
                                        ]
                                      : [
                                          const Color.fromARGB(80, 45, 38, 117),
                                          const Color.fromRGBO(121, 46, 195, 1),
                                        ],
                                )),
                            child: Center(
                              child: Icon(
                                song == "Favorite"
                                    ? Icons.favorite
                                    : Icons.download_outlined,
                                color: song == "Favorite"
                                    ? Colors.red
                                    : const Color.fromRGBO(126, 69, 161, 1),
                              ),
                            ),
                          ),
                        )
                      : Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              image: DecorationImage(
                                  image: AssetImage(img), fit: BoxFit.cover)),
                        ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Hero(
                      tag: "name$song",
                      child: Text(
                        song,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            isPlaylist
                ? const SizedBox()
                : IconButton(
                    onPressed: onTap,
                    icon: const Icon(
                      Icons.play_circle_fill,
                      color: AppColors.secondaryColor,
                      size: 35,
                    ))
          ],
        ),
      ),
    );
  }
}
