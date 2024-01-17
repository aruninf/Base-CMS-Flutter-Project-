class MapKeyResponse {
  bool? status;
  String? message;
  int? statusCode;
  String? data;

  MapKeyResponse({this.status, this.message, this.statusCode, this.data});

  MapKeyResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['status_code'] = this.statusCode;
    data['data'] = this.data;
    return data;
  }
}
