// import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as fAuth;

import 'package:hive/hive.dart';
import 'package:supportu_flutter_app/data/auth.dart';
import 'package:supportu_flutter_app/data/user.dart';
import 'package:supportu_flutter_app/provider/user_helper.dart';
import 'package:supportu_flutter_app/service/auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// import 'package:sparq_flutter_app/service/master.dart';

// enum Status {
//   uninitialized,
//   authenticated,
//   authenticating,
//   unauthenticated,
//   registering
// }

/*
The UI will depends on the Status to decide which screen/action to be done.

- Uninitialized - Checking user is logged or not, the Splash Screen will be shown
- Authenticated - User is authenticated successfully, Home Page will be shown
- Authenticating - Sign In button just been pressed, progress bar will be shown
- Unauthenticated - User is not authenticated, login page will be shown
- Registering - User just pressed registering, progress bar will be shown

Take note, this is just an idea. You can remove or further add more different
status for your UI or widgets to listen.
 */

class AuthProvider extends ChangeNotifier {
  //Firebase Auth object
  User _user = User(status: Status.uninitialized, UserModel());

  BoxCollection? collection;
  CollectionBox<User?>? userBox;

  AuthClient authApiClient = AuthClient();

  //Default status
  Status _status = Status.uninitialized;

  Status get status => _user.status ?? _status;

  User get user => _user;

  void setUser(User? s) {
    if (s != null) {
      if (s.userModel.accessToken != null) {
        _user = User(status: Status.authenticated, s.userModel);
        _status = Status.authenticated;
      }
    } else {
      _user = User(status: Status.unauthenticated, UserModel());
      _status = Status.unauthenticated;
    }
    userHelper.setUser(_user);

    notifyListeners();
  }

  void saveToHive(User? s) async {
    _status = Status.authenticated;
    await userBox?.put('userModel', s);
    setUser(s);
  }

  void removeFromHive() async {
    await userBox?.delete('userModel');
    // await Hive.box('session').clear();

    setUser(null);
  }

  UserModel get userModel => _user.userModel;

  AuthProvider() {
    //initialise object
  }

  Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn(
        scopes: ['email', 'https://www.googleapis.com/auth/userinfo.name'],
      ).signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = fAuth.GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await fAuth.FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      // TODO
      //print('exception->$e');
    }
  }

  //Create user object based on the given User
  UserModel _userFromFirebase(user) {
    if (user == null) {
      return UserModel(firstName: 'Null', userId: 0);
    }

    return UserModel(
      firebaseUid: user.uid,
      userEmail: user.email,
      firstName: user.displayName,
      userMobile: user.phoneNumber,
    );
  }

  //Method to detect live auth changes such as user sign in and sign out
  Future<void> onAuthStateChanged(UserModel? firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.unauthenticated;
    } else {
      _userFromFirebase(firebaseUser);
      _status = Status.authenticated;
    }
    notifyListeners();
  }

  //Method for new user registration using email and password
  Future<RegisterResponse?> registerWithEmailAndPassword(
    String email,
    String password,
    String fname,
    String lname,
    DateTime dob,
    String gender,
    // String userName,
  ) async {
    try {
      final userData = {
        "email": email,
        "password": password,
        "firstName": fname,
        "lastName": lname,
        "gender": gender,
        "dateOfBirth": dob.toIso8601String(),
        "authType": 'Email',
        // "userName": userName
      };
      _status = Status.registering;
      notifyListeners();
      final RegisterResponse? response =
          await authApiClient.registerUser(userData);

      if (response?.status ?? false) {
        saveToHive(
          User(
            status: Status.authenticated,
            response?.userModel ?? userModel,
          ),
        );
        return response;
      } else {
        _status = Status.unauthenticated;
        notifyListeners();
        return response;
      }
      // return _userFromFirebase(result.user);
    } catch (e) {
      if (kDebugMode) {
        print("Error on the new user registration = $e");
      }
      _status = Status.unauthenticated;
      notifyListeners();
      RegisterResponse? response = RegisterResponse();
      response.error = {'message': e.toString()};
      return response;
    }
  }

  //Method to handle user sign in using email and password
  Future<RegisterResponse?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      _status = Status.authenticating;
      // notifyListeners();
      RegisterResponse? response = await authApiClient.login({
        "email": email,
        "password": password,
      });
      if (response?.status ?? false) {
        saveToHive(
          User(
            status: Status.authenticated,
            response?.userModel ?? userModel,
          ),
        );
      } else {
        _status = Status.unauthenticated;
        notifyListeners();
        return response;
      }
      return response;
    } catch (e) {
      //print("Error on the sign in = " + e.toString());
      _status = Status.unauthenticated;
      notifyListeners();
      RegisterResponse? response = RegisterResponse();
      response.error = {'message': e.toString()};
      return response;
    }
  }

  //Method to handle password reset email
  // Future<void> sendPasswordResetEmail(String email) async {
  //   await _user.sendPasswordResetEmail(email: email);
  // }

  //Method to handle user signing out
  Future signOut() async {
    // _user.signOut();
    removeFromHive();
    _status = Status.unauthenticated;

    notifyListeners();

    // return Future.delayed(Duration.zero);
  }
}
