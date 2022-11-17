import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/home_page/home_page.dart';

void main(List<String> args) {
  runApp(const RootApp());
}

class RootApp extends StatelessWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.add),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.archivebox),
          ),
        ]),
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
  }
}

class AddPage extends StatelessWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CupertinoSearchTextField(),
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
