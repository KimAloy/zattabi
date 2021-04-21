import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zattabi/config/config.dart';
import 'package:zattabi/models/models.dart';
import 'package:zattabi/sorting/sorting.dart';
import 'package:zattabi/widgets/widgets.dart';

class SortingListMainScreen extends StatelessWidget {
  final Function onChanged;

  const SortingListMainScreen({Key? key, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SortDialogController? sortDialogController =
        Get.put(SortDialogController());

    return Material(
      child: SafeArea(
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Center(
                  child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: kColorOne),
                ),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          'Sort',
                          style: TextStyle(
                            color: kColorOne,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 15),
                        Divider(),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:
                              sortDialogController!.sortDialogItems.length,
                          itemBuilder: (BuildContext context, int index) {
                            AdvertItemsModel mySortDialogItems =
                                sortDialogController.sortDialogItems[index];
                            return MyRadioListTile(
                              title: mySortDialogItems.title,
                              value: mySortDialogItems.index,
                              groupValue: sortDialogController.selectedIndex,
                              onChanged: onChanged,
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider();
                          },
                        ),
                        Divider()
                      ],
                    ),
                  ),
                ),
              )),
            ),
          ),
        ),
      ),
    );
  }
}
