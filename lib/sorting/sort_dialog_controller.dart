import 'package:get/get.dart';
import 'package:zattabi/models/models.dart';

class SortDialogController extends GetxController {
  int selectedIndex = 0;
  String sortDialogTitle = 'Latest Listings';

  List<AdvertItemsModel> sortDialogItems = [
    AdvertItemsModel(title: 'Latest Listings', index: 0),
    AdvertItemsModel(title: 'Nearest Distance', index: 1),
    AdvertItemsModel(title: 'Lowest Price', index: 2),
    AdvertItemsModel(title: 'Highest Price', index: 3),
    AdvertItemsModel(title: 'Lowest Quantity', index: 4),
    AdvertItemsModel(title: 'Highest Quantity', index: 5),
  ];

  updateTitle(index) {
    sortDialogTitle = sortDialogItems[index].title;
    update();
  }
}
