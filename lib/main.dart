import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_cubit/Cubit/themecubit.dart';
import 'package:todo_app_cubit/Cubit/todo_cubit.dart';
import 'package:todo_app_cubit/Todo_model.dart';
import 'package:todo_app_cubit/todolist.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => Themecubit()),
        BlocProvider(create: (context) => TodoCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Themecubit, bool>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // brightness: Brightness.light,
            colorScheme: ColorScheme.light(
              primary: Colors.pink.shade400,
              secondary: Colors.pink.shade300,
              onPrimary: Colors.pink.shade100,
            ),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            colorScheme: ColorScheme.dark(
              primary: const Color.fromRGBO(194, 24, 91, 1),
              secondary: Colors.pink.shade600,
              onPrimary: Colors.pink.shade200,
            ),
            useMaterial3: true,
          ),
          themeMode: state ? ThemeMode.dark : ThemeMode.light,
          home: Myhomepage(),
        );
      },
    );
  }
}

class Myhomepage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text("TO DO", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.read<Themecubit>().toggle();
            },
            icon: Icon(Icons.dark_mode, color: Colors.white),
          ),
        ],
      ),
      body: BlocBuilder<TodoCubit, List<Todo>>(
        builder: (context, state) {
          return Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child:
                        state.length == 0
                            ? Image.asset(
                              "assets/task2.png",
                              filterQuality: FilterQuality.high,
                              alignment: Alignment(0.35, 0),
                            )
                            : ListView.builder(
                              itemCount: state.length,
                              itemBuilder: (context, index) {
                                if (state.isNotEmpty) {
                                  return Todolist(task: state[index]);
                                }
                              },
                            ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment(0.9, 0.95),
                child: FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    addtask(context);
                  },
                ),
              ),
            ],
          );
        },
      ),
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
