import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zattabi/config/config.dart';
import 'package:zattabi/controllers/controllers.dart';
import 'package:zattabi/screens/screens.dart';
import 'package:zattabi/widgets/widgets.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _loginFormKey = GlobalKey<FormState>();

  final AuthController? authController = Get.put(AuthController());

  final _passwordController = TextEditingController();

  final _emailController = TextEditingController();

  bool loading = false;
  String error = '';

  late SharedPreferences loginData;
  late bool newUser;

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
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: kScreenBackground,
            appBar: AppBar(
              title: Text('Login', style: TextStyle(color: Colors.white)),
              backgroundColor: kColorOne,
              elevation: 0.0,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Form(
                  key: _loginFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        'Enter\nEmail Address\n& Password',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      LoginTextFormField(
                          controller: _emailController,
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) => val!.isEmpty
                              ? 'Enter a valid email address'
                              : null,
                          labelText: 'Your email address*'),
                      const SizedBox(height: 15),
                      LoginTextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        validator: (val) =>
                            val!.isEmpty ? 'Enter password' : null,
                        labelText: 'Password*',
                      ),
                      const SizedBox(height: 4.0),
                      error == ''
                          ? const SizedBox.shrink()
                          : Column(
                              children: [
                                const SizedBox(height: 2.0),
                                Text(
                                  error,
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 14),
                                ),
                              ],
                            ),
                      ForgotPassword(),
                      const SizedBox(height: 4.0),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          primary: kColorOne,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onPressed: () async {
                          if (_loginFormKey.currentState!.validate()) {
                            setState(() => loading = true);
                            dynamic result = await authController!.login(
                              _emailController.text,
                              _passwordController.text,
                            );
                            if (result == null) {
                              setState(() {
                                error = 'Invalid email or password';
                                loading = false;
                              });
                            }
                          }
                        },
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(
                              fontSize: 14,
                              letterSpacing: -0.1,
                            ),
                          ),
                          InkWell(
                            splashColor: kColorThree,
                            borderRadius: BorderRadius.circular(5),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return SignUp();
                              }));
                              print('going to Sign up screen');
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 6),
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kColorOne,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
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
