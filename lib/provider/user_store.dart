import 'package:flutter/material.dart';

class UserModel {
  final String name;
  final String avatarPath;

  UserModel({required this.name, required this.avatarPath});
}

class UserStore extends ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  void setUser(String name, String avatarPath) {
    _user = UserModel(name: name, avatarPath: avatarPath);
    notifyListeners();
  }
}
