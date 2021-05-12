import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/model/user.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';

class UserRepository  {

  Future<void> signUp(User user) async{
    final parseUser = ParseUser(user.email, user.password, user.email);

    parseUser.set<String>(KeyUserName, user.name);
    parseUser.set<String>(KeyUserPhone, user.phone);
    parseUser.set<int>(KeyUserType, user.userType.index);

    await parseUser.signUp();
  }


}