import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';
import 'package:supportu_flutter_app/data/auth.dart';

// import 'package:supportu_flutter_app/data/auth.dart';
import 'package:supportu_flutter_app/data/user.dart';
import 'package:supportu_flutter_app/provider/auth_provider.dart';
import 'package:supportu_flutter_app/widget/dob_picker.dart';
import 'package:supportu_flutter_app/widget/gender_picker.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _fnameController;
  late TextEditingController _lnameController;
  Gender? selectedGender;
  DateTime? selectedDob;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
    _fnameController = TextEditingController(text: "");
    _lnameController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(),
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
    final authProvider = Provider.of<AuthProvider>(context);

    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: FlutterLogo(
              //     size: 128,
              //   ),
              // ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        // mainAxisSize: Main,
                        children: [
                          Flexible(
                            child: TextFormField(
                              controller: _fnameController,
                              style: Theme.of(context).textTheme.bodySmall,
                              validator: (value) =>
                                  value!.isEmpty ? 'Error' : null,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person_2,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                                labelText: 'First Name',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Flexible(
                            child: TextFormField(
                              controller: _lnameController,
                              style: Theme.of(context).textTheme.bodySmall,
                              validator: (value) =>
                                  value!.isEmpty ? 'Error' : null,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person_2,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                                labelText: 'Last Name',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextFormField(
                      controller: _emailController,
                      style: Theme.of(context).textTheme.bodySmall,
                      validator: (value) => value!.isEmpty ? 'Error' : null,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: TextFormField(
                        obscureText: true,
                        // maxLength: 12,
                        controller: _passwordController,
                        style: Theme.of(context).textTheme.bodySmall,
                        validator: (value) => value!.length < 6
                            ? 'Minimun 6 character required'
                            : null,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            labelText: 'Password',
                            border: const OutlineInputBorder()),
                      ),
                    ),
                  ],
                ),
              ),

              GenderPicker(
                callBack: (value) {
                  selectedGender = value;
                  // print(value);
                },
              ),

              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    DOBInput(
                      callBack: (value) {
                        selectedDob = value;
                        // print(value);
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    authProvider.status == Status.registering
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
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
                                child: Text('Signup',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          color: Colors.black,
                                        )),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    FocusScope.of(context)
                                        .unfocus(); //to hide the keyboard - if any

                                    RegisterResponse? userModel =
                                        await authProvider
                                            .registerWithEmailAndPassword(
                                      _emailController.text,
                                      _passwordController.text,
                                      _fnameController.text,
                                      _lnameController.text,
                                      selectedDob ?? DateTime.now(),
                                      selectedGender?.name ?? 'other',
                                    );

                                    if (userModel?.status == false) {
                                      const snack = SnackBar(
                                        elevation: 0,
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.redAccent,
                                        content: Text('Something went wrong'),
                                      );

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snack);
                                    } else {
                                      // ignore: use_build_context_synchronously
                                      Navigator.pop(context);
                                    }
                                  }
                                }),
                          ),
                  ],
                ),
              ),

              const SizedBox(height: kBottomNavigationBarHeight),
            ],
          ),
        ));
  }

  Widget _buildBackground() {
    return ClipPath(
      // clipper: SignInCustomClipper(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.5,
        color: Theme.of(context).iconTheme.color,
      ),
    );
  }
}

class SignInCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);

    var firstEndPoint = Offset(size.width / 2, size.height - 95);
    var firstControlPoint = Offset(size.width / 6, size.height * 0.45);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height / 2 - 50);
    var secondControlPoint = Offset(size.width, size.height + 15);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
