import 'package:flutter/cupertino.dart'
    hide CupertinoTabBar, CupertinoTabScaffold, CupertinoTabController;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peanut_app/features/home/presentation/screens/home_screen.dart';
import 'package:peanut_app/core/constants/colors.dart';
import 'package:peanut_app/core/helpers/feedback_helper.dart';
import 'package:peanut_app/core/packages/custom_bottom_tab_bar.dart';
import 'package:peanut_app/core/packages/custom_tab_scaffold.dart';

import '../../../profile/presentation/pages/profile_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key, this.tabIndex = 0}) : super(key: key);

  final int tabIndex;

  @override
  Widget build(BuildContext context) {

    CupertinoTabController tabController =
        CupertinoTabController(initialIndex: tabIndex);

    DateTime? currentBackPressTime;

    final GlobalKey<NavigatorState> homeTabNavKey = GlobalKey<NavigatorState>();
    final GlobalKey<NavigatorState> jobListTabNavKey =
        GlobalKey<NavigatorState>();
    final GlobalKey<NavigatorState> chatTabNavKey = GlobalKey<NavigatorState>();
    final GlobalKey<NavigatorState> profileTabNavKey =
        GlobalKey<NavigatorState>();

    final listOfKeys = [
      homeTabNavKey,
      jobListTabNavKey,
      chatTabNavKey,
      profileTabNavKey
    ];

    return WillPopScope(
      onWillPop: () async {
        if (!await listOfKeys[tabController.index].currentState!.maybePop()) {
          if (tabController.index == 0) {
            DateTime now = DateTime.now();
            if (currentBackPressTime == null ||
                now.difference(currentBackPressTime!) >
                    const Duration(seconds: 2)) {
              currentBackPressTime = now;
              // ignore: use_build_context_synchronously
              FeedBackHelper.showSnackBar(
                context: context,
                title: 'Tap again to exit',
                type: FeedbackType.info,
              );
              return Future.value(false);
            }
            return Future.value(true);
          } else {
            tabController.index = 0;
            return false;
          }
        } else {
          return false;
        }
      },
      child: CupertinoTabScaffold(
        controller: tabController,
        tabBar: CupertinoTabBar(
            height: 60,
            backgroundColor: kWhiteColor,
            onTap: (value) {},
            activeColor: Colors.black,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  transform: Matrix4.translationValues(0, 5, 0),
                  child: SvgPicture.asset(
                    'assets/icons/home_outline.svg',
                    color: Colors.black,
                  ),
                ),
                activeIcon: Container(
                  transform: Matrix4.translationValues(0, 5, 0),
                  child: SvgPicture.asset(
                    'assets/icons/home.svg',
                    color: Colors.black,
                  ),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  transform: Matrix4.translationValues(0, 5, 0),
                  child: SvgPicture.asset(
                    'assets/icons/profile_outline.svg',
                    color: Colors.black,
                  ),
                ),
                activeIcon: Container(
                  transform: Matrix4.translationValues(0, 5, 0),
                  child: SvgPicture.asset(
                    'assets/icons/profile.svg',
                    color: Colors.black,
                  ),
                ),
                label: 'Profile',
              ),
            ]),
        tabBuilder: ((context, index) {
          switch (index) {
            case 0:
              return CupertinoTabView(
                navigatorKey: listOfKeys[index],
                builder: ((context) {
                  return CupertinoPageScaffold(child: HomeScreen());
                }),
              );
            case 1:
              return CupertinoTabView(
                navigatorKey: listOfKeys[index],
                builder: ((context) {
                  return const CupertinoPageScaffold(child: ProfileScreen());
                }),
              );
          }
          return Container();
        }),
      ),
    );
  }
}
