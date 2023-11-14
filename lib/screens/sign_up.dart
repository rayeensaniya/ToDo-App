import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/bloc/signup_bloc.dart';
import 'package:todo_app/firebase_auth/firebase_auth_services.dart';
import 'package:todo_app/screens/dashboard.dart';
import 'package:todo_app/widget/button.dart';
import 'package:todo_app/widget/text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}
final _formKey = GlobalKey<FormState>();
final _signupBloc = SignUpBloc();

class _SignUpScreenState extends State<SignUpScreen> {
  late FocusNode nameFocus;
  late FocusNode emailFocus;
  late FocusNode mobileFocus;
  late FocusNode passwordFocus;
  late FocusNode confirmFocus;

  @override
  void initState(){
    super.initState();
    nameFocus = FocusNode();
    emailFocus = FocusNode();
    mobileFocus = FocusNode();
    passwordFocus = FocusNode();
    confirmFocus = FocusNode();
  }

  final FirebaseService auth = FirebaseService();

  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
final TextEditingController nameController = TextEditingController();
final TextEditingController mobileController = TextEditingController();
final TextEditingController emailController = TextEditingController();
   @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset('assets/images/todo_logo.png',height: 200,width: 350),
                const Text('Sign Up',style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold
                ),),
                const SizedBox(
                  height: 20,
                ),
                AppTextField(labelText: 'Name',
                  controller: nameController,
                  focusNode: nameFocus,
                  onFieldSubmitted: (p0) {
                    FocusScope.of(context).requestFocus(emailFocus);
                  },
                  validator: (value) => _signupBloc.nameValidator(name: value),),
                const SizedBox(
                  height: 10,
                ),
                AppTextField(labelText: 'Email',
                  controller:emailController ,
                  keyboardType: TextInputType.emailAddress,
                  focusNode: emailFocus,
                  onFieldSubmitted: (p0) {
                    nameFocus.unfocus();
                    FocusScope.of(context).requestFocus(mobileFocus);
                  },
                  validator: (p0) => _signupBloc.emailValidator(email: p0),),
                const SizedBox(
                  height: 10,
                ),
                 AppTextField(labelText: 'Mobile no',
                   controller: mobileController,
                   suffixIcon: const Icon(Icons.call),
                   validator: (value) => _signupBloc.mobileValidator(mobile: value) ,
               focusNode: mobileFocus,
               maxLength: 10,
                 keyboardType: TextInputType.phone,
               ),
                const SizedBox(
                  height: 10,
                ),
                AppTextField(labelText: 'Password',

                  controller: _password,
                  onFieldSubmitted: (p0) {
                    FocusScope.of(context).requestFocus(confirmFocus);
                  },
                  suffixIcon: const Icon(Icons.remove_red_eye_outlined),
                  focusNode: passwordFocus,
                  validator: (value) => _signupBloc.passwordValidator(password: value),),
                const SizedBox(
                  height: 10,
                ),
                 AppTextField(labelText: 'Confirm Password',
                   controller: _confirmPassword,
                   suffixIcon: const Icon(Icons.remove_red_eye_outlined),
                   onFieldSubmitted: (p0) {

                   },
                   focusNode: confirmFocus,
                   validator: (value) {
                   return _signupBloc.confirmPassword(confirm: value!.trim(),password: _password.text.trim());
                   } ,),
                const SizedBox(
                  height: 15,
                ),
                AppButton(
                    text: 'SIGN UP',
         onpPressed: signUp,
         //             () {
         // if(_formKey.currentState!.validate()){
         //  Navigator.push(context, MaterialPageRoute(builder: (context) => const Dashboard(),));
         // }}
                ),
                const SizedBox(
                  height: 10,
                ),
    AppButton(onpPressed: () {
    Navigator.pop(context);
    }, text: 'BACK')
              ],
            ),
          ),
        ),
      ),
    );
  }
  void signUp()async{
     String name = nameController.text;
     String email = emailController.text;
     String mobile = mobileController.text;
     String password = _password.text;
     String confirmPassword = _confirmPassword.text;

     User? user = await auth.signUpWithEmailAndPassword(email, password);
     if(user != null){
       print('User is successfully created');
       Navigator.pushNamed(context, "/home");
     }else{
       print('some error happened');
     }
  }
}
