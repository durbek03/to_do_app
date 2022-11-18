import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:to_do_app/domain_layer/app_database.dart';
import 'package:to_do_app/domain_layer/task_repository.dart';
import 'package:to_do_app/utils/colors.dart';

class DeleteionDialog extends StatelessWidget {
  const DeleteionDialog(
      {super.key, required this.rep, required this.task, required this.toast});

  final TaskRepository rep;
  final TaskData task;
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
          onPressed: () async {
            await rep
                .updateTask(task.copyWith(archieved: true).toCompanion(true));
            if (!context.mounted) return;
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
                            rep.updateTask(task
                                .copyWith(archieved: false)
                                .toCompanion(true));
                            FToast().removeCustomToast();
                          })
                    ],
                  ),
                ));
          },
        ),
        CupertinoDialogAction(
          child: const Text("Delete forever"),
          onPressed: () async {
            await rep.deleteTask(task.id);
            if (!context.mounted) return;
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
                            rep.addTask(task
                                .copyWith(archieved: false)
                                .toCompanion(true));
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
