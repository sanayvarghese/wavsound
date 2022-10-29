import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:wavsound/classes/colors.dart';
import 'package:wavsound/components/now_playing_widget.dart';
import 'package:wavsound/classes/persistent_tab_item.dart';
import 'package:wavsound/pages/now_playing.dart';
import 'package:wavsound/pages/settings.dart';
import 'package:wavsound/pages/home.dart';
import 'package:wavsound/pages/library.dart';
import 'package:wavsound/pages/share_list.dart';
import 'package:wavsound/utils/custom_navigation.dart';

class PersistentBottomBarScaffold extends StatefulWidget {
  const PersistentBottomBarScaffold({
    Key? key,
  }) : super(key: key);

  @override
  PersistentBottomBarScaffoldState createState() =>
      PersistentBottomBarScaffoldState();
}

class PersistentBottomBarScaffoldState
    extends State<PersistentBottomBarScaffold> {
  // Variables
  int _selectedTab = 0;
  var favorite = false;
  var playing = false;
  var nowplaying = true;

  openNowPlaying() {
    Navigator.of(context).push(CustomPageRoute(child: const NowPlaying()));
  }

  // Global Keys
  final _tab1navigatorKey = GlobalKey<NavigatorState>();
  final _tab2navigatorKey = GlobalKey<NavigatorState>();
  final _tab3navigatorKey = GlobalKey<NavigatorState>();

// //All listeners to listen Sharing media files & text
  void listenShareMediaFiles(BuildContext context) {
    // For sharing images coming from outside the app
    // while the app is in the memory
    ReceiveSharingIntent.getMediaStream().listen((List<SharedMediaFile> value) {
      navigateToShareMedia(context, value);
    }, onError: (err) {
      debugPrint("$err");
    });

    // For sharing images coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialMedia().then((List<SharedMediaFile> value) {
      navigateToShareMedia(context, value);
    });

    // For sharing or opening urls/text coming from outside the app while the app is in the memory
    ReceiveSharingIntent.getTextStream().listen((String value) {
      navigateToShareText(context, value);
    }, onError: (err) {
      debugPrint("$err");
    });

    // For sharing or opening urls/text coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialText().then((String? value) {
      navigateToShareText(context, value);
    });
  }

  void navigateToShareMedia(BuildContext context, List<SharedMediaFile> value) {
    if (value.isNotEmpty) {
      var newFiles = value.first;
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ShareListingScreen(
                file: newFiles,
                text: "",
              )));
    }
  }

  void navigateToShareText(BuildContext context, String? value) {
    if (value != null && value.toString().isNotEmpty) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ShareListingScreen(
                text: value,
                file: null,
              )));
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      listenShareMediaFiles(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<PersistentTabItem> items = [
      PersistentTabItem(
        tab: Home(
          onTap: openNowPlaying,
        ),
        icon: Icons.home_outlined,
        title: 'Home',
        navigatorkey: _tab1navigatorKey,
      ),
      PersistentTabItem(
        tab: Library(
          onTap: openNowPlaying,
        ),
        icon: Icons.library_music_outlined,
        title: 'Library',
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
              onTap: openNowPlaying,
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
