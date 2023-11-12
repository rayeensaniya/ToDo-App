import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/bloc/add_bloc.dart';
import 'package:todo_app/widget/button.dart';
import 'package:todo_app/widget/text_field.dart';

class AddScreen extends StatefulWidget {
   AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
  }
final _formKey = GlobalKey<FormState>();
final _addBloc = AddScreenBloc();

class _AddScreenState extends State<AddScreen> {
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('ADD SCREEN', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding:  EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                   AppTextField(labelText: 'TITLE', maxLines: 2,
                  validator: (p0) => _addBloc.titleValidator(title: p0),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const AppTextField(
                    alignLabelWithHint: true,
                    labelText: 'Description',
                    maxLines: 8,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppTextField(

                    labelText: 'Due Date',
                    controller: dateController,
                    readOnly: true,
                    filled: true,
                    onTp: () async{
                   final dateTime =await _selectDate();
                      String dateFormatted = DateFormat('dd/MM/yyyy').format(dateTime!);
                      dateController.text=dateFormatted;
                    },
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  AppButton(onpPressed: () {
                    if(_formKey.currentState!.validate()){

                    }
                  }, text: 'Submit')
                ],
              ),
            )),
      ),
    );
  }

  Future<DateTime?> _selectDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2500),
    );
    if (_picked != null) {
     return _picked;

    }

  }
}
