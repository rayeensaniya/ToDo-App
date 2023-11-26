import 'package:flutter/material.dart';
import 'package:todo_app/bloc/login_bloc.dart';
import 'package:todo_app/local_helper/preference_helper.dart';
import 'package:todo_app/screens/dashboard.dart';
import 'package:todo_app/screens/sign_up.dart';
import 'package:todo_app/widget/button.dart';
import 'package:todo_app/widget/text_field.dart';

import '../modals/user_modal.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

final _formKey = GlobalKey<FormState>();
final _loginBloc = LoginBloc();

class _LogInState extends State<LogIn> {
  late FocusNode emailFocus;
  late FocusNode nameFocus;
  late FocusNode passwordFocus;

  @override
  void initState() {
    super.initState();
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset('assets/images/todo_logo.png',
                    height: 200, width: 350),
                const SizedBox(
                  height: 20,
                ),
                const Text('Log In',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
                const SizedBox(
                  height: 20,
                ),
                AppTextField(
                  labelText: 'Name',
                  controller: nameController,
                  onFieldSubmitted: (p0) {
                    FocusScope.of(context).requestFocus(emailFocus);
                  },
                  validator: (value) => _loginBloc.name(name: value),
                ),
                const SizedBox(
                  height: 15,
                ),
                AppTextField(
                  controller: emailController,
                  focusNode: emailFocus,
                  onFieldSubmitted: (p0) {
                    FocusScope.of(context).requestFocus(passwordFocus);
                  },
                  labelText: 'Email',
                  validator: (value) => _loginBloc.emailValidator(email: value),
                ),
                const SizedBox(height: 15),
                AppTextField(
                  focusNode: passwordFocus,
                  labelText: 'Password',
                  suffixIcon: const Icon(Icons.remove_red_eye_outlined),
                  validator: (value) =>
                      _loginBloc.passwordValidator(password: value),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Forget Password ?',
                      style: TextStyle(color: Colors.black)),
                ),
                const SizedBox(
                  height: 10,
                ),
                AppButton(
                    text: 'LOGIN',
                    onpPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Dashboard(),
                          ),
                        );
                      }
                      String name = nameController.text;
                      String email = emailController.text;
                      final userModal = User(
                        name: nameController.text.trim(),
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );

                      await SharedPreferencesHelper.saveNameAndEmail(userModal);
                    }),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Create an account',
                        style: TextStyle(
                          color: Colors.black54,
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
