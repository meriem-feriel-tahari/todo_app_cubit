import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_cubit/Cubit/todo_cubit.dart';

class Todolist extends StatelessWidget {
  const Todolist({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubit, List<String>>(
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: state.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    height: 60,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    child: Text("${state[index]}"),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    addtask(context);
                  },

                  // backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Icon(Icons.add),
                ),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: 10),
          ],
        );
      },
    );
  }

  void addtask(BuildContext context) {
    TextEditingController task = TextEditingController();
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Add new task", textAlign: TextAlign.center),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  final tk = task.text.trim();
                  if (tk.isNotEmpty) {
                    context.read<TodoCubit>().add(tk);
                    Navigator.of(context).pop();
                  }
                },
                child: Text("Add"),
              ),
            ],
            content: TextField(controller: task),
          ),
    );
  }
}
