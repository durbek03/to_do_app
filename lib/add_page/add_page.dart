import 'package:event_bus/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/add_page/action_button.dart';
import 'package:to_do_app/domain_layer/app_database.dart';
import 'package:to_do_app/domain_layer/task_repository.dart';
import 'package:to_do_app/global_events.dart';
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

  Color textColor = const Color.fromARGB(255, 78, 78, 78);

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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                CupertinoTextField(
                  style: TextStyle(color: textColor),
                  controller: titleController,
                  decoration: _getTextFieldDecoration(),
                  placeholder: "Task title",
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 250,
                  child: CupertinoTextField(
                    style: TextStyle(color: textColor),
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
      ),
    );
  }

  Widget _getActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: ActionButton(
          title: "Due to: ${formatter.format(selectedDate)}",
          color: Color(red),
          onTap: () {
            _showDialog(
              context,
              CupertinoDatePicker(
                minimumDate: DateTime.now(),
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
            title: "Add to do list",
            color: Color(green),
            onTap: () {
              FocusManager.instance.primaryFocus!.unfocus();

              var title = titleController.text.trim();
              var descr = descrController.text.trim();
              var date = selectedDate;

              if (title.isEmpty || descr.isEmpty) {
                _showToast("Complete all fields", context);
                return;
              } else {
                var rep = RepositoryProvider.of<TaskRepository>(context);
                rep.addTask(TaskCompanion.insert(
                    title: title, description: descr, date: date));
                _showToast("Successfully saved", context);
                var eventBus = RepositoryProvider.of<EventBus>(context);
                eventBus.fire(NavigateToHomeEvent());
              }
            },
          ),
        )
      ],
    );
  }

  BoxDecoration _getTextFieldDecoration() {
    return BoxDecoration(
        border: Border.all(width: 1, color: Color(grey700)),
        borderRadius: BorderRadius.circular(5));
  }

  void _showToast(String message, BuildContext context) {
    var fToast = RepositoryProvider.of<FToast>(context);
    fToast.removeCustomToast();

    var toast = Container(
      decoration: BoxDecoration(
          color: Color(grey500), borderRadius: BorderRadius.circular(5)),
      padding: const EdgeInsets.all(15),
      child: Text(
        message,
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
