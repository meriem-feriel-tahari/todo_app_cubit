import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_cubit/Cubit/todo_cubit.dart';
import 'package:todo_app_cubit/Todo_model.dart';

class Todolist extends StatelessWidget {
  Todo task;
  Todolist({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        tileColor: Theme.of(context).colorScheme.secondary,
        leading: Checkbox(
          value: task.done,
          onChanged: (value) {
            context.read<TodoCubit>().done(task.id);
          },
        ),
        title: Text(
          task.task,
          style: TextStyle(
            decoration: task.done ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            showdelete(context, task.id);

            // context.read<TodoCubit>().delet();
          },
        ),
      ),
    );
  }

  void showdelete(BuildContext context, String id) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Remove this task?", textAlign: TextAlign.center),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.read<TodoCubit>().delet(task.id);
                },
                child: Text("Remove"),
              ),
            ],
          ),
    );
  }

  // void addtask(BuildContext context) {
  //   TextEditingController task = TextEditingController();
  //   showDialog(
  //     context: context,
  //     builder:
  //         (context) => AlertDialog(
  //           title: Text("Add new task", textAlign: TextAlign.center),
  //           actions: [
  //             ElevatedButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: Text("Cancel"),
  //             ),
  //             ElevatedButton(
  //               onPressed: () {
  //                 final tk = task.text.trim();

  //                 if (tk.isNotEmpty) {
  //                   context.read<TodoCubit>().add(tk);
  //                   Navigator.of(context).pop();
  //                 }
  //               },
  //               child: Text("Add"),
  //             ),
  //           ],
  //           content: TextField(controller: task),
  //         ),
  //   );
  // }
}
