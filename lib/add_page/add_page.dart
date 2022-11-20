import 'package:event_bus/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/domain_layer/app_database.dart';
import 'package:to_do_app/domain_layer/task_repository.dart';
import 'package:to_do_app/global_events.dart';
import 'package:to_do_app/utils/colors.dart';

import '../utils/util_widgets.dart';

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
    var eventBus = RepositoryProvider.of<EventBus>(context);
    eventBus.on<ClearAddPageDataEvent>().listen((event) {
      titleController.text = "";
      descrController.text = "";
      selectedDate = DateTime.now();
    });

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: CupertinoPageScaffold(
        backgroundColor: Color(grey200),
        navigationBar: CupertinoNavigationBar(
          border: null,
          backgroundColor: Color(grey200),
          middle: Text(
            "Add task",
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
              _getAddButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _getAddButton() {
    var toast = RepositoryProvider.of<FToast>(context);
    return GestureDetector(
      onTap: () {
        var title = titleController.text.trim();
        var description = descrController.text.trim();

        var rep = RepositoryProvider.of<TaskRepository>(context);

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

        //check if text field is not empty
        if (title.isEmpty || description.isEmpty) {
          FToast().removeCustomToast();
          _showToast("Complete all fields", context);
          return;
        }

        var task = TaskCompanion.insert(
            title: title, description: description, date: selectedDate);
        rep.addTask(task);

        FToast().removeCustomToast();
        _showToast("Successfully added", context);

        var eventBus = RepositoryProvider.of<EventBus>(context);
        eventBus.fire(NavigateToHomeEvent());
      },
      child: Container(
        alignment: Alignment.center,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Color(green),
            boxShadow: [UtilWidgets.shadow]),
        child: const Text(
          "Add",
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

  void _showToast(String message, BuildContext context) {
    var fToast = RepositoryProvider.of<FToast>(context);
    fToast.showToast(
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(message),
      ),
    );
  }

  void _showDialog(BuildContext context, Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) =>
            Container(height: 210, color: Colors.white, child: child));
  }
}
