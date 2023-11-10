import 'package:flutter/material.dart';
import 'package:todo_app/bloc/login_bloc.dart';
import 'package:todo_app/screens/dashboard.dart';
import 'package:todo_app/screens/sign_up.dart';
import 'package:todo_app/widget/button.dart';
import 'package:todo_app/widget/text_field.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

final _formKey = GlobalKey<FormState>();
final _loginBloc = LoginBloc();

class _LogInState extends State<LogIn> {
  late  FocusNode emailFocus;
  late  FocusNode passwordFocus;

  @override
  void initState() {
    super.initState();
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
  }

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
                  validator: (value) => _loginBloc.passwordValidator(password: value),
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
                    onpPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Dashboard(),
                            ));
                      }
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
