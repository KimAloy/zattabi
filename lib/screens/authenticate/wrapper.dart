import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zattabi/controllers/auth_controller.dart';
import 'package:zattabi/controllers/controllers.dart';
import 'package:zattabi/screens/authenticate/authenticate.dart';
import 'package:zattabi/screens/screens.dart';

class WrapperMyZattabiScreen extends StatefulWidget {
  @override
  _WrapperMyZattabiScreenState createState() => _WrapperMyZattabiScreenState();
}

class _WrapperMyZattabiScreenState extends State<WrapperMyZattabiScreen> {
  UserController _userController = Get.put(UserController());
  AuthController controller = Get.put(AuthController());

  /// THIS WAS SHARED PREFERENCE CODE BUT DOESN'T SEEM TO WORK
  // String? finalEmail;
  //
  // Future getValidationData() async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   var obtainedEmail = sharedPreferences.getString('email');
  //   setState(() {
  //     finalEmail = obtainedEmail;
  //   });
  //   print(finalEmail);
  // }

  // late SharedPreferences loginData;
  // late bool newUser;

  // @override
  // void initState() {
  //   super.initState();
  //   checkIfAlreadyLogin();
  // }

  //
  // void checkIfAlreadyLogin() async {
  //   loginData = await SharedPreferences.getInstance();
  //   newUser = loginData.getBool('login') ?? true;
  //
  //   print(newUser);
  //   if (newUser == false) {
  //     Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => MyZattabiProfileAndAccountScreen()));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // return _userController.user.email == ''
    //     ? Login()
    //     : MyZattabiProfileAndAccountScreen();
    // return finalEmail == '' ? Login() : MyZattabiProfileAndAccountScreen();
    return Obx(() {
      return (controller.user != null && _userController.user.id != '')
          ? MyZattabiProfileAndAccountScreen()
          : Login();
    });
  }
}

class WrapperAdvertiseScreen extends GetWidget<AuthController> {
  final UserController _userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (controller.user != null && _userController.user.id != '')
          ? AdvertiseScreen()
          : Login();
    });
  }
}
