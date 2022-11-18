import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/domain_layer/app_database.dart';
import 'package:to_do_app/utils/colors.dart';

class ListItem extends StatelessWidget {
  ListItem({super.key, required this.task});

  final TaskData task;
  final DateFormat formatter = DateFormat('dd.MM.yyyy');

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 3.0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "• ${task.title}",
            style: TextStyle(
                color: Color(green700),
                fontSize: 18,
                overflow: TextOverflow.clip),
            maxLines: 1,
          ),
          const SizedBox(height: 5),
          Text(
            "Due to: ${formatter.format(task.date)}",
            style: TextStyle(fontSize: 15, color: Color(grey700)),
          )
        ],
      ),
    );
  }
}
