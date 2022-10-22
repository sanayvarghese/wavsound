import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:wavsound/constants/colors.dart';

class CustomNavBarWidget extends StatelessWidget {
  const CustomNavBarWidget({
    Key? key,
    required this.selectedIndex,
    required this.items,
    required this.onItemSelected,
  }) : super(key: key);
  final int selectedIndex;
  final List<PersistentBottomNavBarItem> items;
  final ValueChanged<int> onItemSelected;

  Widget _buildItem(PersistentBottomNavBarItem item, bool isSelected) {
    return Container(
      alignment: Alignment.center,
      height: 60.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: IconTheme(
              data: IconThemeData(
                  size: 26.0,
                  color: isSelected
                      ? (item.activeColorSecondary ?? item.activeColorPrimary)
                      : item.inactiveColorPrimary ?? item.activeColorPrimary),
              child: item.icon,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Material(
              type: MaterialType.transparency,
              child: FittedBox(
                  child: Text(
                item.title ?? "ss",
                style: TextStyle(
                    color: isSelected
                        ? (item.activeColorSecondary ?? item.activeColorPrimary)
                        : item.inactiveColorPrimary,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0),
              )),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(top: 100),
      color: AppColors.primaryColor,
      width: double.infinity,
      height: 60.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) {
          int index = items.indexOf(item);
          return Expanded(
            child: GestureDetector(
              onTap: () {
                onItemSelected(index);
              },
              child: _buildItem(item, selectedIndex == index),
            ),
          );
        }).toList(),
      ),
    );
  }
}
