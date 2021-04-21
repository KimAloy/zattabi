import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:zattabi/config/config.dart';
import 'package:zattabi/controllers/controllers.dart';
import 'package:zattabi/models/models.dart';
import 'package:zattabi/screens/screens.dart';
import 'package:zattabi/widgets/widgets.dart';

class MyZattabiMyAdvertsScreen extends StatefulWidget {
  @override
  _MyAdvertsState createState() => _MyAdvertsState();
}

class _MyAdvertsState extends State<MyZattabiMyAdvertsScreen> {
  final MyAdvertsController? myAdvertsController =
      Get.put(MyAdvertsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScreenBackground2,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              NavigationItems(
                myZattabiColor: kScreenBackground2,
                goToMyZattabiMyAdvertsScreenOnTap: false,
              ),
              Container(color: kColorOne, height: 4),
              const SizedBox(height: 2),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back, size: 24),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        Spacer(),
                        MyOutlineButton(
                          textColor: kColorOne,
                          text: 'My Adverts',
                        ),
                        const SizedBox(width: 10),
                        MyOutlineButton(
                          onPressed: () {
                            print('"profile and account"');
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return MyZattabiProfileAndAccountScreen();
                            }));
                          },
                          text: 'My account',
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                    const SizedBox(height: 2),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Obx(
                () => myAdvertsController!.myAdverts.length == 0
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 50),
                            Icon(
                              FontAwesomeIcons.frownOpen,
                              size: 45,
                              color: Colors.black26,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Such emptyness!\nOnce you post and advert,\n you'll see it listed here",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black45,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: myAdvertsController!.myAdverts.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(height: 5),
                            itemBuilder: (BuildContext context, int index) {
                              final Advert myAdvert =
                                  myAdvertsController!.myAdverts[index];

                              if (myAdvert.advertType == 'For Sale' &&
                                  myAdvert.images == null) {
                                return ForSaleNoImageContainer(
                                    advertData: myAdvert,
                                    showWatchlistIcon: false,
                                    showDistance: false,
                                    showAdvertStatusSwitch: true,
                                    onTap: () {
                                      print('"For Sale tapped has NO image"');
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) {
                                            return NewAdvertDetailsScreen(
                                              index: index,
                                              advertData: myAdvert,
                                              showWatchlistIcon: false,
                                            );
                                          },
                                        ),
                                      ).whenComplete(() => setState(() => {}));
                                    });
                              } else if (myAdvert.advertType == 'For Sale' &&
                                  myAdvert.images != null) {
                                return ForSaleContainerHasImage(
                                    advertData: myAdvert,
                                    showWatchlistIcon: false,
                                    showDistance: false,
                                    showAdvertStatusSwitch: true,
                                    onTap: () {
                                      print('"For Sale tapped has image"');
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) {
                                            return NewAdvertDetailsScreen(
                                              index: index,
                                              advertData: myAdvert,
                                              showWatchlistIcon: false,
                                            );
                                          },
                                        ),
                                      ).whenComplete(() => setState(() => {}));
                                    });
                              } else if (myAdvert.advertType == 'Wanted') {
                                return WantedContainer(
                                    wantedData: myAdvert,
                                    showWatchlistIcon: false,
                                    showDistance: false,
                                    showAdvertStatusSwitch: true,
                                    onTap: () {
                                      print('"wanted tapped"');
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) {
                                            return NewAdvertDetailsScreen(
                                              index: index,
                                              showWatchlistIcon: false,
                                              advertData: myAdvert,
                                            );
                                          },
                                        ),
                                      ).whenComplete(() => setState(() => {}));
                                    });
                              } else {
                                return Center(
                                  child: Container(
                                    child: Text(
                                      'my_zattabi_my_adverts_screen Error. Take a look there',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                          const SizedBox(height: 100),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
