class TodoModel {
  int? id;
  String? title;
  String? description;
  String? status;
  String? createdAt;
  String? dueDate;

  TodoModel(
      {this.id,
      this.title,
      this.description,
      this.status,
      this.createdAt,
      this.dueDate});

  /// To fetch from database/ API
  TodoModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['tittle'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    dueDate = json['due_date'];
  }

  /// To post or save in database/API
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tittle'] = title;
    data['description'] = description;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['due_date'] = dueDate;
    return data;
  }
}
