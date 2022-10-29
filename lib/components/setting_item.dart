import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  /// Title of the Setting
  final String title;

  /// Discription of the Setting
  final String? discription;

  /// onClick function for Setting
  final Function()? onTap;

  /// Wiget for on right side of the setting
  final Widget? sideButton;
  const SettingItem({
    Key? key,
    required this.title,
    this.discription,
    this.onTap,
    this.sideButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Name and Discription
              Container(
                width: sideButton != null
                    ? MediaQuery.of(context).size.width / 1.5
                    : MediaQuery.of(context).size.height * 0.45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w300),
                    ),
                    if (discription != null)
                      Text(
                        discription.toString(),
                        overflow:
                            sideButton != null ? TextOverflow.ellipsis : null,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: Color.fromARGB(155, 233, 233, 233)),
                      )
                  ],
                ),
              ),
              const Spacer(),
              // Side Button
              if (sideButton != null) sideButton!
            ],
          ),
        ),
      ),
    );
  }
}
