import 'package:todo_app/local_helper/databse_service.dart';
import 'package:todo_app/modals/todo_modal.dart';

class Source {
  final _dbHelper = DatabaseHelper.instance;

  Future<void> initDatabase() async {
    await _dbHelper.initDatabase();
  }

  Future<int> insertIntoDB(TodoModel todoModel) async {
    return _dbHelper.insert(todoModel.toJson());
  }

  Future<int> updateDB(TodoModel todoModel, int? id) async {
    return await _dbHelper.update(data: todoModel.toJson(), id: id!);
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    return await _dbHelper.queryAllRows();
  }

  Future<int> delete(int id) async {
    return await _dbHelper.delete(id);
  }
}
