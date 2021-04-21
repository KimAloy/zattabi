import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:zattabi/config/config.dart';
import 'package:zattabi/controllers/controllers.dart';
import 'package:zattabi/controllers/user_controller.dart';
import 'package:zattabi/screens/screens.dart';
import 'package:zattabi/widgets/widgets.dart';

class MyZattabiProfileAndAccountScreen extends StatefulWidget {
  @override
  _MyZattabiProfileAndAccountScreenState createState() =>
      _MyZattabiProfileAndAccountScreenState();
}

class _MyZattabiProfileAndAccountScreenState
    extends State<MyZattabiProfileAndAccountScreen> {
  final AuthController? _authController = Get.put(AuthController());

  final UserController userController = Get.put(UserController());

  /// CODE BELOW IS FOR SHARED PREFERENCES
  // String? name = '';
  //
  // void initState() {
  //   getData();
  //   super.initState();
  // }
  //
  // getData() async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   setState(() {
  //     name = sharedPreferences.getString('name');
  //     userController.user.name = name;
  //     print('Profile account name: $name');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NavigationItems(
                myZattabiColor: kScreenBackground2,
                goToMyZattabiMyAdvertsScreenOnTap: false,
              ),
              Container(color: kColorOne, height: 4),
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, size: 24),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Spacer(),
                  MyOutlineButton(
                    onPressed: () {
                      print('"my advert button pressed"');
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return MyZattabiMyAdvertsScreen();
                      }));
                    },
                    text: 'My Adverts',
                  ),
                  const SizedBox(width: 10),
                  MyOutlineButton(
                    // onPressed: () => null,
                    text: 'My account',
                    textColor: kColorOne,
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              const SizedBox(height: 25.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return EditAccount();
                        }));
                        print('"Profile picture tapped"');
                      },
                      child: Hero(
                        tag: 'profile',
                        child: GetX<UserController>(
                          builder: (_) {
                            if (_.user.userProfilePicture != null) {
                              return CircleAvatar(
                                backgroundColor: Colors.pink,
                                radius: 28,
                                child: _.user.userProfilePicture == ''
                                    ? Text('Photo',
                                        style: TextStyle(color: Colors.white))
                                    : Text(
                                        'Photo',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                // TODO: Add user background image from firestore else if show icon
                                // backgroundImage:
                                //    _.user.userProfilePicture==''? null: AssetImage(userData.userProfilePicture!),
                              );
                            } else {
                              return Text('Loading...');
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    // Text(name!),
                    GetX<UserController>(
                      builder: (_) {
                        if (_.user.name != null) {
                          return Expanded(
                            child: Text(
                              _.user.name!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                          );
                        } else {
                          return Text('Loading...');
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Divider(height: 1, color: Colors.grey),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //       ElevatedButton(
                    //           onPressed: () =>
                    //               print('"Deposit Account button pressed"'),
                    //           child: Text(
                    //             'Deposit Money',
                    //             style: TextStyle(color: Colors.white),
                    //           ),
                    //           style: ElevatedButton.styleFrom(
                    //             primary: kColorOne,
                    //           )),
                    //       const SizedBox(height: 20),
                    //       GetX<UserController>(
                    //         builder: (_) {
                    //           if (_.user.accountBalance != null) {
                    //             return Text(
                    //               'Account Balance:  UGX ${numberCommaFormatter.format(_.user.accountBalance)}',
                    //               style: TextStyle(
                    //                 fontSize: 15,
                    //                 fontWeight: FontWeight.w600,
                    //               ),
                    //             );
                    //           } else {
                    //             return Text('Loading...');
                    //           }
                    //         },
                    //       ),
                    //       const SizedBox(height: 15),
                    GetX<UserController>(
                      builder: (_) {
                        if (_.user.accountBalance != null) {
                          return Text(
                            'Phone Number:  ${_.user.userPhoneNumber}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        } else {
                          return Text('Loading...');
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Divider(height: 1, color: Colors.grey),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SettingsOptions(
                        text: 'Edit Account',
                        icon: Icons.edit,
                        color: Colors.black87,
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return EditAccount();
                          })).whenComplete(() => setState(() => {}));
                          print('"Edit Account settings icon tapped"');
                        }),
                    _SettingsOptions(
                      text: 'Contact Zattabi',
                      icon: FontAwesomeIcons.whatsapp,
                      color: Colors.green,
                      onTap: () => print(
                        '"Contact Zattabi icon tapped"',
                      ),
                    ),
                    _SettingsOptions(
                      text: 'Logout',
                      icon: Icons.power_settings_new_outlined,
                      color: Colors.red,
                      onTap: () async {
                        _authController!.signOut();
                        print('"Logout Account icon tapped"');
                      },
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsOptions extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color? color;
  final Function onTap;

  const _SettingsOptions({
    Key? key,
    required this.text,
    required this.icon,
    this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: InkWell(
        splashColor: kColorThree,
        onTap: onTap as void Function()?,
        child: ListTile(
          contentPadding: EdgeInsets.all(0.0),
          title: Text(
            text,
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: Icon(icon, size: 30, color: color),
        ),
      ),
    );
  }
}

class MyOutlineButton extends StatelessWidget {
  final Function? onPressed;
  final String text;
  final Color? textColor;

  const MyOutlineButton({
    Key? key,
    this.onPressed,
    required this.text,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed == null ? () => null : onPressed as void Function()?,
      child: Text(text),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: textColor == null ? Colors.black54 : kColorOne),
        primary: textColor == null ? Colors.black54 : textColor,
      ),
    );
  }
}
