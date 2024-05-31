import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:supportu_flutter_app/data/user.dart';
import 'package:supportu_flutter_app/provider/auth_provider.dart';
import 'package:supportu_flutter_app/provider/chat_provider.dart';

/*
* This class is mainly to help with creating user dependent object that
* need to be available by all downstream widgets.
* Thus, this widget builder is a must to live above [MaterialApp].
* As we rely on uid to decide which main screen to display (eg: Home or Sign In),
* this class will helps to create all providers needed that depends on
* the user logged data uid.
 */
class AuthWidgetBuilder extends StatelessWidget {
  const AuthWidgetBuilder({required Key key, required this.builder})
      : super(key: key);
  final Widget Function(BuildContext, User) builder;
  // final FirestoreDatabase Function(BuildContext context, String uid)
  //     databaseBuilder;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthProvider>(context, listen: false);
    return Builder(
      // stream: authService.user,
      builder: (
        BuildContext context,
      ) {
        final User user = authService.user;

        final UserModel userModel = user.userModel;
        /*
        * For any other Provider services that rely on user data can be
        * added to the following MultiProvider list.
        * Once a user has been detected, a re-build will be initiated.
         */
        //print('object');
        //print(user.status);
        return MultiProvider(
          providers: [
            Provider<UserModel>.value(value: userModel),
            ChangeNotifierProvider<ChatProvider>(
              create: (context) {
                return ChatProvider();
              },
            ),
          ],
          child: builder(context, authService.user),
        );
        // return builder(context, user);
      },
    );
  }
}
