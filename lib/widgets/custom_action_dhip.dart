import 'package:flutter/material.dart';
import 'package:zattabi/config/config.dart';

class CustomActionChip extends StatelessWidget {
  final String text;

  const CustomActionChip({
    Key? key,
    required this.text,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: kColorTwo)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
          child: Text(text,
              style: TextStyle(
                fontSize: 13,
                color: kColorOne,
              )),
        ),
      ),
    );
  }
}
