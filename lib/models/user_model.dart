import 'package:cloud_firestore/cloud_firestore.dart';

// class MyUser {
//   final String name;
//   final String? userProfilePicture;
//   final String? userPhoneNumber;
//   final String? joinedDate;
//   final String? password;
//   final String uid;
//   final int accountBalance;

//   MyUser({
//     required this.name,
//     this.userProfilePicture,
//     this.userPhoneNumber,
//     this.joinedDate,
//     this.password,
//     required this.uid,
//     required this.accountBalance,
//   });
// }

class UserModel {
  String? id;
  String? name;
  String? email;
  String? userProfilePicture;
  String? userPhoneNumber;
  String? joinedDate;
  int? accountBalance;
  UserModel({
    this.id,
    this.name,
    this.email,
    this.userProfilePicture,
    this.userPhoneNumber,
    this.joinedDate,
    this.accountBalance,
  });

  UserModel.fromDocumentSnapShot(DocumentSnapshot doc) {
    id = doc.id;
    name = doc["name"];
    email = doc["email"];
    userProfilePicture = doc["userProfilePicture"];
    userPhoneNumber = doc["userPhoneNumber"];
    joinedDate = doc["joinedDate"];
    accountBalance = doc["accountBalance"];
  }

  // factory UserModel.fromMap(Map<String, dynamic> map) {
  //   return UserModel(
  //     id: ,
  //     name: map['Full Name'],
  //     email: map['Email'],
  //     userProfilePicture: map['Profile Picture'],
  //     userPhoneNumber: map['Phone Number'],
  //     joinedDate: map['Joined Date'],
  //     accountBalance: map['Account Balance'],
  //   );
  // }
}
