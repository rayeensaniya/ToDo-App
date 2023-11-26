import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:todo_app/modals/todo_modal.dart';
import 'package:todo_app/repository/repository.dart';

class DashboardBloc {
  final _repository = Repository();

  final isChecked = BehaviorSubject<bool>.seeded(false);
  final isHideFab = BehaviorSubject<bool>.seeded(false);
  final pendingTodoList = BehaviorSubject<List<TodoModel>>();
  final completedTodo = BehaviorSubject<List<TodoModel>>();

  void fetchData() async {
    /// Fetching Notes From database
    await _repository.fetchData().then((value) {
      // value.sort((a,b)=>DateTime.parse(a.createdAt!).compareTo(DateTime.parse(b.createdAt!)));
      final completed = value
          .where((element) => element.status?.toLowerCase() == 'completed')
          .toList();
      completedTodo.add(completed);
      final pending = value
          .where((element) => element.status?.toLowerCase() != 'completed')
          .toList();
      pendingTodoList.add(pending);
    });
  }

  Future<void> delete(int id) async {
    await _repository.delete(id);
  }

  Future<int> updateDB(int? id, TodoModel todoModel) async {
    return await _repository.updateDB(id, todoModel);
  }
}

///how to sort list by created date

/// StreamBuilder() --->> Inbuilt flutter widget (Listener of streams)
/// Stream -->> Act as a pipeline, we can add data from one side and listener will listen and update the widget
