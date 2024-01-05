import 'package:amazon_clone/commom/widgets/custom_button.dart';
import 'package:amazon_clone/commom/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/auth/services/auth_services.dart';
import 'package:flutter/material.dart';

enum Auth {
  signin,
  signup,
}

class auth_screen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const auth_screen({super.key});

  @override
  State<auth_screen> createState() => _auth_screenState();
}

class _auth_screenState extends State<auth_screen> {
  Auth _auth = Auth.signup;
  final _signupformkey = GlobalKey<FormState>();
  final _signinformkey = GlobalKey<FormState>();
  final Authservice authservice = Authservice();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
    _nameController.dispose();
  }

  void signUpUser() {
    authservice.Signupuser(
        context: context,
        email: _emailController.text,
        password: _passController.text,
        name: _nameController.text);
  }

  void signInUser() {
    authservice.SignInUser(
        context: context,
        email: _emailController.text,
        password: _passController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.backgroundColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              tileColor: _auth == Auth.signup
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundCOlor,
              title: const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signup,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  }),
            ),
            if (_auth == Auth.signup)
              Container(
                color: GlobalVariables.backgroundColor,
                padding: const EdgeInsetsDirectional.all(8),
                child: Form(
                  key: _signupformkey,
                  child: Column(children: [
                    Customformfield(
                      controller: _nameController,
                      hintText: "Name",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Customformfield(
                        controller: _emailController, hintText: "Email"),
                    const SizedBox(
                      height: 10,
                    ),
                    Customformfield(
                      controller: _passController,
                      hintText: "Password",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Custom_button(
                        text: "Sign Up",
                        onTap: () {
                          if (_signupformkey.currentState!.validate()) {
                            signUpUser();
                          }
                        })
                  ]),
                ),
              ),
            ListTile(
              tileColor: _auth == Auth.signin
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundCOlor,
              title: const Text(
                "Sign-In",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signin,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  }),
            ),
            if (_auth == Auth.signin)
              Container(
                color: GlobalVariables.backgroundColor,
                padding: const EdgeInsetsDirectional.all(8),
                child: Form(
                  key: _signinformkey,
                  child: Column(children: [
                    Customformfield(
                        controller: _emailController, hintText: "Email"),
                    const SizedBox(
                      height: 10,
                    ),
                    Customformfield(
                      controller: _passController,
                      hintText: "Password",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Custom_button(text: "Sign In", onTap: () {
                      if (_signinformkey.currentState!.validate()) {
                            signInUser();
                          }
                    })
                  ]),
                ),
              ),
          ],
        ),
      )),
    );
  }
}
