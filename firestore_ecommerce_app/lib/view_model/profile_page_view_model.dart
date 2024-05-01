import 'package:flutter/material.dart';

import '../model/user_model.dart';
import '../repository/database_repository.dart';
import '../tools/locator.dart';

class ProfilePageViewModel with ChangeNotifier{
  List<UserModel> _users = [];


  final DatabaseRepository _repository = locator<DatabaseRepository>();

  ProfilePageViewModel(){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData();
    });
  }


  void getData()async{
    _users = await _repository.getUser();
    notifyListeners();

  }

  List<UserModel> get users => _users;
}