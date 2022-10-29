import 'package:flutter/material.dart';
import 'package:wavsound/classes/colors.dart';

class RecBoxList extends StatelessWidget {
  const RecBoxList(
      {Key? key, required this.image, required this.title, this.onTap})
      : super(key: key);
  final String image;
  final String title;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.cover)),
          ),
          Text(
            title,
            style: const TextStyle(
                color: AppColors.primaryTextColor,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          )
        ]),
      ),
    );
  }
}
