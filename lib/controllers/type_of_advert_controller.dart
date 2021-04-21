import 'package:get/get.dart';
import 'package:zattabi/models/models.dart';

class TypeOfAdvertController extends GetxController {
  int? value = 0;
  String typeOfAdvertTitle = 'For Sale';

  updatetypeOfAdvertItemsTitle(index) {
    value = index;
    typeOfAdvertTitle = typeOfAdvertItems[index].title;
    update();
    print(typeOfAdvertTitle);
  }

  List<AdvertItemsModel> typeOfAdvertItems = [
    AdvertItemsModel(title: 'For Sale', index: 0),
    AdvertItemsModel(title: 'Wanted', index: 1),
  ];
}
