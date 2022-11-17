import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:to_do_app/domain_layer/app_database.dart';
import 'package:to_do_app/domain_layer/task_repository.dart';
import 'package:to_do_app/home_page/home_page.dart';
import 'package:to_do_app/utils/colors.dart';

import 'add_page/add_page.dart';

void main(List<String> args) {
  runApp(const RootApp());
}

class RootApp extends StatelessWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(
          barBackgroundColor: Color(brown700),
          scaffoldBackgroundColor: Color(brown700),
          primaryContrastingColor: Color(brown500)),
      home: Builder(builder: (context) {
        //Injecting repositories
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
              create: (context) => AppDatabase.connect(),
            ),
            RepositoryProvider(
              create: (context) =>
                  TaskRepository(RepositoryProvider.of<AppDatabase>(context)),
            ),
            RepositoryProvider(
              create: (context) => FToast().init(context),
            )
          ],
          child: CupertinoTabScaffold(
            tabBar: CupertinoTabBar(
              activeColor: Color(blue),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home),
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.add),
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.archivebox),
                ),
              ],
              backgroundColor: Color(brown500),
            ),
            tabBuilder: (context, value) {
              late Widget page;
              if (value == 0) {
                page = HomePage();
              } else if (value == 1) {
                page = AddPage();
              } else if (value == 2) {
                page = LogScreen();
              }
              return page;
            },
          ),
        );
      }),
    );
  }
}

class LogScreen extends StatelessWidget {
  const LogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
    );
  }
}
