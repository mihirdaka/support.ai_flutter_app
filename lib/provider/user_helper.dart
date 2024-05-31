// import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';

import 'package:supportu_flutter_app/data/user.dart';
// import 'package:sparq_flutter_app/data/user_model.dart';

UserHelper userHelper = UserHelper();

class UserHelper {
  // Future<SharedPreferences>? _sharedPreference;
  User? _user;

  UserHelper() {
    // fetchUser();
  }

  // String? _token;
//
  User? get user => _user;

  void fetchUser() async {
    final box = await Hive.openBox<User>('user');
    final User? userModel = box.get('userModel');
    // //print(userModel);
    if (userModel?.userModel.accessToken != null) {
      _user = userModel;
      setUser(_user);
    } else {
      // throw error
    }
  }

  void setUser(User? value) {
    _user = value;
  }

  void setToken(User? value) {
    _user = value;
  }

  String? get getToken {
    return _user?.userModel.accessToken;
    // final box = await Hive.openBox<User>('user');
    // final User? userModel = box.get('userModel');
    // //print(userModel);
    // return userModel?.userModel.accessToken ?? 'NA';
  }
}
