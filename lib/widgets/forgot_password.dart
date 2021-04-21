import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zattabi/config/config.dart';
import 'package:zattabi/screens/authenticate/reset_screen.dart';

class ForgotPassword extends StatelessWidget {
  final Color? color;
  const ForgotPassword({
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          splashColor: kColorThree,
          borderRadius: BorderRadius.circular(3),
          onTap: () {
            print('Forgot password tapped');
            Get.to(() => Reset());
            // showDialog(
            //     context: context, builder: (_) => _ForgotPasswordDialog());
            // Get.defaultDialog(
            //   title: 'Verify',
            //   content: _ForgotPasswordDialog(),
            // );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
            child: Text(
              'Forgot password',
              style: TextStyle(fontWeight: FontWeight.w600, color: color),
              // textAlign: TextAlign.end,
            ),
          ),
        ),
      ],
    );
  }
}
//
// class _ForgotPasswordDialog extends StatelessWidget {
//   final UserController? _userController = Get.put(UserController());
//
//   @override
//   Widget build(BuildContext context) {
//     final userPhoneNumber = _userController!.user.userPhoneNumber;
//     // UserData.user.userPhoneNumber;
//     return AlertDialog(
//       title: Text('Verify'),
//       content: RichText(
//         text: TextSpan(
//           style: TextStyle(color: Colors.black),
//           children: <TextSpan>[
//             TextSpan(
//               text:
//                   'We will be sending a verification code to the following number:\n\n',
//             ),
//             TextSpan(
//               text: '$userPhoneNumber\n\n',
//               style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
//             ),
//             TextSpan(
//               text: 'Do you accept?',
//             ),
//           ],
//         ),
//       ),
//       actions: <Widget>[
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             primary: kColorTwo,
//           ),
//           // color: Colors.red,
//           child: Text(
//             'Yes',
//             style: TextStyle(fontSize: 15),
//           ),
//           onPressed: () {
//             print('"yes tapped"');
//           },
//         ),
//         const SizedBox(width: 25),
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             primary: kColorTwo,
//           ),
//           // color: kColorOne,
//           child: Text(
//             'No',
//             style: TextStyle(fontSize: 15),
//           ),
//           onPressed: () {
//             Navigator.of(context).pop();
//             print('"No pressed"');
//           },
//         ),
//         const SizedBox(width: 8),
//       ],
//     );
//   }
// }
