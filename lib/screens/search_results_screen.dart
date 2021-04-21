import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zattabi/config/config.dart';
import 'package:zattabi/controllers/controllers.dart';
import 'package:zattabi/models/models.dart';
import 'package:zattabi/screens/screens.dart';
import 'package:zattabi/sorting/sorting.dart';
import 'package:zattabi/widgets/widgets.dart';

class SearchResultsScreen extends StatefulWidget {
  final String title;

  const SearchResultsScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _SearchResultsScreenState createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  SortDialogController? sortDialogController = Get.put(SortDialogController());

  // ListViewController? listViewController = Get.put(ListViewController());

  late List<Advert> adverts;
  void latestListings() {
    setState(() {
      adverts.sort((a, b) => b.listed!.compareTo(a.listed!));
    });
  }

  void sortNearestDistance() {
    setState(() {
      adverts.sort((a, b) => a.distance!.compareTo(b.distance!));
    });
  }

  void sortLowestPrice() {
    setState(() {
      adverts.sort((a, b) => a.price!.compareTo(b.price!));
    });
  }

  void sortHighestPrice() {
    setState(() {
      adverts.sort((a, b) => b.price!.compareTo(a.price!));
    });
  }

  void sortLowestQuantity() {
    setState(() {
      adverts.sort((a, b) => a.quantity!.compareTo(b.quantity!));
    });
  }

  void sortHighestQuantity() {
    setState(() {
      adverts.sort((a, b) => b.quantity!.compareTo(a.quantity!));
    });
  }

  String query = '';
  @override
  void initState() {
    super.initState();
    sortDialogController!.sortDialogTitle =
        sortDialogController!.sortDialogItems[0].title;
    sortDialogController!.selectedIndex = 0;
    adverts = MySearchResultsClass.mySearchResults;
    latestListings();
  }

  void searchList(String query) {
    final _adverts = MySearchResultsClass.mySearchResults.where((element) {
      // final adverts = listViewController!.currentList.where((element) {
      final district = element.district!.toLowerCase();
      final parish = element.parish!.toLowerCase();
      final searchLower = query.toLowerCase();
      return district.contains(searchLower) || parish.contains(searchLower);
    }).toList();
    setState(() {
      this.query = query;
      this.adverts = _adverts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScreenBackground2,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NavigationItems(searchColor: kScreenBackground2),
              AppBar(
                backgroundColor: kColorOne,
                elevation: 0.0,
                title: Text(widget.title),
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      MyTextField(
                        cursorColor: kColorOne,
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: searchList,
                        hintText: 'Search location',
                        height: 34,
                        // fontSize: 18,
                        prefixIcon: Icon(
                          Icons.search,
                          color: kColorOne,
                          size: 24,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        adverts.length == 0
                            ? 'No results available'
                            : adverts.length == 1
                                ? 'Showing ${adverts.length} result'
                                : 'Showing ${adverts.length} results',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 15),
                      GetBuilder(
                        init: sortDialogController,
                        builder: (dynamic sortDialogController) =>
                            OpenSortDialogButton(
                                title:
                                    '${sortDialogController.sortDialogTitle}',
                                widget: SortingListMainScreen(
                                  onChanged: (value) {
                                    setState(() {
                                      if (value == 0) {
                                        latestListings();
                                      } else if (value == 1) {
                                        sortNearestDistance();
                                      } else if (value == 2) {
                                        sortLowestPrice();
                                      } else if (value == 3) {
                                        sortHighestPrice();
                                      } else if (value == 4) {
                                        sortLowestQuantity();
                                      } else if (value == 5) {
                                        sortHighestQuantity();
                                      }
                                      sortDialogController!.selectedIndex =
                                          value;
                                      sortDialogController!.updateTitle(value);
                                      Navigator.of(context).pop();
                                      // print(mySortDialogItems.title);
                                    });
                                  },
                                )),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: adverts.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 5),
                itemBuilder: (context, index) {
                  final Advert advertItem = adverts[index];
                  return advertItem.advertType == 'Wanted'
                      ? WantedContainer(
                          wantedData: advertItem,
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return SearchResultsAdvertDetailsScreen(
                                  advertData: advertItem);
                            }));
                          })
                      : advertItem.images == null
                          ? ForSaleNoImageContainer(
                              advertData: advertItem,
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return SearchResultsAdvertDetailsScreen(
                                      advertData: advertItem);
                                }));
                              })
                          : ForSaleContainerHasImage(
                              advertData: advertItem,
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return SearchResultsAdvertDetailsScreen(
                                      advertData: advertItem);
                                }));
                              });
                },
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
