import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sharing_content/models/user.dart';
import 'package:sharing_content/notifiers/auth_notifier.dart';
import 'package:google_sign_in/google_sign_in.dart';

var userId;
GoogleSignInAccount _currentUser;


login(User user, AuthNotifier authNotifier) async {
  var response = await http.get('http://10.0.2.2:8000/users/auth/' +
      user.email +
      '/' +
      user.password); //calling the api to get id of user
  print('after get');
  if (response.statusCode == 200 && response.body != "no user found") {
    //true if user loggedin successfully
    print('true condition');
    userId = response.body.toString(); // storing the id to variable->userid
    print(response.body.toString());
    //st=Status.Authenticated;
    if (userId != null) {
      print("Login : $userId");
      authNotifier.setUser(userId);
    }
  }
}

Future signup(User user, AuthNotifier authNotifier) async {
  var response = await http.post('http://10.0.2.2:8000/users/input/' + user.id,
      body: jsonEncode(user.toMap())); //calling api to store data of new user

      //   var response = await http.post('http://10.0.2.2:8000/users/input/$user.id',
// body: jsonEncode(user.toMap()));       //This type of declaration was showing error, so i separated (user.id) as shown up, I don't that it works or not.

  if (response.statusCode == 200 && response.body == "user saved") {
    //true if user registered successfully
    print(user.id);
    userId = user.id;

    if (userId != Null) {
      authNotifier.setUser(userId);
    }
    return true;
  }
}

initializeCurrentUser(AuthNotifier authNotifier) async {
  String user = await userId;

  if (user != null) {
    print(user);
    authNotifier.setUser(userId);
  }

  _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account){

        _currentUser = account;
        authNotifier.setGUser(_currentUser);
    });
    _googleSignIn.signInSilently();

  }


signout(AuthNotifier authNotifier) async {
  userId = null;
  authNotifier.setUser(null);
}

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['profile', 'email']);
  Future<void> handleSignIn(AuthNotifier authNotifier) async{
    try{
      await _googleSignIn.signIn();
       _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account){

        _currentUser = account;
        authNotifier.setGUser(_currentUser);
    });
    //_googleSignIn.signInSilently();

    }catch(error){
      print(error);
    }
  }

    Future<void> handleSignOut() async{
    _googleSignIn.disconnect();
  }

    