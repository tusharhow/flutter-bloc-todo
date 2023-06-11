part of 'todo_bloc.dart';

@immutable
abstract class TodoState {}

class TodoInitialState extends TodoState {}

class TodoLoadingState extends TodoState {}

class TodoLoadedState extends TodoState {
  final List<Todo> todos;
  TodoLoadedState(this.todos);
}
