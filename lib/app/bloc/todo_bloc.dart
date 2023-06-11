import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_todo/app/models/todo.dart';
import 'package:flutter_bloc_todo/app/services/todo_services.dart';
import 'package:meta/meta.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoServicces _todoServicces = TodoServicces();

  List<Todo> todos = [];

  TodoBloc() : super(TodoInitialState()) {
    // add todo and update todo
    on<TodoAdd>((event, emit) async {
      emit(TodoLoadingState());
      await _todoServicces.addTodos(event.title, event.description);
      List<Todo> todos = await _todoServicces.getTodos();
      emit(TodoLoadedState(todos));
    });
    // get all todos
    on<FetchTodo>((event, emit) async {
      emit(TodoLoadingState());
      List<Todo> todos = await _todoServicces.getTodos();
      emit(TodoLoadedState(todos));
    });
    // delete todo
    on<TodoDelete>((event, emit) async {
      emit(TodoLoadingState());
      bool isDeleted = await _todoServicces.deleteTodos(event.id);
      if (isDeleted) {
        List<Todo> todos = await _todoServicces.getTodos();
        emit(TodoLoadedState(todos));
      } else {
        emit(TodoLoadedState(todos));
      }
    });
    // update todo
    on<TodoUpdate>((event, emit) async {
      emit(TodoLoadingState());
      await _todoServicces.updateTodos(
          event.id, event.title, event.description);
      List<Todo> todos = await _todoServicces.getTodos();
      emit(TodoLoadedState(todos));
    });
  }
}
