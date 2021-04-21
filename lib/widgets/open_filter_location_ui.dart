import 'package:flutter/material.dart';

class OpenFilterDialogButton extends StatefulWidget {
  final String title;
  final Widget widget;

  const OpenFilterDialogButton({
    Key? key,
    required this.title,
    required this.widget,
  }) : super(key: key);

  @override
  _OpenDialogButtonState createState() => _OpenDialogButtonState();
}

class _OpenDialogButtonState extends State<OpenFilterDialogButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('"dialog button choice selected"');
        showGeneralDialog(
          context: context,
          pageBuilder: (BuildContext context, Animation animation,
              Animation secondAnimation) {
            return widget.widget;
          },
        );
        // .whenComplete(() => setState(() => {}));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 0.5, color: Colors.black38),
            borderRadius: BorderRadius.circular(3)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              const SizedBox(width: 15),
              Text(
                widget.title,
                style: TextStyle(fontSize: 16),
              ),
              Spacer(),
              // if internet connection == false ? const Sizedbox.shrink :
              Icon(Icons.arrow_drop_down),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}
