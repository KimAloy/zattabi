import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zattabi/config/config.dart';
import 'package:zattabi/screens/authenticate/authenticate.dart';
import 'package:zattabi/screens/screens.dart';
import 'package:zattabi/widgets/widgets.dart';

class NavigationItems extends StatelessWidget {
  final Color? searchColor;
  final Color? postColor;
  final Color? watchlistColor;
  final Color? myZattabiColor;
  final bool showSearchIcon;
  final bool showGoToHomeScreenIcon;
  final bool goToAdvertiseScreenOnTap;
  final bool goToWatchlistScreenOnTap;
  final bool goToMyZattabiMyAdvertsScreenOnTap;

  const NavigationItems({
    Key? key,
    this.searchColor,
    this.postColor,
    this.watchlistColor,
    this.myZattabiColor,
    this.showSearchIcon = true,
    this.showGoToHomeScreenIcon = true,
    this.goToAdvertiseScreenOnTap = true,
    this.goToWatchlistScreenOnTap = true,
    this.goToMyZattabiMyAdvertsScreenOnTap = true,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            showGoToHomeScreenIcon == false
                ? Container(width: 30)
                : Material(
                    color: Colors.transparent,
                    child: InkWell(
                        splashColor: kColorThree,
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: kColorOne,
                              width: 1,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              'Ztb',
                              style: TextStyle(
                                color: kColorOne,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        onTap: () => Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return HomeScreen();
                            }))),
                  ),
            showSearchIcon == false
                ? Container(width: 60)
                : NavigationModel(
                    color: searchColor == null ? Colors.white : searchColor,
                    icon: Icons.search,
                    text: 'Search',
                    onTap: () => showSearch(
                        context: context, delegate: SearchDelegateWidget()),
                  ),
            NavigationModel(
                color: postColor == null ? Colors.white : postColor,
                icon: Icons.add_box_outlined,
                text: 'Advertise',
                onTap: goToAdvertiseScreenOnTap == false
                    ? () => null
                    : () =>
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          // return AdvertiseScreen();
                          return WrapperAdvertiseScreen();
                        }))),
            WatchlistNavigationWidget(
                color: watchlistColor == null ? Colors.white : watchlistColor,
                text: 'Watchlist',
                onTap: goToWatchlistScreenOnTap == false
                    ? () => null
                    : () =>
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return WatchlistScreen();
                        }))),
            Flexible(
              child: NavigationModel(
                  color: myZattabiColor == null ? Colors.white : myZattabiColor,
                  icon: Icons.account_circle_outlined,
                  text: 'My Zattabi',
                  onTap: goToMyZattabiMyAdvertsScreenOnTap == false
                      ? () => null
                      : () => Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            // return MyZattabiMyAdvertsScreen();
                            return WrapperMyZattabiScreen();
                          }))),
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationModel extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? color;
  final Function? onTap;

  const NavigationModel({
    Key? key,
    required this.icon,
    required this.text,
    this.color,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Icon(
                icon,
                size: 20,
                color: Colors.black54,
              ),
              Text(
                text,
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WatchlistNavigationWidget extends StatelessWidget {
  final String text;
  final Color? color;
  final Function? onTap;

  const WatchlistNavigationWidget({
    Key? key,
    required this.text,
    this.color,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Transform.rotate(
                angle: pi / 1,
                child: Icon(
                  FontAwesomeIcons.binoculars,
                  size: 20,
                  color: Colors.black54,
                ),
              ),
              Text(
                text,
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
