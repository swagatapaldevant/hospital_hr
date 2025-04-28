class NoticeListModel {
  int? id;
  String? notice;
  String? description;
  String? priorityLevel;
  int? postBy;
  int? isActive;
  int? isDelete;
  String? createdAt;
  String? updatedAt;

  NoticeListModel(
      {this.id,
        this.notice,
        this.description,
        this.priorityLevel,
        this.postBy,
        this.isActive,
        this.isDelete,
        this.createdAt,
        this.updatedAt});

  NoticeListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    notice = json['notice'];
    description = json['description'];
    priorityLevel = json['priority_level'];
    postBy = json['post_by'];
    isActive = json['is_active'];
    isDelete = json['is_delete'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['notice'] = this.notice;
    data['description'] = this.description;
    data['priority_level'] = this.priorityLevel;
    data['post_by'] = this.postBy;
    data['is_active'] = this.isActive;
    data['is_delete'] = this.isDelete;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}