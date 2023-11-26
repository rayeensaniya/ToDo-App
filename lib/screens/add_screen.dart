import 'package:flutter/material.dart';
import 'package:todo_app/bloc/add_bloc.dart';
import 'package:todo_app/modals/date_modal.dart';
import 'package:todo_app/modals/todo_modal.dart';
import 'package:todo_app/utils/app_diaogue.dart';
import 'package:todo_app/widget/button.dart';
import 'package:todo_app/widget/text_field.dart';

import '../local_helper/databse_service.dart';

class AddScreen extends StatefulWidget {
  AddScreen({
    Key? key,
    this.todoModal,
  }) : super(key: key);
  final TodoModel? todoModal;

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController dateController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final dbHelper = DatabaseHelper.instance;
  List<TodoModel> notesList = [];
  final _formKey = GlobalKey<FormState>();
  final _addBloc = AddScreenBloc();
  DateModal? dateModal;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.todoModal?.title);
    descriptionController =
        TextEditingController(text: widget.todoModal?.description);
    dateController = TextEditingController(text: widget.todoModal?.dueDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: const Text(
          'ADD SCREEN',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  AppTextField(
                    labelText: 'TITLE',
                    maxLines: 2,
                    controller: titleController,
                    validator: (p0) => _addBloc.titleValidator(title: p0),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppTextField(
                    alignLabelWithHint: true,
                    labelText: 'Description',
                    controller: descriptionController,
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
                    onTp: () async {
                      final dateTime = await AppDialog.selectDate(context);
                      dateModal = dateTime;
                      dateController.text = dateTime?.formattedDate ?? "";
                    },
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  AppButton(
                      onpPressed: () async {
                        final req = TodoModel(
                            title: titleController.text,
                            description: descriptionController.text,
                            dueDate: dateModal?.yymmdd,
                            status: widget.todoModal == null
                                ? 'Pending'
                                : widget.todoModal?.status,
                            createdAt: DateTime.now().toString());
                        if (widget.todoModal == null) {
                          await _addBloc.insertIntoDB(req);
                        } else {
                          _addBloc.updateDB(widget.todoModal!.id!, req);
                        }
                        print(req.toJson());
                        if (_formKey.currentState!.validate()) {
                          Navigator.of(context).pop(true);
                        }
                      },
                      text: widget.todoModal == null ? 'Submit' : 'Update')
                ],
              ),
            )),
      ),
    );
  }
}
