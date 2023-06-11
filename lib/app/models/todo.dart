class Todo {
  String? sId;
  String? title;
  String? description;
  bool? isCompleted;
  String? createdAt;
  String? updatedAt;

  Todo(
      {this.sId,
      this.title,
      this.description,
      this.isCompleted,
      this.createdAt,
      this.updatedAt});

  Todo.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    isCompleted = json['is_completed'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['is_completed'] = this.isCompleted;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
