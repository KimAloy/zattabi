import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:zattabi/config/config.dart';
import 'package:zattabi/controllers/controllers.dart';
import 'package:zattabi/models/models.dart';
import 'package:zattabi/widgets/widgets.dart';

class Price extends StatefulWidget {
  final TextEditingController controller;
  final bool eachCheckbox;
  final Function onEachSelected;
  const Price({
    Key? key,
    required this.controller,
    required this.eachCheckbox,
    required this.onEachSelected,
  }) : super(key: key);

  @override
  _PriceState createState() => _PriceState();
}

class _PriceState extends State<Price> {
  @override
  Widget build(BuildContext context) {
    TypeOfAdvertController? typeOfAdvertController =
        Get.put(TypeOfAdvertController());
    return Card(
      color: kGrey50,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GetBuilder(
              init: typeOfAdvertController,
              builder: (dynamic typeOfAdvertController) => CardTitleText(
                  title: typeOfAdvertController.typeOfAdvertTitle == 'For Sale'
                      ? 'Asking price*'
                      : 'Buying price*'),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: MyTextFormField(
                    validator: (value) =>
                        value.isEmpty ? 'Please enter a price*' : null,
                    controller: widget.controller,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      DigitsInputFormatter(),
                    ],
                  ),
                ),
                SizedBox(width: 8),
                FilterChip(
                  label: Text('each'),
                  labelStyle: TextStyle(
                    color: widget.eachCheckbox ? Colors.white : Colors.black,
                  ),
                  checkmarkColor: Colors.white,
                  selectedShadowColor: kColorOne,
                  selectedColor: kColorOne,
                  selected: widget.eachCheckbox,
                  onSelected: widget.onEachSelected as void Function(bool)?,
                  // onSelected: (value) {
                  //   setState(() {
                  //     eachCheckbox = value;
                  //   });
                  // },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
