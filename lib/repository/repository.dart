import 'package:todo_app/source/source.dart';

import '../modals/todo_modal.dart';

class Repository {
  final _source = Source();

  Future<void> initDatabase() async {
    await _source.initDatabase().then(
          (value) => Future.value(),
        );
  }

  Future<int> insertIntoDB(TodoModel todoModel) async {
    return _source.insertIntoDB(todoModel);
  }

  Future<List<TodoModel>> fetchData() async {
    List<TodoModel> todList = [];
    await _source.fetchData().then((value) {
      /// Looping list to add in model
      for (var v in value) {
        final todo = TodoModel.fromJson(v);
        todList.add(todo);
      }
    });

    /// return todo List
    return todList;
  }

  Future<int> delete(int id) async {
    return await _source.delete(id).then((value) => Future.value(value));
  }

  Future<int> updateDB(int? id, TodoModel todoModel) async {
    return await _source
        .updateDB(todoModel, id!)
        .then((value) => Future.value(value));
  }
}
