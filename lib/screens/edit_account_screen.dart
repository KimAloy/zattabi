import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zattabi/config/config.dart';
import 'package:zattabi/controllers/controllers.dart';
import 'package:zattabi/services/database.dart';

import 'package:zattabi/widgets/widgets.dart';

class EditAccount extends StatefulWidget {
  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  UserController _userController = Get.put(UserController());
  String? name = '';
  String? password = '';
  String? newPassword = '';
  String? userPhoneNumber =
      Get.put(UserController()).user.userPhoneNumber.toString();
  bool toggleKeyboardArrow = false;

  @override
  void initState() {
    name = _userController.user.name;
    userPhoneNumber = _userController.user.userPhoneNumber;
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _userNameController = TextEditingController(text: name);
    final _userPhoneNumberController =
        TextEditingController(text: userPhoneNumber);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Account',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kColorOne,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      print('"profile picture tappped"');
                      // TODO: Reposition profile picture... to be done in the future
                    },
                    child: Container(
                      child: Hero(
                        tag: 'profile',
                        child: CircleAvatar(
                          backgroundColor: Colors.pink,
                          child: Text(
                            'Photo',
                            style: TextStyle(color: Colors.white),
                          ),
                          // backgroundColor: kScreenBackground,
                          radius: 78,
                          // TODO: Add a backgroundimage from firestore else show icon
                          // backgroundImage:
                          //     AssetImage(userData.userProfilePicture!),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          // TODO: Upload profile picture
                          print('"profile camera icon tappped"');
                        },
                        child: CircleAvatar(
                          backgroundColor: kColorOne,
                          radius: 24,
                          child: Icon(
                            Icons.photo_camera,
                            color: Colors.white,
                          ),
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Container(
                  color: kColorOne,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 30),
                        EditAccountFields(
                          title: 'Change Name',
                          hintText: 'Enter Name',
                          icon: Icons.person_outline_outlined,
                          controller: _userNameController,
                          // onChanged: (String value) {
                          //   name = value;
                          // },
                        ),
                        const SizedBox(height: 15),
                        EditAccountFields(
                          controller: _userPhoneNumberController,
                          // onChanged: (String value) {
                          //   userPhoneNumber = value;
                          // },
                          title: 'Change Phone Number',
                          hintText: 'Enter phone number...',
                          icon: Icons.phone,
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            child: Container(
                              color: kColorTwo,
                              child: ExpansionTile(
                                backgroundColor: kColorTwo,
                                title: Text(
                                  'Change Password',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                                onExpansionChanged: (value) {
                                  setState(() {
                                    toggleKeyboardArrow = !toggleKeyboardArrow;
                                  });
                                },
                                leading: Icon(
                                  Icons.vpn_key_outlined,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                trailing: Icon(
                                  toggleKeyboardArrow
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                children: [
                                  EditPasswordAccountFields(
                                    title: 'Change Password',
                                    validator1: (val) => val.isEmpty
                                        ? 'Enter old password*'
                                        : null,
                                    onChanged1: (val) {
                                      setState(() {
                                        password = val;
                                      });
                                    },
                                    validator2: (val) => val.isEmpty
                                        ? 'Enter new password*'
                                        : null,
                                    onChanged2: (val) {
                                      setState(() {
                                        newPassword = val;
                                      });
                                    },
                                    validator3: (val) => val.isEmpty
                                        ? 'Confirm new password*'
                                        : null,
                                    onChanged3: (val) {
                                      setState(() {
                                        newPassword = val;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        GestureDetector(
                          onTap: () {
                            // Get.defaultDialog(
                            //   title: 'Delete Account',
                            //   content: _DeleteAccountDialog());
                            showDialog(
                                context: context,
                                builder: (_) => _DeleteAccountDialog());
                            print('"delete account tapped');
                          },
                          child: Card(
                            color: kColorTwo,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.delete_forever_outlined,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    'Delete Account',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ActionButton(
                onPressed: () {
                  print('"Save Changes tapped"');
                  Database().updateUser(
                    uid: _userController.user.id,
                    fullName: _userNameController.text,
                    userPhoneNumber: _userPhoneNumberController.text,
                  );
                },
                text: 'Save Changes',
                padding: EdgeInsets.symmetric(vertical: 8),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _DeleteAccountDialog extends StatelessWidget {
  const _DeleteAccountDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete Account'),
      content: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.black),
          children: <TextSpan>[
            TextSpan(
                text: 'Do you want to permanently delete your account?\n\n'),
            TextSpan(
              text: 'Note: ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
                text:
                    'You cannot delete an account if it still has money balance.'),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.white,
            primary: Colors.red,
          ),
          child: Text(
            'Delete',
            style: TextStyle(fontSize: 15),
          ),
          onPressed: () {
            print('"Delete account accepted"');
          },
        ),
        const SizedBox(width: 25),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.white,
            primary: kColorOne,
          ),
          child: Text(
            'Cancel',
            style: TextStyle(fontSize: 15),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            print('"Cancel delete pressed"');
          },
        ),
      ],
    );
  }
}
