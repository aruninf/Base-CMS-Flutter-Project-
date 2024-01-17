class LoginResponse {
  bool? status;
  String? message;
  int? statusCode;
  UserLogin? data;
  String? token;

  LoginResponse(
      {this.status, this.message, this.statusCode, this.data, this.token});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
    data = json['data'] != null ? UserLogin.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['status_code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class UserLogin {
  int? id;
  String? userType;
  String? name;
  String? handle;
  String? email;
  String? dob;
  String? gender;
  String? phoneNumber;
  String? profilePic;
  int? status;
  String? createdAt;
  String? updatedAt;

  UserLogin(
      {this.id,
      this.userType,
      this.name,
      this.handle,
      this.email,
      this.dob,
      this.gender,
      this.phoneNumber,
      //this.profilePic,
      this.status,
      this.createdAt,
      this.updatedAt});

  UserLogin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['user_type'];
    name = json['name'];
    handle = json['handle'];
    email = json['email'];
    dob = json['dob'];
    gender = json['gender'];
    phoneNumber = json['phone_number'];
    //profilePic = json['profile_pic'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_type'] = this.userType;
    data['name'] = this.name;
    data['handle'] = this.handle;
    data['email'] = this.email;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['phone_number'] = this.phoneNumber;
    //data['profile_pic'] = this.profilePic;

    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
