class AddNoticeModel {
  String? notice;
  String? description;
  String? priorityLevel;
  int? postBy;
  int? isActive;
  int? isDelete;
  String? updatedAt;
  String? createdAt;
  int? id;

  AddNoticeModel(
      {this.notice,
        this.description,
        this.priorityLevel,
        this.postBy,
        this.isActive,
        this.isDelete,
        this.updatedAt,
        this.createdAt,
        this.id});

  AddNoticeModel.fromJson(Map<String, dynamic> json) {
    notice = json['notice'];
    description = json['description'];
    priorityLevel = json['priority_level'];
    postBy = json['post_by'];
    isActive = json['is_active'];
    isDelete = json['is_delete'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notice'] = this.notice;
    data['description'] = this.description;
    data['priority_level'] = this.priorityLevel;
    data['post_by'] = this.postBy;
    data['is_active'] = this.isActive;
    data['is_delete'] = this.isDelete;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}