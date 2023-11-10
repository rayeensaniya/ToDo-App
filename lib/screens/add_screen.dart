import 'package:flutter/material.dart';
import 'package:todo_app/widget/text_field.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            AppTextField(labelText: 'TITLE'),
            SizedBox(
              height: 20,
            ),
            AppTextField(labelText: 'Description')
          ],
        ),
      ),
    );
  }
}
