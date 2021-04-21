import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zattabi/controllers/binding/authbinding.dart';
import 'package:zattabi/screens/screens.dart';

import 'config/config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FirebaseApp myFirebaseApp = await Firebase.initializeApp();
  // // line returns firebaseApp Instance
  // String name = myFirebaseApp.options.apiKey;
  // print('This is $name');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AuthBinding(),
      title: 'Zattabi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primarySwatch: Colors.cyan,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: kScreenBackground,
      ),
      home: HomeScreen(),
    );
  }
}
