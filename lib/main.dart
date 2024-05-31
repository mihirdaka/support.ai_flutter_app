import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supportu_flutter_app/firebase_options.dart';
import 'package:supportu_flutter_app/my_app.dart';
import 'package:supportu_flutter_app/provider/auth_provider.dart';

void main() {
  runApp(
    const App(),
  );
}

initFirebase() async {
  print('init firebase');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>(
            create: (context) => AuthProvider(),
          ),
        ],
        child: const MyApp(
          key: Key('MyApp'),
        )
        // },
        );
  }
}
