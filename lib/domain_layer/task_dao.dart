import 'package:drift/drift.dart';
import 'package:to_do_app/domain_layer/app_database.dart';
import 'package:to_do_app/domain_layer/task.dart';

part 'task_dao.g.dart';

@DriftAccessor(tables: [Task])
class TaskDao extends DatabaseAccessor<AppDatabase> with _$TaskDaoMixin {
  TaskDao(super.attachedDatabase);

  addTask(TaskCompanion entry) {
    into(task).insert(entry);
  }

  Future updateTask(TaskCompanion entry) {
    return update(task).replace(entry);
  }

  Future deleteTask(int id) {
    return (delete(task)..where((tbl) => tbl.id.equals(id))).go();
  }

  Stream<List<TaskData>> watchUncompletedTasks() {
    return (select(task)
          ..where((tbl) {
            return tbl.completed.equals(false) & tbl.archieved.equals(false);
          })
          ..orderBy([(table) => OrderingTerm.desc(table.date)]))
        .watch();
  }

  Stream<List<TaskData>> watchCompletedTasks() {
    return (select(task)
          ..where((tbl) => tbl.completed.equals(true))
          ..orderBy([(table) => OrderingTerm.desc(table.date)]))
        .watch();
  }

  Stream<List<TaskData>> watchArchievedTasks() {
    return (select(task)
          ..where((tbl) => tbl.archieved.equals(true))
          ..orderBy([(table) => OrderingTerm.desc(table.date)]))
        .watch();
  }

  Future<List<TaskData>> searchTask(String entry) {
    return (select(task)
          ..where((tbl) =>
              tbl.title.like("%${entry}%") &
              tbl.archieved.equals(false) &
              tbl.completed.equals(false))
          ..orderBy([(table) => OrderingTerm.desc(table.date)]))
        .get();
  }
}
