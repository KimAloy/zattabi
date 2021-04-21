import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zattabi/config/config.dart';
import 'package:zattabi/controllers/auth_controller.dart';
import 'package:zattabi/screens/screens.dart';
import 'package:zattabi/widgets/widgets.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthController? _authController = Get.put(AuthController());

  final _signUpFormKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _userPhoneNumber = TextEditingController();

  bool loading = false;
  String error = '';

  @override
  void initState() {
    _userPhoneNumber.text = '+256';
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Loading();
    } else {
      return Scaffold(
        backgroundColor: kScreenBackground,
        appBar: AppBar(
          title: Text('Sign up', style: TextStyle(color: Colors.white)),
          backgroundColor: kColorOne,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _signUpFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Sign up, it's Free!",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kColorOne),
                  ),
                  SizedBox(height: 25),
                  enterYourFullName(controller: _usernameController),
                  SizedBox(height: 15),
                  LoginTextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      obscureText: false,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Enter valid email address';
                        } else if (EmailValidator.validate(val) == false) {
                          return 'Enter valid email address';
                        }
                        return null;
                      },
                      labelText: 'Your email address*'),
                  SizedBox(height: 15),
                  LoginTextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _userPhoneNumber,
                      obscureText: false,
                      validator: (val) =>
                          val!.isEmpty ? 'Enter valid phone number' : null,
                      labelText: 'Phone Number*'),
                  const SizedBox(height: 15),
                  LoginTextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    validator: (val) => val!.length < 6 || val!.isEmpty
                        ? 'Password should be at least 6 characters'
                        : null,
                    labelText: 'Password*',
                  ),
                  const SizedBox(height: 15),
                  LoginTextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    validator: (val) => val!.isEmpty ||
                            _passwordController.text !=
                                _confirmPasswordController.text
                        ? 'Confirm password'
                        : null,
                    labelText: 'Confirm Password*',
                  ),
                  const SizedBox(height: 15.0),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: kColorOne,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onPressed: () async {
                        if (_signUpFormKey.currentState!.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _authController!.createUser(
                            accountBalance: 0,
                            joinedDate: '',
                            userProfilePicture: '',
                            fullName: _usernameController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                            userPhoneNumber: _userPhoneNumber.text,
                          );
                          if (result == null) {
                            setState(() {
                              error =
                                  'Invalid email or account already exists for that email';
                              loading = false;
                            });
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already registered?',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      InkWell(
                        splashColor: kColorThree,
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return Login();
                          }));
                          print('going to login screen');
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 4),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: kColorOne,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget enterYourFullName({dynamic controller}) {
    return TextFormField(
      controller: controller,
      style: TextStyle(fontSize: 17),
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: "Your Full Name*",
        contentPadding: EdgeInsets.fromLTRB(5, 11, 5, 11),
        border: OutlineInputBorder(borderSide: BorderSide(width: 0.5)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black26, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kColorTwo),
        ),
      ),
      validator: (val) => val!.isEmpty ? 'Enter your name' : null,
    );
  }
}
