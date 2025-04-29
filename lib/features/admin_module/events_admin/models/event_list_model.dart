class EventListModel {
  int? id;
  String? event;
  String? description;
  String? eventDate;
  int? postBy;
  int? isActive;
  int? isDelete;
  String? createdAt;
  String? updatedAt;

  EventListModel(
      {this.id,
        this.event,
        this.description,
        this.eventDate,
        this.postBy,
        this.isActive,
        this.isDelete,
        this.createdAt,
        this.updatedAt});

  EventListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    event = json['event'];
    description = json['description'];
    eventDate = json['event_date'];
    postBy = json['post_by'];
    isActive = json['is_active'];
    isDelete = json['is_delete'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['event'] = this.event;
    data['description'] = this.description;
    data['event_date'] = this.eventDate;
    data['post_by'] = this.postBy;
    data['is_active'] = this.isActive;
    data['is_delete'] = this.isDelete;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}