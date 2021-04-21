import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zattabi/config/config.dart';
import 'package:zattabi/controllers/controllers.dart';
import 'package:zattabi/data/data.dart';
import 'package:zattabi/models/models.dart';
import 'package:zattabi/screens/screens.dart';

class SearchDelegateWidget extends SearchDelegate<Advert?> {
  WatchlistedController? watchlistedController =
      Get.put(WatchlistedController());
  Function myResults = MySearchResultsClass.addToSearchResults;

  List forSaleResults(String query) {
    List myList = advertsList
            .where((element) =>
                element.title!.toLowerCase().contains(query.toLowerCase()))
            .toList() +
        advertsList
            .where((element) => element.description!
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
    return myList.toSet().toList();
  }

  List wantedResults(String query) {
    List myWantedList = wantedListData
            .where((element) =>
                element.title!.toLowerCase().contains(query.toLowerCase()))
            .toList() +
        wantedListData
            .where((element) => element.description!
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
    return myWantedList.toSet().toList();
  }

  forSaleListToShow() {
    List forSaleListResults = forSaleResults(query);
    for (int i = 0; i < forSaleListResults.length; i++) {
      var data = forSaleListResults[i];
      myResults(Advert(
        adStatus: data.adStatus,
        advertType: data.advertType,
        quantity: data.quantity,
        quantityUnit: data.quantityUnit,
        images: data.images,
        title: data.title,
        district: data.district,
        parish: data.parish,
        listed: data.listed,
        price: data.price,
        distance: data.distance,
        advertPhoneNumber: data.advertPhoneNumber,
        advertiserName: data.advertiserName,
        advertiserJoinedDate: data.advertiserJoinedDate,
        advertiserProfilePicture: data.advertiserProfilePicture,
        description: data.description,
        eachCheckbox: data.eachCheckbox,
        whatsApp: data.whatsApp,
        phoneCallOk: data.phoneCallOk,
        listingID: data.listingID,
        // isWatchlisted: data.isWatchlisted,
        isWatchlisted:
            watchlistedController!.watchlisted.contains(data) ? true : false,
      ));
    }
  }

  wantedListToShow() {
    List wantedListResults = wantedResults(query);
    for (int i = 0; i < wantedListResults.length; i++) {
      var data = wantedListResults[i];
      myResults(Advert(
        adStatus: data.adStatus,
        advertType: data.advertType,
        quantity: data.quantity,
        quantityUnit: data.quantityUnit,
        images: data.images,
        title: data.title,
        district: data.district,
        parish: data.parish,
        listed: data.listed,
        price: data.price,
        distance: data.distance,
        advertPhoneNumber: data.advertPhoneNumber,
        advertiserName: data.advertiserName,
        advertiserJoinedDate: data.advertiserJoinedDate,
        advertiserProfilePicture: data.advertiserProfilePicture,
        description: data.description,
        eachCheckbox: data.eachCheckbox,
        whatsApp: data.whatsApp,
        phoneCallOk: data.phoneCallOk,
        listingID: data.listingID,
        isWatchlisted: data.isWatchlisted,
      ));
    }
  }

  @override
  String get searchFieldLabel => 'Search for Agriproduct';

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.white,
      ),
      hintColor: Colors.white,
      primaryColor: kColorOne,
      textTheme: theme.textTheme.copyWith(
        headline6: theme.textTheme.headline6!.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        print('"pop back arrow tapped"');
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _EmptyMessage();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List mySearchResults = MySearchResultsClass.mySearchResults;
    List forSaleListResults = forSaleResults(query);
    List wantedListResults = wantedResults(query);
    if (query.length == 0) {
      return Container();
    } else {
      return Column(
        children: [
          _SearchAppBarItemsList(
            text: '${forSaleListResults.length} ',
            text2: "'$query' in Agriproducts For Sale",
            onTap: () {
              print('"for sale tapped"');

              if (forSaleListResults.isEmpty) {
                showResults(context); // shows buildResults
              } else {
                // Very VERY IMPORTANT but double edged sword!.
                // It clears() for Sale OR Wanted page of previous search data
                // BUT it clears the state of the Watchlisted item

                mySearchResults.clear();
                Navigator.of(context).pop();
                forSaleListToShow();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SearchResultsScreen(
                        title: 'Agriproducts For Sale',
                      );
                    },
                  ),
                );
              }
            },
          ),
          Divider(height: 1),
          _SearchAppBarItemsList(
            text: '${wantedListResults.length} ',
            text2: "'$query' in Agriproducts Wanted",
            onTap: () {
              print('"wanted tapped"');
              if (wantedListResults.isEmpty) {
                // if (wantedListResults.isEmpty) {
                showResults(context); // shows buildResults
                return _EmptyMessage;
              } else {
                // Very VERY IMPORTANT but double edged sword!.
                // It clears() for Sale OR Wanted page of previous search data
                // BUT it clears the state of the Watchlisted item

                // mySearchResultsController!.mySearchResults.clear();
                mySearchResults.clear();
                Navigator.of(context).pop();
                wantedListToShow();
              }
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchResultsScreen(
                  title: 'Agriproducts Wanted',
                );
              }));
            },
          ),
          Divider(height: 1),
        ],
      );
    }
  }
}

class _SearchAppBarItemsList extends StatelessWidget {
  final Function? onTap;
  final String text;
  final String text2;

  const _SearchAppBarItemsList({
    Key? key,
    this.onTap,
    required this.text,
    required this.text2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              splashColor: kColorThree,
              onTap: onTap as void Function()?,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                        text: text,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: text2,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: kColorOne,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const SizedBox(height: 70),
          // Icon(Icons.mood_bad_rounded, size: 50, color: Colors.black38),

          Text(
            "Hello there,",
            style: kSearchDelegateTextStyle,
          ),
          SizedBox(height: 30),
          RichText(
              text: TextSpan(children: [
            TextSpan(
              text: "Always select",
              style: kSearchDelegateTextStyle,
            ),
            TextSpan(
              text: "  'Agriproducts For Sale'  ",
              style: kSearchDelegateRichTextStyle,
            ),
            TextSpan(
              text: "or",
              style: kSearchDelegateTextStyle,
            ),
            TextSpan(
              text: "  'Agriproducts Wanted'  ",
              style: kSearchDelegateRichTextStyle,
            ),
            TextSpan(
              text: "above.",
              style: kSearchDelegateTextStyle,
            ),
          ])),
          SizedBox(height: 30),
          RichText(
              text: TextSpan(children: [
            TextSpan(
              text: "If",
              style: kSearchDelegateTextStyle,
            ),
            TextSpan(
              text: "  '0' in Agriproducts For Sale  ",
              style: kSearchDelegateRichTextStyle,
            ),
            TextSpan(
              text: "or",
              style: kSearchDelegateTextStyle,
            ),
            TextSpan(
              text: "  '0' in Agriproducts Wanted  ",
              style: kSearchDelegateRichTextStyle,
            ),
            TextSpan(
              text: ", try searching using a different word.",
              style: kSearchDelegateTextStyle,
            ),
          ])),
        ],
      ),
    );
  }
}
