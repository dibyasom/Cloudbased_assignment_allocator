import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class SignedInUser extends ChangeNotifier {
  User? _user;

  set user(User? user) {
    this._user = user;
    notifyListeners();
  }

  User? get user => this._user;
}
