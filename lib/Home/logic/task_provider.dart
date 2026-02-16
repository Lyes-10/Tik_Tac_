import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class Task {
  final String title;
  final DateTime? date;
  final bool isFlagged;
  final bool isDone;

  Task({
    required this.title,
    this.date,
    this.isFlagged = false,
    this.isDone = false,
  });

  Task copyWith({
    String? title,
    DateTime? date,
    bool? isFlagged,
    bool? isDone,
  }) {
    return Task(
      title: title ?? this.title,
      date: date ?? this.date,
      isFlagged: isFlagged ?? this.isFlagged,
      isDone: isDone ?? this.isDone,
    );
  }
}

class TaskList extends StateNotifier<List<Task>> {
  TaskList() : super([]);

  void addTask(Task task) {
    state = [...state, task];
  }

  void toggleDone(int index) {
    final updated = state[index].copyWith(isDone: !state[index].isDone);
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index) updated else state[i],
    ];
  }
}

final taskListProvider = StateNotifierProvider<TaskList, List<Task>>((ref) => TaskList());
