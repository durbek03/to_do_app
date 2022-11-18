part of 'home_page_bloc.dart';

@immutable
abstract class HomePageEvent {}

class SearchEvent extends HomePageEvent {
  final String query;
  SearchEvent(this.query);
}

class SearchCollapseChangeEvent extends HomePageEvent {
  final bool collapsed;
  SearchCollapseChangeEvent(this.collapsed);
}

class TaskUpdateEvent extends HomePageEvent {
  final TaskData task;
  TaskUpdateEvent(this.task);
}

class TaskDeleteEvent extends HomePageEvent {
  final int id;
  TaskDeleteEvent(this.id);
}

class TaskAddEvent extends HomePageEvent {
  final TaskData task;
  TaskAddEvent(this.task);
}

class NewTasksEvent extends HomePageEvent {
  final List<TaskData> list;
  NewTasksEvent(this.list);
}