import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_cubit/Todo_model.dart';

class TodoCubit extends Cubit<List<Todo>> {
  TodoCubit() : super([]);
  void add(String task) {
    var newlist = List<Todo>.from(state)..add(
      Todo(id: DateTime.now().microsecondsSinceEpoch.toString(), task: task),
    );
    emit(newlist);
  }

  void delet(String id) {
    var newlist = state.where((todo) => todo.id != id).toList();
    emit(newlist);
  }

  void done(String id) {
    var tobedone =
        state.map((todo) {
          if (todo.id == id) {
            return todo.modified(Done: !todo.done);
          }
          return todo;
        }).toList();
    emit(tobedone);
  }
}
