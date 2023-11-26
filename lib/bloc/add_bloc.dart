import 'package:todo_app/bloc/dashboard_bloc.dart';

import '../local_helper/databse_service.dart';
import '../modals/todo_modal.dart';

class AddScreenBloc {
  final _dbHelper = DatabaseHelper.instance;
  final _dashBloc = DashboardBloc();

  String? titleValidator({String? title}) {
    if (title == null || title.trim().isEmpty) {
      return 'Title should not be empty';
    }
    return null;
  }

  Future<int> insertIntoDB(TodoModel todoModel) async {
    return _dbHelper.insert(todoModel.toJson());
  }

  Future<int> updateDB(int id, TodoModel todoModel) async {
    return await _dashBloc.updateDB(id, todoModel);
  }
}
