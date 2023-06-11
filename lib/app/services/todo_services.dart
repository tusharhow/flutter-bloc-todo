import 'package:dio/dio.dart';
import 'package:flutter_bloc_todo/app/constants/api_constants.dart';
import 'package:flutter_bloc_todo/app/models/todo.dart';

class TodoServicces {
  final Dio _dio = Dio();

  Future<List<Todo>> getTodos() async {
    try {
      Response response = await _dio.get(
        '$BASE_URL/v1/todos',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> result = response.data;
        print(result);
        return List<Todo>.from(
            result['items'].map((todo) => Todo.fromJson(todo)));
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<bool> addTodos(String title, String description) async {
    try {
      Response response = await _dio.post(
        '$BASE_URL/v1/todos',
        data: {
          'title': title,
          'description': description,
          'is_completed': true,
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );
      return response.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteTodos(String id) async {
    try {
      Response response = await _dio.delete(
        '$BASE_URL/v1/todos/$id',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );
      return response.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateTodos(String id, String title, String description) async {
    try {
      Response response = await _dio.put(
        '$BASE_URL/v1/todos/$id',
        data: {
          'title': title,
          'description': description,
          'is_completed': false,
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );
      return response.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
