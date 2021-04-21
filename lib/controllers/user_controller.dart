import 'package:get/get.dart';
import 'package:zattabi/models/models.dart';

class UserController extends GetxController {
  Rx<UserModel> _userModel = UserModel(
    id: '',
    name: '',
    email: '',
    userProfilePicture: '',
    userPhoneNumber: '',
    joinedDate: '',
    accountBalance: 0,
  ).obs;

  UserModel get user => _userModel.value;

  set user(UserModel value) => this._userModel.value = value;

  void clear() {
    _userModel.value = UserModel();
  }
}
