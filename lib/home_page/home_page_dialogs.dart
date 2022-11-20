import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:to_do_app/domain_layer/app_database.dart';
import 'package:to_do_app/home_page/bloc/home_page_bloc.dart';
import 'package:to_do_app/utils/colors.dart';
import 'package:to_do_app/utils/util_widgets.dart';

class DeletionDialog extends StatelessWidget {
  const DeletionDialog(
      {super.key, required this.task, required this.toast, required this.bloc});

  final TaskData task;
  final HomePageBloc bloc;
  final FToast toast;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text("Are you sure to delete task?"),
      actions: [
        CupertinoDialogAction(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        CupertinoDialogAction(
          child: const Text("Delete"),
          onPressed: () {
            bloc.add(TaskUpdateEvent(task.copyWith(archieved: true)));
            Navigator.of(context).pop();
            FToast().removeCustomToast();
            toast.showToast(
                positionedToastBuilder: (context, child) => Positioned(
                      bottom: 50,
                      left: 0,
                      right: 0,
                      child: child,
                    ),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(grey200),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 3.0,
                        ),
                      ]),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 10),
                      const Text("Successfully deleted "),
                      CupertinoButton(
                          child: Text(
                            "Restore",
                            style: TextStyle(color: Color(green)),
                          ),
                          onPressed: () {
                            bloc.add(TaskUpdateEvent(
                                task.copyWith(archieved: false)));
                            FToast().removeCustomToast();
                          })
                    ],
                  ),
                ));
          },
        ),
        CupertinoDialogAction(
          child: const Text("Delete forever"),
          onPressed: () {
            bloc.add(TaskDeleteEvent(task.id));
            Navigator.of(context).pop();
            FToast().removeCustomToast();
            toast.showToast(
                positionedToastBuilder: (context, child) => Positioned(
                      bottom: 50,
                      left: 0,
                      right: 0,
                      child: child,
                    ),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(grey200),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        UtilWidgets.shadow,
                      ]),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 10),
                      const Text("Successfully deleted "),
                      CupertinoButton(
                          child: Text(
                            "Restore",
                            style: TextStyle(color: Color(green)),
                          ),
                          onPressed: () {
                            bloc.add(TaskAddEvent(task));
                            FToast().removeCustomToast();
                          })
                    ],
                  ),
                ));
          },
        ),
      ],
    );
  }
}

class CompletionDialog extends StatelessWidget {
  const CompletionDialog({super.key, required this.bloc, required this.task});

  final HomePageBloc bloc;
  final TaskData task;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
          title: const Text("Press confirm to complete task"),
          actions: [
            CupertinoDialogAction(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: const Text("Confirm"),
              onPressed: () {
                bloc.add(TaskUpdateEvent(task.copyWith(completed: true)));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
  }
}