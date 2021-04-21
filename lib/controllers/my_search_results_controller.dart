import 'package:zattabi/models/models.dart';

class MySearchResultsClass {
  static List<Advert> mySearchResults = [];

  static addToSearchResults(Advert item) {
    mySearchResults.add(item);
  }
}

// mixin MySearchResultsClass {
//    List<Advert> mySearchResults = [];

//    addToSearchResults(Advert item) {
//     mySearchResults.add(item);
//   }
// }
