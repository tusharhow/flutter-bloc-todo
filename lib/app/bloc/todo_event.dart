part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {}

class TodoInitial extends TodoEvent {}

class TodoAdd extends TodoEvent {
  final String title;
  final String description;
  TodoAdd(this.title, this.description);
}

class TodoDelete extends TodoEvent {
  final String id;
  TodoDelete(this.id);
}

class TodoUpdate extends TodoEvent {
  final String id;
  final String title;
  final String description;
  TodoUpdate(this.id, this.title, this.description);
}

class FetchTodos extends TodoEvent {}
