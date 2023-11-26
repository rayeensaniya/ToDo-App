import 'package:flutter/material.dart';
import 'package:todo_app/repository/repository.dart';
import 'package:todo_app/screens/splash_screen.dart';

void main() async {
  runApp(const MyApp());
  await Repository().initDatabase();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        tabBarTheme: TabBarTheme(
          unselectedLabelColor: Colors.grey.shade50,
          indicatorColor: Colors.white,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
