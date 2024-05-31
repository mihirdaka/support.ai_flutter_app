// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:supportu_flutter_app/data/chat.dart';
import 'package:supportu_flutter_app/data/user.dart';
import 'package:supportu_flutter_app/firebase_options.dart';
import 'package:supportu_flutter_app/provider/auth_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supportu_flutter_app/provider/chat_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // startTimer();
    if (!kIsWeb) {
      initFirebase();
      createHiveConnection();
    } else {
      // redirect();
      // redirect to login
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const LoginOptionsScreen(),
      //   ),
      // );
    }
  }

  createHiveConnection() async {
    final authService = Provider.of<AuthProvider>(context, listen: false);
    final chatService = Provider.of<ChatProvider>(context, listen: false);

    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    authService.collection = await BoxCollection.open(
      'supportu_appData',
      {'user', 'settings', 'session'},
      path: "${directory.path}/db",
    );
    authService.userBox = await authService.collection?.openBox<User>('user');
    // chatService.sessionBox =
    // await authService.collection?.openBox<Sessions>('session');
    final box = await Hive.openLazyBox<Sessions>('session');
    chatService.sessionBox = box;
    final userModel = await authService.userBox?.get('userModel');
    // final messages = await chatBox?.get();

    authService.setUser(userModel);

    // redirect();
  }

  initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Center(
            child: Text(
          'Splash Screen',
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
          ),
        )),
        const FlutterLogo(
          size: 128,
        ),
      ],
    )));
  }
}
