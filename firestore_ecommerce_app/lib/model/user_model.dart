import 'package:flutter/material.dart';

class UserModel with ChangeNotifier{
  dynamic userId;
  String userName;
  String userEmail;

  UserModel({this.userId,required this.userName,required this.userEmail});

  factory UserModel.fromMap(Map<String,dynamic> map,{dynamic key}){
    return UserModel(userId: key ?? map["userId"],userName: map["userName"], userEmail: map["userEmail"]);
  }

  Map<String,dynamic> toMap({dynamic key}){
    return {
      "userId":key ?? userId,
      "userName":userName,
      "userEmail":userEmail
    };
  }


  Map<String,dynamic> toUpdatedMap({required String newUserName,required String newUserEmail}){
    return {
      "userId":userId,
      "userName": newUserName,
      "userEmail":newUserEmail,
    };
  }
}