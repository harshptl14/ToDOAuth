
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sharing_content/models/user.dart';

class AuthNotifier with ChangeNotifier {
  User _user;
  GoogleSignInAccount _guser;

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  GoogleSignInAccount get guser => _guser;

  void setGUser(GoogleSignInAccount guser){
    _guser = guser;
    notifyListeners();
  }
  
}