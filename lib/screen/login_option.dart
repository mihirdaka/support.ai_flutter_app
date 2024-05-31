// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supportu_flutter_app/provider/auth_provider.dart';
// import 'package:supportu_flutter_app/data/auth.dart';
import 'package:supportu_flutter_app/screen/register.dart';
import 'package:supportu_flutter_app/screen/sign_in_screen.dart';
import 'package:supportu_flutter_app/widget/logo.dart';
// import 'package:sparq_flutter_app/routes.dart';

class LoginOptionsScreen extends StatefulWidget {
  const LoginOptionsScreen({super.key});

  @override
  State<LoginOptionsScreen> createState() => _LoginOptionsScreenState();
}

class _LoginOptionsScreenState extends State<LoginOptionsScreen> {
  ValueNotifier userCredential = ValueNotifier('');

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Logo(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ElevatedButton(
                //     style: ButtonStyle(
                //       // backgroundColor: Color(0xff101010),
                //       backgroundColor:
                //           MaterialStateProperty.all(const Color(0xff111111)),
                //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //         RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(16.0),
                //           side: const BorderSide(
                //             color: Color(0xff404040),
                //           ),
                //         ),
                //       ),
                //     ),
                //     onPressed: () async {
                //       userCredential.value =
                //           await authProvider.signInWithGoogle();
                //       if (userCredential.value != null)
                //         //print(userCredential.value.user!.email);
                //     },
                //     child: Padding(
                //       padding: const EdgeInsets.all(14.0),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Image.asset('assets/logo/google.png'),
                //           Text(
                //             '  Continue with Google',
                //             style: Theme.of(context)
                //                 .textTheme
                //                 .titleMedium
                //                 ?.copyWith(fontSize: 16),
                //           ),
                //         ],
                //       ),
                //     )),
                // const SizedBox(
                //   height: 15,
                // ),
                // ElevatedButton(
                //     style: ButtonStyle(
                //       backgroundColor:
                //           MaterialStateProperty.all(Color(0xff111111)),
                //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //         RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(16.0),
                //           side: BorderSide(
                //             color: Color(0xff404040),
                //           ),
                //         ),
                //       ),
                //     ),
                //     onPressed: () {},
                //     child: Padding(
                //       padding: const EdgeInsets.all(14.0),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Image.asset('assets/logo/apple.png'),
                //           Text(
                //             '  Continue with Apple',
                //             style: Theme.of(context)
                //                 .textTheme
                //                 .titleMedium
                //                 ?.copyWith(fontSize: 16),
                //           ),
                //         ],
                //       ),
                //     )),
                // const SizedBox(
                //   height: 15,
                // ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    // Navigator.of(context).pushNamed(Routes.login);
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return SignInScreen();
                    }));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text(
                      'Sign in with password',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                        child: Text(
                      '''Don't have an account?''',
                      style: Theme.of(context).textTheme.labelLarge,
                    )),
                    TextButton(
                      child: Text(
                        'Sign Up',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontSize: 14),
                      ),
                      // textColor: Theme.of(context).iconTheme.color,
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return RegisterScreen();
                        }));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
