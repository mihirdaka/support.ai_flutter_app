import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:supportu_flutter_app/data/auth.dart';
import 'package:supportu_flutter_app/data/user.dart';
import 'package:supportu_flutter_app/provider/auth_provider.dart';
import 'package:supportu_flutter_app/screen/register.dart';
// import 'package:sparq_flutter_app/data/auth.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          // title: const Text('Login'),
          ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Builder(builder: (context) {
        final authProvider = Provider.of<AuthProvider>(context);

        return Container(
          width: MediaQuery.sizeOf(context).width,
          height: kBottomNavigationBarHeight * 1.8,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              authProvider.status == Status.authenticating
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedButton(
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
                      // splashColor: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'Login',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.black, fontSize: 16),
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          FocusScope.of(context)
                              .unfocus(); //to hide the keyboard - if any

                          RegisterResponse? status =
                              await authProvider.signInWithEmailAndPassword(
                                  _emailController.text,
                                  _passwordController.text);

                          if (!(status?.status ?? false)) {
                            final snack = SnackBar(
                              elevation: 0,
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.redAccent,
                              content: Text(status?.error?['message'] ??
                                  'Something went wrong'),
                            );

                            ScaffoldMessenger.of(context).showSnackBar(snack);
                            // authProvider.status
                          } else {
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          }
                        }
                      }),
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
                      // Navigator.of(context).pushNamed(Routes.register);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      }),
      body: Stack(
        children: <Widget>[
          // _buildBackground(),
          Align(
            alignment: Alignment.center,
            child: _buildForm(context),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _buildForm(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Sign in with email',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _emailController,
                    style: Theme.of(context).textTheme.titleSmall,
                    validator: (value) =>
                        value!.isEmpty ? 'Enter valid email id' : null,
                    decoration: InputDecoration(
                        filled: true,
                        // prefixIcon: Icon(
                        //   Icons.email,
                        //   color: Theme.of(context).iconTheme.color,
                        // ),
                        labelText: 'Email Id',
                        labelStyle: Theme.of(context).textTheme.titleSmall,
                        border: const OutlineInputBorder()),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: TextFormField(
                      obscureText: true,
                      // maxLength: 12,
                      controller: _passwordController,
                      style: Theme.of(context).textTheme.titleSmall,
                      validator: (value) =>
                          value!.length < 6 ? 'Enter valid password' : null,
                      decoration: InputDecoration(
                          labelStyle: Theme.of(context).textTheme.titleSmall,
                          filled: true,
                          labelText: 'Password',
                          border: const OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
              // Spacer(),
              const SizedBox(
                height: kBottomNavigationBarHeight,
              ),

              // authProvider.status == Status.authenticating
              //     ? const Center(
              //         child: null,
              //       )
              //     : Padding(
              //         padding: const EdgeInsets.only(top: 48),
              //         child: Center(
              //             child: Text(
              //           '''Don't have an account?''',
              //           style: Theme.of(context).textTheme.labelLarge,
              //         )),
              //       ),
              // authProvider.status == Status.authenticating
              //     ? const Center(
              //         child: null,
              //       )
              //     : MaterialButton(
              //         child: const Text('Create account'),
              //         textColor: Theme.of(context).iconTheme.color,
              //         onPressed: () {
              //           Navigator.of(context).pushNamed(Routes.register);
              //         },
              //       ),
              // Center(
              //     child: Column(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: <Widget>[
              //     const SizedBox(
              //       height: 70,
              //     ),
              //     Text(
              //       Provider.of<Flavor>(context).toString(),
              //       style: Theme.of(context).textTheme.bodySmall,
              //     ),
              //   ],
              // )),
            ],
          ),
        ));
  }
}
