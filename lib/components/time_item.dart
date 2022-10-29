import 'package:flutter/cupertino.dart';
import 'package:wavsound/classes/colors.dart';

class TimeItem extends StatelessWidget {
  final int time;
  final String timePrefix;
  const TimeItem({Key? key, required this.time, required this.timePrefix})
      : super(key: key);

  void fireAlarm() {
    print("Date ${DateTime.now()}");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 25),
        color: AppColors.navColor,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [Text("${time.toString()} $timePrefix")]),
      ),
    );
  }
}
