class TopSpotResponse {
  bool? status;
  String? message;
  int? statusCode;
  List<TopSpot>? data;

  TopSpotResponse({this.status, this.message, this.statusCode, this.data});

  TopSpotResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <TopSpot>[];
      json['data'].forEach((v) {
        data!.add(new TopSpot.fromJson(v));
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

class TopSpot {
  int? zipCode;
  int? count;
  double? latitude;
  double? longitude;
  String? address;

  TopSpot(
      {this.zipCode, this.count, this.latitude, this.longitude, this.address});

  TopSpot.fromJson(Map<String, dynamic> json) {
    zipCode = json['zip_code'];
    count = json['count'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['zip_code'] = this.zipCode;
    data['count'] = this.count;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['address'] = this.address;
    return data;
  }
}
