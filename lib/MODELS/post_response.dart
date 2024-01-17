class PostResponse {
  bool? status;
  String? message;
  int? statusCode;
  List<PostData>? data;

  PostResponse({this.status, this.message, this.statusCode, this.data});

  PostResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <PostData>[];
      json['data'].forEach((v) {
        data!.add(new PostData.fromJson(v));
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

class PostData {
  int? id;
  int? userId;
  int? locationId;
  int? isPublic;
  String? latitude;
  String? longitude;
  String? address;
  //String? tagFish;
  String? image;
  String? caption;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? userName;
  String? userHandle;
  String? locationName;

  PostData(
      {this.id,
      this.userId,
      this.locationId,
      this.isPublic,
      this.latitude,
      this.longitude,
      this.address,
      //this.tagFish,
      this.image,
      this.caption,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.userName,
      this.userHandle,
      this.locationName});

  PostData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    locationId = json['location_id'];
    isPublic = json['isPublic'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
    //tagFish = json['tag_fish'];
    image = json['image'];
    caption = json['caption'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userName = json['user_name'];
    userHandle = json['user_handle'];
    locationName = json['location_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['location_id'] = this.locationId;
    data['isPublic'] = this.isPublic;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['address'] = this.address;
    //data['tag_fish'] = this.tagFish;
    data['image'] = this.image;
    data['caption'] = this.caption;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_name'] = this.userName;
    data['user_handle'] = this.userHandle;
    data['location_name'] = this.locationName;
    return data;
  }
}
