// 42. TodoListState and TodoList ChangeNotifier
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../models/todo_model.dart';

class TodoListState extends Equatable {
  final List<Todo> todos;
  const TodoListState({
    required this.todos,
  });

  factory TodoListState.initial() {
    return const TodoListState(todos: []);
    // return TodoListState(todos: [
    //   Todo(id: '1', desc: 'Clean the room'),
    //   Todo(id: '2', desc: 'Wash the dish'),
    //   Todo(id: '3', desc: 'Do homework'),
    // ]);
  }

  @override
  List<Object> get props => [todos];

  @override
  bool get stringify => true;


  // @override
  // String toString() {
  //   return 'aa TodoListState{todos: $todos}';
  // }

  TodoListState copyWith({
    List<Todo>? todos,
  }) {
    return TodoListState(
      todos: todos ?? this.todos,
    );
  }
}

class TodoList with ChangeNotifier {
  TodoListState _state = TodoListState.initial();
  TodoListState get state => _state;

  void addTodo(String todoDesc) {
    int? newNum;
    if(_state.todos.isEmpty){
      newNum = 1;
    } else {
      newNum = int.parse(_state.todos.last.id)+1;
    }
    final newTodo = Todo(id: newNum.toString(),desc: todoDesc);
    final newTodos = [..._state.todos, newTodo];

    _state = _state.copyWith(todos: newTodos);
    // debugPrint('added: ' + _state.toString());
    notifyListeners();
  }

  void editTodo(String id, String todoDesc) {
    final newTodos = _state.todos.map((Todo todo) {
      if (todo.id == id) {
        return Todo(
          id: id,
          desc: todoDesc,
          completed: todo.completed,
        );
      }
      return todo;
    }).toList();

    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }

  void toggleTodo(String id) {
    final newTodos = _state.todos.map((Todo todo) {
      if (todo.id == id) {
        return Todo(
          id: id,
          desc: todo.desc,
          completed: !todo.completed,
        );
      }
      return todo;
    }).toList();

    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }

  void removeTodo(Todo todo) {
    final newTodos = _state.todos.where((Todo t) => t.id != todo.id).toList();

    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }
}
