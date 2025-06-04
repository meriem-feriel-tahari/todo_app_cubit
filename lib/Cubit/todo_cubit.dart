import 'package:flutter_bloc/flutter_bloc.dart';

class TodoCubit extends Cubit<List<String>> {
  TodoCubit() : super([]);
  void add(String task) {
    var newlist = List<String>.from(state)..add(task);
    emit(newlist);
  }

  void delet(int index) {
    var newlist = List<String>.from(state)..removeAt(index);
    emit(newlist);
  }
}
