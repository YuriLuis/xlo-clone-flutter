enum UserType { PARTICULAR, PROFISSIONAL }

class User {
  User({this.id ,this.name, this.email, this.phone, this.password, this.userType = UserType.PARTICULAR, this.createdAt});

  String id;
  String name;
  String email;
  String phone;
  String password;
  UserType userType;
  DateTime createdAt;

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, phone: $phone, password: $password, userType: $userType, createdAt: $createdAt}';
  }
}
