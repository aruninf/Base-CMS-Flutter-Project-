class InboxResponse {
  bool? status;
  String? message;
  int? statusCode;
  List<InboxData>? data;

  InboxResponse({this.status, this.message, this.statusCode, this.data});

  InboxResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <InboxData>[];
      json['data'].forEach((v) {
        data!.add(new InboxData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['status_code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InboxData {
  int? id;
  String? name;
  String? email;
  String? comments;
  int? status;
  String? createdAt;
  String? updatedAt;

  InboxData(
      {this.id,
      this.name,
      this.email,
      this.comments,
      this.status,
      this.createdAt,
      this.updatedAt});

  InboxData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    comments = json['comments'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['comments'] = this.comments;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
