import 'package:flutter/material.dart';
import 'package:zattabi/config/config.dart';
import 'package:zattabi/models/models.dart';

class OpenSortDialogButton extends StatefulWidget {
  final String title;
  final Widget widget;

  const OpenSortDialogButton({
    Key? key,
    required this.title,
    required this.widget,
  }) : super(key: key);

  @override
  _OpenSortDialogButtonState createState() => _OpenSortDialogButtonState();
}

class _OpenSortDialogButtonState extends State<OpenSortDialogButton> {
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
    setState(() {
      sortDialogTitle = sortDialogItems[index].title;
      selectedIndex = sortDialogItems[index].index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('"sort button tapped"');
        showGeneralDialog(
          context: context,
          pageBuilder: (BuildContext context, Animation animation,
              Animation secondAnimation) {
            return widget.widget;
          },
        ).whenComplete(() => setState(() => {}));
      },
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: Colors.black38),
                borderRadius: BorderRadius.circular(3)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  const SizedBox(width: 15),
                  Text(
                    'Sort:  ${widget.title}',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 10),
                  Icon(Icons.arrow_drop_down, color: kColorOne),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
