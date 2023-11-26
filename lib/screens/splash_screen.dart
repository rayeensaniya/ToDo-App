import 'package:flutter/material.dart';
import 'package:todo_app/local_helper/preference_helper.dart';
import 'package:todo_app/modals/todo_modal.dart';
import 'package:todo_app/screens/dashboard.dart';
import 'package:todo_app/screens/log_in.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key, this.todoModel}) : super(key: key);
  final TodoModel? todoModel;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Image.asset('assets/images/todo_logo.png'),
      ),
    );
  }

  _navigate() async {
    await Future.delayed(Duration(seconds: 2), () async {
      final get = await SharedPreferencesHelper.getUser();
      if (get == null) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LogIn(),
            ));
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Dashboard(),
            ));
      }
    });
  }
}
