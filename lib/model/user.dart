enum UserType { PARTICULAR, PROFISSIONAL }

class User {
  User({this.name, this.email, this.phone, this.password, this.userType = UserType.PARTICULAR});

  String name;
  String email;
  String phone;
  String password;
  UserType userType;
}
