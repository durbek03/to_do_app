import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/domain_layer/app_database.dart';
import 'package:to_do_app/domain_layer/task_repository.dart';

class AddPage extends StatefulWidget {
  AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final titleController = TextEditingController();

  final descrController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Add task"),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              CupertinoTextField(
                controller: titleController,
                decoration: _getTextFieldDecoration(),
                placeholder: "Task title",
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 250,
                child: CupertinoTextField(
                  controller: descrController,
                  textAlignVertical: TextAlignVertical.top,
                  maxLines: null,
                  placeholder: "Task description",
                  decoration: _getTextFieldDecoration(),
                ),
              ),
              CupertinoButton(
                child: const Text("Select date"),
                onPressed: () {
                  _showDialog(
                      context,
                      CupertinoDatePicker(
                        key: UniqueKey(),
                        initialDateTime: selectedDate,
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (value) {
                          setState(() {
                            selectedDate = value;
                          });
                        },
                      ));
                },
              ),
              CupertinoButton.filled(
                  child: Text("Save"),
                  onPressed: () {
                    var title = titleController.text;
                    var descr = descrController.text;
                    var date = selectedDate;
                    if (title.isEmpty || descr.isEmpty) {
                      return;
                    } else {
                      var rep = RepositoryProvider.of<TaskRepository>(context);
                      rep.addTask(TaskCompanion.insert(
                          title: title, description: descr, date: date));
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _getTextFieldDecoration() {
    return BoxDecoration(
        border: Border.all(width: 1, color: Color(0xFF999999)),
        borderRadius: BorderRadius.circular(5));
  }

  void _showDialog(BuildContext context, Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
            height: 210,
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: child));
  }
}
