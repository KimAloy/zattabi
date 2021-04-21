import 'package:flutter/material.dart';
import 'package:zattabi/config/config.dart';

class MyCheckboxListTile extends StatelessWidget {
  final String title;
  final bool value;
  final Function onChanged;

  const MyCheckboxListTile({
    Key? key,
    required this.title,
    required this.value,
    required this.onChanged,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: CheckboxListTile(
        // contentPadding: EdgeInsets.all(0),
        activeColor: Colors.white,
        checkColor: kColorTwo,
        title: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
        controlAffinity: ListTileControlAffinity.leading,
        value: value,
        onChanged: onChanged as void Function(bool?)?,
      ),
    );
  }
}
