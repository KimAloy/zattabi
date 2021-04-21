import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zattabi/config/config.dart';
import 'package:zattabi/controllers/controllers.dart';
import 'package:zattabi/models/models.dart';
import 'package:zattabi/widgets/widgets.dart';

class TypeOfAdvert extends StatefulWidget {
  final String? title;

  const TypeOfAdvert({Key? key, required this.title}) : super(key: key);

  @override
  _TypeOfAdvertState createState() => _TypeOfAdvertState();
}

class _TypeOfAdvertState extends State<TypeOfAdvert> {
  @override
  Widget build(BuildContext context) {
    TypeOfAdvertController typeOfAdvertController =
        Get.put(TypeOfAdvertController())!;
    return Column(
      children: [
        Card(
          color: kGrey50,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CardTitleText(title: widget.title),
                Wrap(
                  spacing: 5,
                  runSpacing: -8,
                  children: List.generate(
                      typeOfAdvertController.typeOfAdvertItems.length,
                      (int index) {
                    String hello =
                        typeOfAdvertController.typeOfAdvertItems[index].title;
                    return ChoiceChip(
                      avatar: typeOfAdvertController.value == index
                          ? Icon(Icons.done, color: Colors.white, size: 20)
                          : null,
                      label: Text('$hello'),
                      labelStyle: TextStyle(
                          color: typeOfAdvertController.value == index
                              ? Colors.white
                              : Colors.black),
                      selected: typeOfAdvertController.value == index,
                      selectedShadowColor: kColorOne,
                      selectedColor: kColorOne,
                      onSelected: (bool selected) {
                        setState(() {
                          typeOfAdvertController.value =
                              selected ? index : null;
                          typeOfAdvertController
                              .updatetypeOfAdvertItemsTitle(index);
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class EditTypeOfAdvert extends StatefulWidget {
  final String? title;

  const EditTypeOfAdvert({Key? key, required this.title}) : super(key: key);

  @override
  _EditTypeOfAdvertState createState() => _EditTypeOfAdvertState();
}

class _EditTypeOfAdvertState extends State<EditTypeOfAdvert> {
  List<AdvertItemsModel> typeOfAdvertItems = [
    AdvertItemsModel(title: 'For Sale', index: 0),
    AdvertItemsModel(title: 'Wanted', index: 1),
  ];
  int? value = 0;
  String typeOfAdvertTitle = 'For Sale';

  updatetypeOfAdvertItemsTitle(index) {
    setState(() {
      value = index;
      typeOfAdvertTitle = typeOfAdvertItems[index].title;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: kGrey50,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CardTitleText(title: widget.title),
                Wrap(
                  spacing: 5,
                  runSpacing: -8,
                  children:
                      List.generate(typeOfAdvertItems.length, (int index) {
                    String hello = typeOfAdvertItems[index].title;
                    return ChoiceChip(
                      avatar: value == index
                          ? Icon(Icons.done, color: Colors.white, size: 20)
                          : null,
                      label: Text('$hello'),
                      labelStyle: TextStyle(
                          color: value == index ? Colors.white : Colors.black),
                      selected: value == index,
                      selectedShadowColor: kColorOne,
                      selectedColor: kColorOne,
                      onSelected: (bool selected) {
                        setState(() {
                          value = selected ? index : null;
                          updatetypeOfAdvertItemsTitle(index);
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
