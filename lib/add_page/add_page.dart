import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/add_page/action_button.dart';
import 'package:to_do_app/domain_layer/app_database.dart';
import 'package:to_do_app/domain_layer/task_repository.dart';
import 'package:to_do_app/utils/colors.dart';

class AddPage extends StatefulWidget {
  AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final titleController = TextEditingController();
  final descrController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  final DateFormat formatter = DateFormat('dd.MM.yyyy');

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          "Add task",
          style: TextStyle(color: dirtyWhite),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              CupertinoTextField(
                placeholderStyle: TextStyle(color: Color(brown200)),
                style: TextStyle(color: Color(brown200)),
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
                  placeholderStyle: TextStyle(color: Color(brown200)),
                  style: TextStyle(color: Color(brown200)),
                  controller: descrController,
                  textAlignVertical: TextAlignVertical.top,
                  maxLines: null,
                  placeholder: "Task description",
                  decoration: _getTextFieldDecoration(),
                ),
              ),
              const SizedBox(height: 10),
              _getActionButtons(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _getActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: ActionButton(
          title: formatter.format(selectedDate),
          color: Color(red),
          onTap: () {
            _showDialog(
              context,
              CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (value) {
                  setState(() {
                    selectedDate = value;
                  });
                },
                key: UniqueKey(),
              ),
            );
          },
        )),
        const SizedBox(width: 10),
        Expanded(
          child: ActionButton(
            title: "Save",
            color: Color(blue),
            onTap: () {
              FocusManager.instance.primaryFocus!.unfocus();

              var title = titleController.text;
              var descr = descrController.text;
              var date = selectedDate;

              if (title.isEmpty || descr.isEmpty) {
                _showToast("Complete all fields", context);
                return;
              } else {
                var rep = RepositoryProvider.of<TaskRepository>(context);
                rep.addTask(TaskCompanion.insert(
                    title: title, description: descr, date: date));
                _showToast("Successfully saved", context);
              }
            },
          ),
        )
      ],
    );
  }

  BoxDecoration _getTextFieldDecoration() {
    return BoxDecoration(
        border: Border.all(width: 1, color: Color(brown500)),
        borderRadius: BorderRadius.circular(5));
  }

  void _showToast(String message, BuildContext context) {
    var fToast = RepositoryProvider.of<FToast>(context);
    fToast.removeCustomToast();

    var toast = Container(
      decoration: BoxDecoration(
          color: Color(brown500), borderRadius: BorderRadius.circular(5)),
      padding: EdgeInsets.all(15),
      child: Text(
        message,
        style: TextStyle(color: dirtyWhite),
      ),
    );
    fToast.showToast(
        positionedToastBuilder: (context, child) => Positioned(
              left: 0,
              right: 0,
              bottom: 60,
              child: child,
            ),
        child: toast);
  }

  void _showDialog(BuildContext context, Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) =>
            Container(height: 210, color: Colors.white, child: child));
  }
}
