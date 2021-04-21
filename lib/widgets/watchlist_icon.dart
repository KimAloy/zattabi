import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:zattabi/config/config.dart';
import 'package:zattabi/controllers/controllers.dart';
import 'package:zattabi/models/models.dart';

class IconAddToWatchlist extends StatefulWidget {
  final Advert advertData;

  const IconAddToWatchlist(
      {Key? key, required this.advertData, Advert? advertdData})
      : super(key: key);

  @override
  _IconAddToWatchlistState createState() => _IconAddToWatchlistState();
}

class _IconAddToWatchlistState extends State<IconAddToWatchlist> {
  final WatchlistedController? watchlistedController =
      Get.put(WatchlistedController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: watchlistedController,
      builder: (dynamic watchlistedController) => GestureDetector(
        onTap: () {
          watchlistedController.toggleWatchlisted(widget.advertData);
          widget.advertData.isWatchlisted
              ? watchlistedController.addToWatchlist(widget.advertData)
              : watchlistedController.removeFromWatchlist(widget.advertData);
        },
        child: Stack(
          children: [
            Container(
              height: 25,
              width: 30,
              child: Center(
                child: Transform.rotate(
                  angle: pi / 1,
                  child: Icon(
                    FontAwesomeIcons.binoculars,
                    size: 20,
                    color: widget.advertData.isWatchlisted
                        ? Colors.red
                        : Colors.black,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Icon(
                Icons.add_circle,
                size: 15,
                color: kColorOne,
              ),
            )
          ],
        ),
      ),
    );
  }
}

//   final Set<Advert> _saved = Set<Advert>();

//   Widget _buildRow(Advert advert) {
//     final bool alreadySaved = _saved.contains(advert);
//     return ListTile(
//       title: Text('${advert.title}'),
//       trailing: Icon(
//         alreadySaved ? Icons.favorite : Icons.favorite_border,
//         color: alreadySaved ? Colors.red : null,
//       ),
//       onTap: () {
//         setState(() {
//           if (alreadySaved) {
//             _saved.remove(advert);
//           } else {
//             _saved.add(advert);
//           }
//         });
//       },
//     );
//   }
