import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/domain_layer/app_database.dart';
import 'package:to_do_app/domain_layer/task_repository.dart';
import 'package:to_do_app/utils/colors.dart';
import 'package:to_do_app/utils/util_widgets.dart';

class EditPage extends StatefulWidget {
  EditPage({super.key, required this.task});

  final TaskData task;

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late DateFormat formatter = DateFormat("dd.MM.yyyy");

  late final TextEditingController titleController =
      TextEditingController(text: widget.task.title);
  late final TextEditingController descrController =
      TextEditingController(text: widget.task.description);
  late DateTime selectedDate = widget.task.date;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: CupertinoPageScaffold(
        backgroundColor: Color(grey200),
        navigationBar: CupertinoNavigationBar(
          backgroundColor: Color(grey200),
          border: null,
          middle: Text(
            "Edit",
            style: TextStyle(color: Color(green700)),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 40,
                child: CupertinoTextField(
                  controller: titleController,
                  style: TextStyle(color: textColor),
                  placeholder: "Title",
                  decoration: _getTextFieldDecoration(),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 200,
                child: CupertinoTextField(
                  controller: descrController,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.top,
                  style: TextStyle(color: textColor),
                  placeholder: "Description",
                  decoration: _getTextFieldDecoration(),
                ),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: 210,
                        color: Colors.white,
                        child: CupertinoDatePicker(
                          minimumDate: DateTime.now(),
                          mode: CupertinoDatePickerMode.date,
                          onDateTimeChanged: (value) {
                            setState(() {
                              selectedDate = value;
                            });
                          },
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: _getTextFieldDecoration(),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        "Due to: ${formatter.format(selectedDate)}",
                        style: const TextStyle(color: Colors.blue),
                      )),
                      const Icon(Icons.calendar_today)
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              _getUpdateButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _getUpdateButton() {
    return GestureDetector(
      onTap: () {
        //updating task here

        var title = titleController.text.trim();
        var description = descrController.text.trim();

        //check if text field is not empty

        if (title.isEmpty || description.isEmpty) {
          var toast = RepositoryProvider.of<FToast>(context);
          FToast().removeCustomToast();
          toast.showToast(
              positionedToastBuilder: (context, child) => Positioned(
                    right: 0,
                    left: 0,
                    bottom: 100,
                    child: child,
                  ),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    boxShadow: [UtilWidgets.shadow]),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: const Text("Complete all fields"),
              ));
          return;
        }

        var rep = RepositoryProvider.of<TaskRepository>(context);
        rep.updateTask(widget.task
            .copyWith(
                title: title, description: description, date: selectedDate)
            .toCompanion(true));
        Navigator.of(context).pop();
      },
      child: Container(
        alignment: Alignment.center,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Color(green),
            boxShadow: [UtilWidgets.shadow]),
        child: const Text(
          "Update",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  BoxDecoration _getTextFieldDecoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: [UtilWidgets.shadow],
        color: Colors.white);
  }
}
