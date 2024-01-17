class ContentResponse {
  bool? status;
  String? message;
  int? statusCode;
  List<ContentData>? data;

  ContentResponse({this.status, this.message, this.statusCode, this.data});

  ContentResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <ContentData>[];
      json['data'].forEach((v) {
        data!.add(ContentData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['status_code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContentData {
  int? id;
  String? tableType;
  String? content;
  int? status;
  String? createdAt;
  String? updatedAt;

  ContentData(
      {this.id,
      this.tableType,
      this.content,
      this.status,
      this.createdAt,
      this.updatedAt});

  ContentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tableType = json['table_type'];
    content = json['content'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['table_type'] = this.tableType;
    data['content'] = this.content;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
