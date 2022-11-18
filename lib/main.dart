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
      theme: CupertinoThemeData(),
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
            resizeToAvoidBottomInset: false,
            tabBar: CupertinoTabBar(
              height: 80,
              backgroundColor: Color(bottomNavBarColor),
              activeColor: Color(green),
              items: [
                _getBottomNavItem(
                    Image.asset(
                      'lib/assets/to_do_list.png',
                      width: 25,
                      height: 25,
                      color: Color(grey700),
                    ),
                    "Tasks",
                    Image.asset(
                      'lib/assets/to_do_list.png',
                      width: 25,
                      height: 25,
                      color: Color(green),
                    )),
                _getBottomNavItem(
                    const Icon(
                      Icons.addchart,
                      size: 25,
                    ),
                    "Add task"),
                _getBottomNavItem(
                  Image.asset(
                    'lib/assets/archive.png',
                    width: 25,
                    height: 25,
                    color: Color(grey700),
                  ),
                  "Archive",
                  Image.asset(
                    'lib/assets/archive.png',
                    width: 25,
                    height: 25,
                    color: Color(green),
                  ),
                )
              ],
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

  BottomNavigationBarItem _getBottomNavItem(Widget icon, String title,
      [Widget? activeIcon]) {
    return BottomNavigationBarItem(
      activeIcon: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          activeIcon ?? icon,
          Text(
            title,
            style: const TextStyle(fontSize: 15),
          )
        ],
      ),
      icon: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          Text(
            title,
            style: const TextStyle(fontSize: 15),
          )
        ],
      ),
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
