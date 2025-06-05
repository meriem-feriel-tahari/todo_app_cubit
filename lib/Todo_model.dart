class Todo {
  String id;
  String task;
  bool done = false;
  Todo({required this.id, required this.task, this.done = false});
  Todo modified({String? Id, String? Task, bool? Done}) {
    return Todo(
      id: Id ?? this.id,
      task: Task ?? this.task,
      done: Done ?? this.done,
    );
  }
  
}
