import 'dart:io';
import 'dart:isolate';

import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:to_do_app/domain_layer/task.dart';
import 'package:path/path.dart' as p;
import 'package:to_do_app/domain_layer/task_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Task], daos: [TaskDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase.connect()
      : super.connect(AppDatabase.createDriftIsolateAndConnect());

  static DatabaseConnection createDriftIsolateAndConnect() {
    return DatabaseConnection.delayed(Future.sync(() async {
      final isolate = await _createDriftIsolate();
      return await isolate.connect();
    }));
  }

  static Future<DriftIsolate> _createDriftIsolate() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = p.join(dir.path, 'appDatabase');
    final receivePort = ReceivePort();
    await Isolate.spawn(_startBackground, [path, receivePort.sendPort]);

    return await receivePort.first as DriftIsolate;
  }

  static void _startBackground(List args) {
    final path = args[0] as String;
    final sendPort = args[1] as SendPort;

    final executor = NativeDatabase(File(path));

    var isolate =
        DriftIsolate.inCurrent(() => DatabaseConnection(executor));
    sendPort.send(isolate);
  }

  @override
  int get schemaVersion => 1;
}

class _IsolateStartRequest {
  final SendPort sendDriftIsolate;
  final String targetPath;

  _IsolateStartRequest(this.sendDriftIsolate, this.targetPath);
}
