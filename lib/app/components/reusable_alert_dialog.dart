import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_todo/app/bloc/todo_bloc.dart';

class ReusableAlertDialog extends StatelessWidget {
  ReusableAlertDialog({
    super.key,
    required TextEditingController todoTitleController,
    required TextEditingController todoDescriptionController,
    required this.id,
    required this.isUpdate,
  })  : _todoTitleController = todoTitleController,
        _todoDescriptionController = todoDescriptionController;

  final TextEditingController _todoTitleController;
  final TextEditingController _todoDescriptionController;
  final String id;
  bool isUpdate = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isUpdate ? 'Update Todo' : 'Add Todo'),
      content: SizedBox(
        height: 150,
        child: Column(
          children: [
            TextField(
              controller: _todoTitleController,
              decoration: const InputDecoration(
                hintText: 'Enter Todo Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _todoDescriptionController,
              decoration: const InputDecoration(
                hintText: 'Enter Todo Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (isUpdate) {
              BlocProvider.of<TodoBloc>(context).add(
                TodoUpdate(
                  id,
                  _todoTitleController.text,
                  _todoDescriptionController.text,
                ),
              );
              Navigator.pop(context);
            } else {
              BlocProvider.of<TodoBloc>(context).add(
                TodoAdd(
                  _todoTitleController.text,
                  _todoDescriptionController.text,
                ),
              );
              Navigator.pop(context);
            }
          },
          child: Text(isUpdate ? 'Update Todo' : 'Add Todo'),
        ),
      ],
    );
  }
}
