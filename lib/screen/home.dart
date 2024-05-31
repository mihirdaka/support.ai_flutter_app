import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:supportu_flutter_app/provider/auth_provider.dart';
import 'package:supportu_flutter_app/screen/chat.dart';
import 'package:supportu_flutter_app/screen/chat_sessions.dart';
import 'package:supportu_flutter_app/widget/logo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void getRequiedPermissions() async {
    // get required permissions
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.microphone,
      Permission.manageExternalStorage,
    ].request();
    //print(statuses);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRequiedPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('SupportU'),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.person_crop_circle),
            onPressed: () {
              // open a dialog box to show user profile

              showDialog(
                context: context,
                builder: (context) {
                  return Consumer<AuthProvider>(
                      builder: (context, provider, child) {
                    return AlertDialog(
                      backgroundColor: Colors.black,
                      // title: Text('Profile'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Display user details from auth provider
                          Text('Profile',
                              style: Theme.of(context).textTheme.titleMedium),
                          Divider(
                            color: Colors.grey,
                          ),

                          Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.person,
                                      size: 20,
                                    ),
                                    SizedBox(width: 6),
                                    const Text('Name : '),
                                    Text(
                                      '${provider.user.userModel.firstName} ${provider.user.userModel.lastName}'
                                      '',
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.mail,
                                      size: 20,
                                    ),
                                    SizedBox(width: 6),
                                    Text('Email : '),
                                    Text(
                                      provider.user.userModel.userEmail ?? '',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),
                          Row(
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14.0),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 6),
                                  child: Text(
                                    'Close',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14.0),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  provider.signOut();
                                  Navigator.of(context).pop();
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 6),
                                  child: Text(
                                    'Logout',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  });
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Logo(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        // Navigator.of(context).pushNamed(Routes.login);
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const ChatScreen(
                            sessionId: null,
                          );
                        }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Text(
                          'Start a new chat',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    kIsWeb
                        ? const SizedBox()
                        : ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                            ),
                            onPressed: () {
                              // Navigator.of(context).pushNamed(Routes.login);
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return ChatSessions();
                              }));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Text(
                                'Continue where you left off',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                              ),
                            ),
                          ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
