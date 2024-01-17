class FishResponse {
  bool? status;
  String? message;
  int? statusCode;
  List<FishData>? data;

  FishResponse({this.status, this.message, this.statusCode, this.data});

  FishResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <FishData>[];
      json['data'].forEach((v) {
        data!.add(new FishData.fromJson(v));
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

class FishData {
  int? id;
  int? catId;
  String? localName;
  String? scientificName;
  String? fishImage;
  String? legalSize;
  String? info;
  String? conservationStatus;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? categoryName;

  FishData(
      {this.id,
      this.catId,
      this.localName,
      this.scientificName,
      this.fishImage,
      this.legalSize,
      this.info,
      this.conservationStatus,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.categoryName});

  FishData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catId = json['cat_id'];
    localName = json['local_name'];
    scientificName = json['scientific_name'];
    fishImage = json['fish_image'];
    legalSize = json['legal_size'];
    info = json['info'];
    conservationStatus = json['conservation_status'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cat_id'] = this.catId;
    data['local_name'] = this.localName;
    data['scientific_name'] = this.scientificName;
    data['fish_image'] = this.fishImage;
    data['legal_size'] = this.legalSize;
    data['info'] = this.info;
    data['conservation_status'] = this.conservationStatus;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['category_name'] = this.categoryName;
    return data;
  }
}
