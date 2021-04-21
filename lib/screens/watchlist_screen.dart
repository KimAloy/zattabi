import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:zattabi/config/config.dart';
import 'package:zattabi/controllers/controllers.dart';
import 'package:zattabi/models/models.dart';
import 'package:zattabi/screens/screens.dart';
import 'package:zattabi/widgets/widgets.dart';

class WatchlistScreen extends StatefulWidget {
  @override
  _WatchlistScreenState createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  final WatchlistedController? watchlistedController =
      Get.put(WatchlistedController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScreenBackground2,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              NavigationItems(
                watchlistColor: kScreenBackground2,
                goToWatchlistScreenOnTap: false,
              ),
              AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: Text(
                  'Watchlist',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: kColorOne,
                elevation: 0.0,
              ),
              GetBuilder(
                init: watchlistedController,
                builder: (dynamic watchlistedController) =>
                    watchlistedController.watchlisted.length == 0
                        ? Column(
                            children: [
                              const SizedBox(height: 80),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 60,
                                            child: Center(
                                              child: Transform.rotate(
                                                angle: pi / 1,
                                                child: Icon(
                                                  FontAwesomeIcons.binoculars,
                                                  size: 40,
                                                  color: Colors.black26,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: Icon(
                                              Icons.add_circle,
                                              size: 30,
                                              color: Colors.black26,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        "Such emptyness!\nOnce you tap an advert's Watchlist icon, you'll see it listed here",
                                        style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 15,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: watchlistedController.watchlisted.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(height: 5),
                            itemBuilder: (BuildContext context, int index) {
                              final Advert myAdvert =
                                  watchlistedController.watchlisted[index];
                              return myAdvert.advertType == 'Wanted'
                                  ? Dismissible(
                                      key: UniqueKey(),
                                      onDismissed: (_) {
                                        onDismissed(
                                            myAdvert,
                                            watchlistedController,
                                            index,
                                            context);
                                      },
                                      child: WantedContainer(
                                          wantedData: myAdvert,
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return SearchResultsAdvertDetailsScreen(
                                                  advertData: myAdvert);
                                            }));
                                          }),
                                    )
                                  : myAdvert.images == null
                                      ? Dismissible(
                                          key: UniqueKey(),
                                          onDismissed: (_) {
                                            onDismissed(
                                                myAdvert,
                                                watchlistedController,
                                                index,
                                                context);
                                          },
                                          child: ForSaleNoImageContainer(
                                              advertData: myAdvert,
                                              onTap: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return SearchResultsAdvertDetailsScreen(
                                                      advertData: myAdvert);
                                                }));
                                              }),
                                        )
                                      : Dismissible(
                                          key: UniqueKey(),
                                          onDismissed: (_) {
                                            onDismissed(
                                                myAdvert,
                                                watchlistedController,
                                                index,
                                                context);
                                          },
                                          child: ForSaleContainerHasImage(
                                              advertData: myAdvert,
                                              onTap: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return SearchResultsAdvertDetailsScreen(
                                                      advertData: myAdvert);
                                                }));
                                              }),
                                        );
                            },
                          ),
              ),
              const SizedBox(height: 100)
            ],
          ),
        ),
      ),
    );
  }

  onDismissed(
      myAdvert, watchlistedController, int index, BuildContext context) {
    watchlistedController.removeFromWatchlist(myAdvert);
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Succesfully myAdvert'),
            TextButton(
              onPressed: () {
                print('Undo tapped');
                if (myAdvert == null) {
                  return;
                }
                watchlistedController.watchlisted.insert(index, myAdvert);
                myAdvert = null;
                setState(
                    () {}); // somehow this works to insert myAdvert advert!
              },
              child: Text('Undo'),
              style: TextButton.styleFrom(
                  side: BorderSide(width: 0.5, color: Colors.white)),
            ),
          ],
        ),
        backgroundColor: kColorOne,
      ),
    );
  }
}
