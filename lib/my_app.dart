import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:supportu_flutter_app/constant/theme.dart';
import 'package:supportu_flutter_app/data/chat.dart';
import 'package:supportu_flutter_app/data/user.dart';
import 'package:supportu_flutter_app/firebase_options.dart';
import 'package:supportu_flutter_app/provider/auth_provider.dart';
import 'package:supportu_flutter_app/provider/auth_widget_builder.dart';
import 'package:supportu_flutter_app/screen/home.dart';
import 'package:supportu_flutter_app/screen/login_option.dart';
import 'package:supportu_flutter_app/screen/splash.dart';

class MyApp extends StatefulWidget {
  const MyApp({
    required Key key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Expose builders for 3rd party services at the root of the widget tree
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // initFirebase();
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(ChatMessageAdapter());
    Hive.registerAdapter(SessionsAdapter());
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(RoleAdapter());
  }

  @override
  Widget build(BuildContext context) {
    return AuthWidgetBuilder(
      // databaseBuilder: databaseBuilder,
      builder: (BuildContext context, User userSnapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Support.ai App',
          theme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          home: Consumer<AuthProvider>(
            builder: (_, authProviderRef, __) {
              if (kIsWeb && authProviderRef.status == Status.uninitialized) {
                return const LoginOptionsScreen();
              }

              if (authProviderRef.status == Status.uninitialized) {
                return const SplashScreen();
              }
              if (authProviderRef.status == Status.authenticated) {
                return const HomeScreen();
              } else {
                return const LoginOptionsScreen();
                // : SignInScreen();
              }
            },
          ),
        );
      },
      key: Key('AuthWidget'),
    );
  }

  initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
