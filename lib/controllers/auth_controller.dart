import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:zattabi/controllers/user_controller.dart';
import 'package:zattabi/models/models.dart';
import 'package:zattabi/screens/home_screen.dart';
import 'package:zattabi/screens/my_zattabi_my_account_screen.dart';
import 'package:zattabi/services/database.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> _firebaseUser = Rxn<User>();

  // String? get user => _firebaseUser.value?.email;
  User? get user => _firebaseUser.value;

  @override
  void onInit() {
    _firebaseUser.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  Future<dynamic> createUser({
    String? fullName,
    String? email,
    String? password,
    String? userProfilePicture,
    String? userPhoneNumber,
    String? joinedDate,
    int? accountBalance,
  }) async {
    try {
      UserCredential _userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: email!.trim(), password: password!);

      // create a user in firestore
      UserModel _user = UserModel(
        id: _userCredential.user!.uid,
        name: fullName,
        email: _userCredential.user!.email,
        userProfilePicture: userProfilePicture,
        userPhoneNumber: userPhoneNumber,
        joinedDate: joinedDate,
        accountBalance: accountBalance,
      );
      if (await Database().createNewUser(_user)) {
        Get.put(UserController()).user = _user;
        Get.back();
        Get.to(() => MyZattabiProfileAndAccountScreen());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('Password should be at least 6 characters');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email');
      }
    }
  }

  Future<dynamic> login(String email, String password) async {
    try {
      UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      Get.put(UserController()).user =
          await Database().getUser(_userCredential.user!.uid);
      // SET SHARED PREFERENCES /// Works here but doesn't work in profile screen
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString('name', Get.put(UserController()).user.name!);
      // prefs.setBool('login', false);
      // print('User name: ${(Get.put(UserController()).user.name)}');
      // print('(User email: ${Get.put(UserController()).user.email!})');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        print('wrong password');
        // Get.snackbar("Login error", 'Invalid password',
        //     snackPosition: SnackPosition.BOTTOM);
      } else {
        print('Invalid email or password');
        // Get.snackbar("Login error", 'Invalid email or password',
        //     snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  Future<dynamic> signOut() async {
    try {
      await _auth.signOut();
      // Get.to(() => Login());
      Get.offAll(() => HomeScreen());
      Get.put(UserController()).clear();
      print('signed out');
      // });
      // Get.put(UserController()).user.email = '';
      // SharedPreferences sharedPreferences =
      //     await SharedPreferences.getInstance();
      // // sharedPreferences.remove('email');

    } catch (e) {
      Get.snackbar("error signing out", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
      print(e);
    }
  }

  void deleteAccount() async {
    User? user = _auth.currentUser;
    await user!.delete().then((value) {
      Get.offAll(() => HomeScreen());
      // Get.put(UserController()).clear();
      // Get.snackbar("Account Deleted", 'success bro!',
      //     snackPosition: SnackPosition.BOTTOM);
    });
    await Database().deleteUser(user.uid);
  }
}
