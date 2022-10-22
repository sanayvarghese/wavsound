import 'package:flutter/material.dart';
import 'package:wavsound/colors.dart';

class SubHeader extends StatelessWidget {
  const SubHeader({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
                color: AppColors.dimTextColor, fontWeight: FontWeight.w600),
          ),
          // IconButton(
          //   padding: EdgeInsets.zero,
          //   constraints: const BoxConstraints(),
          //   onPressed: (() {}),
          //   icon: const Icon(Icons.add),
          //   iconSize: 28,
          //   color: AppColors.iconColor,
          // )
        ],
      ),
    );
  }
}
