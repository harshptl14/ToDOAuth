class User {
  String name;
  String email;
  String password;
  String number;
  String id;

  User();

  User.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    email = data['email'];
    password = data['password'];
    number = data['number'];
  }

  Map<String, dynamic> toMap(){
    return {
      'name' : name,
      'email' : email,
      'password' : password,
      'number' : number,
    };
  }

}
