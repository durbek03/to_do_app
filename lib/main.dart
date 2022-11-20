import 'package:event_bus/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:to_do_app/archive_page/archive_page.dart';
import 'package:to_do_app/domain_layer/app_database.dart';
import 'package:to_do_app/domain_layer/task_repository.dart';
import 'package:to_do_app/global_events.dart';
import 'package:to_do_app/home_page/home_page.dart';
import 'package:to_do_app/utils/colors.dart';

import 'add_page/add_page.dart';

void main(List<String> args) {
  runApp(RootApp());
}

class RootApp extends StatelessWidget {
  RootApp({Key? key}) : super(key: key);

  final tabController = CupertinoTabController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => AppDatabase.connect(),
          ),
          RepositoryProvider(
            create: (context) => EventBus(),
          ),
          RepositoryProvider(
            create: (context) =>
                TaskRepository(RepositoryProvider.of<AppDatabase>(context)),
          ),
          RepositoryProvider(
            create: (context) => FToast().init(context),
          )
        ],
        child: Builder(builder: (context) {
          var eventBus = RepositoryProvider.of<EventBus>(context);
          eventBus.on<NavigateToHomeEvent>().listen((event) {
            tabController.index = 0;
            currentIndex = 0;
            eventBus.fire(ClearAddPageDataEvent());
          });

          return CupertinoTabScaffold(
            controller: tabController,
            resizeToAvoidBottomInset: false,
            tabBar: CupertinoTabBar(
              onTap: (value) {
                FToast().removeCustomToast();
                if (currentIndex == 1 && value != 1) {
                  eventBus.fire(ClearAddPageDataEvent());
                }
                currentIndex = value;
              },
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
                page = const ArchivePage();
              }
              return page;
            },
          );
        }),
      ),
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
