import 'package:get/get.dart';
import 'package:zattabi/models/models.dart';

class WatchlistedController extends GetxController {
  List<Advert> watchlisted = [];

  void toggleWatchlisted(Advert advert) {
    advert.isWatchlisted = !advert.isWatchlisted;
    update();
  }

  void addToWatchlist(item) {
    watchlisted.add(item);
    update();
  }

  void removeFromWatchlist(item) {
    watchlisted.remove(item);
    update();
  }
}
