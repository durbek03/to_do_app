import 'package:drift/drift.dart';

class Task extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1)();
  TextColumn get description => text().withLength(min: 1)();
  DateTimeColumn get date => dateTime()();
  BoolColumn get completed => boolean().withDefault(const Constant(false))();
  BoolColumn get archieved => boolean().withDefault(const Constant(false))();
}
