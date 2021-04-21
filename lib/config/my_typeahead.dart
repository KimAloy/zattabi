import 'package:zattabi/controllers/controllers.dart';
import 'package:zattabi/models/models.dart';

/// USE DATA FROM HTTP request
///
// class CelebrityApi {
//   static Future<List<Celebrity>> getadvertSuggestions(String query) async {
//     final url = Uri.parse('hello');
//     final response = await http.get(url);
//     if (response.statusCode == 200) {
//       final List celebrities = json.decode(response.body);
//       return celebrities
//           .map((json) => Celebrity.fromJson(json))
//           .where((advert) {
//         final nameLower = advert.name.toLowerCase();
//         final queryLower = query.toLowerCase();
//         return nameLower.contains(queryLower);
//       }).toList();
//     } else {
//       throw Exception();
//     }
//   }
// }

class SearchLocation {
  /// This code is for typeahead search field
  static final List<Advert> advert = MySearchResultsClass.mySearchResults;

  static List<Advert> getSuggestions(String query) =>
      List.of(advert).where((advert) {
        final advertLower =
            advert.district!.toLowerCase() + advert.parish!.toLowerCase();
        final queryLower = query.toLowerCase();

        return advertLower.contains(queryLower);
      }).toList();
}
