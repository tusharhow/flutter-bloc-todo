import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_todo/app/bloc/todo_bloc.dart';
import 'package:flutter_bloc_todo/app/components/reusable_alert_dialog.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  final TextEditingController _todoTitleController = TextEditingController();
  final TextEditingController _todoDescriptionController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoInitialState) {
            BlocProvider.of<TodoBloc>(context).add(FetchTodos());
            return const SizedBox();
          } else if (state is TodoLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TodoLoadedState) {
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    BlocProvider.of<TodoBloc>(context)
                        .add(TodoDelete(state.todos[index].sId!));
                  },
                  background: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: Card(
                    child: ListTile(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ReusableAlertDialog(
                              id: state.todos[index].sId!,
                              isUpdate: true,
                              todoTitleController: _todoTitleController,
                              todoDescriptionController:
                                  _todoDescriptionController,
                            );
                          },
                        );
                      },
                      title: Text(
                        state.todos[index].title!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        state.todos[index].description!,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text('Error Occured'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return ReusableAlertDialog(
                id: '',
                isUpdate: false,
                todoTitleController: _todoTitleController,
                todoDescriptionController: _todoDescriptionController,
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
