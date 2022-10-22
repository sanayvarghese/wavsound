import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wavsound/colors.dart';
import 'package:wavsound/components/now_playing_widget.dart';
import 'package:wavsound/pages/now_playing.dart';
import 'package:wavsound/pages/settings.dart';
import 'package:wavsound/pages/home.dart';
import 'package:wavsound/pages/library.dart';
import 'package:wavsound/utils/custom_navigation.dart';

class PersistentBottomBarScaffold extends StatefulWidget {
  const PersistentBottomBarScaffold({
    Key? key,
  }) : super(key: key);

  @override
  _PersistentBottomBarScaffoldState createState() =>
      _PersistentBottomBarScaffoldState();
}

class _PersistentBottomBarScaffoldState
    extends State<PersistentBottomBarScaffold> {
  static Route<void> _myRouteBuilder(BuildContext context, Object? arguments) {
    return MaterialPageRoute<void>(
      builder: (BuildContext context) => const Settings(),
    );
  }

  int _selectedTab = 0;
  var favorite = false;
  var playing = false;
  var nowplaying = true;
  onTap() {
    Navigator.of(context).push(CustomPageRoute(child: const NowPlaying()));
  }

  final _tab1navigatorKey = GlobalKey<NavigatorState>();
  final _tab2navigatorKey = GlobalKey<NavigatorState>();
  final _tab3navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    List<PersistentTabItem> items = [
      PersistentTabItem(
        tab: Home(
          onTap: onTap,
        ),
        icon: Icons.home_outlined,
        title: 'Home',
        navigatorkey: _tab1navigatorKey,
      ),
      PersistentTabItem(
        tab: Library(
          onTap: onTap,
        ),
        icon: Icons.library_music_outlined,
        title: 'Search',
        navigatorkey: _tab2navigatorKey,
      ),
      PersistentTabItem(
        tab: const Settings(),
        icon: Icons.settings_outlined,
        title: 'Settings',
        navigatorkey: _tab3navigatorKey,
      ),
    ];

    return WillPopScope(
      onWillPop: () async {
        /// Check if curent tab can be popped
        if (items[_selectedTab].navigatorkey?.currentState?.canPop() ?? false) {
          items[_selectedTab].navigatorkey?.currentState?.pop();
          return false;
        } else {
          if (_selectedTab != 0) {
            setState(() {
              _selectedTab = 0;
            });
            items[_selectedTab]
                .navigatorkey
                ?.currentState
                ?.popUntil((route) => route.isFirst);
            return false;
          } else {
            return true;
          }
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: _selectedTab,
          children: items
              .map((page) => HeroControllerScope(
                    controller: MaterialApp.createMaterialHeroController(),
                    child: Navigator(
                      key: page.navigatorkey,
                      onGenerateInitialRoutes: (navigator, initialRoute) {
                        return [
                          MaterialPageRoute(builder: (context) => page.tab)
                        ];
                      },
                    ),
                  ))
              .toList(),
        ),

        /// Define the persistent bottom bar
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            NowPlayingWidget(
              onTap: onTap,
              nowplaying: nowplaying,
              favorite: favorite,
              playing: playing,
              likeTap: (isLiked) {
                setState(() {
                  favorite = !isLiked;
                });
              },
              playTap: () {
                setState(() {
                  playing = !playing;
                });
              },
            ),
            BottomNavigationBar(
              currentIndex: _selectedTab,
              backgroundColor: AppColors.primaryColor,
              unselectedItemColor: AppColors.iconColor,
              selectedItemColor: AppColors.secondaryColor,
              onTap: (index) {
                /// Check if the tab that the user is pressing is currently selected
                if (index == _selectedTab) {
                  /// if you want to pop the current tab to its root then use
                  items[index]
                      .navigatorkey
                      ?.currentState
                      ?.popUntil((route) => route.isFirst);
                  print("ontap 57 ${_selectedTab}");

                  /// if you want to pop the current tab to its last page
                  /// then use
                  // widget.items[index].navigatorkey?.currentState?.pop();
                } else {
                  setState(() {
                    _selectedTab = index;
                  });
                }
              },
              items: items
                  .map((item) => BottomNavigationBarItem(
                      icon: Icon(item.icon), label: item.title))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

/// Model class that holds the tab info for the [PersistentBottomBarScaffold]
class PersistentTabItem {
  final Widget tab;
  final GlobalKey<NavigatorState>? navigatorkey;
  final String title;
  final IconData icon;

  PersistentTabItem(
      {required this.tab,
      this.navigatorkey,
      required this.title,
      required this.icon});
}
