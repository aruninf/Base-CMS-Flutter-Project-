class AdsResponse {
  bool? status;
  String? message;
  int? statusCode;
  List<AdData>? data;

  AdsResponse({this.status, this.message, this.statusCode, this.data});

  AdsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <AdData>[];
      json['data'].forEach((v) {
        data!.add(new AdData.fromJson(v));
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

class AdData {
  int? id;
  String? businessName;
  int? category;
  String? adSaleAmt;
  String? link;
  String? startDate;
  String? endDate;
  String? adImg;
  int? status;
  String? createdAt;
  String? updatedAt;

  AdData(
      {this.id,
      this.businessName,
      this.category,
      this.adSaleAmt,
      this.link,
      this.startDate,
      this.endDate,
      this.adImg,
      this.status,
      this.createdAt,
      this.updatedAt});

  AdData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessName = json['business_name'];
    category = json['category'];
    adSaleAmt = json['ad_sale_amt'];
    link = json['link'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    adImg = json['ad_img'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['business_name'] = this.businessName;
    data['category'] = this.category;
    data['ad_sale_amt'] = this.adSaleAmt;
    data['link'] = this.link;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['ad_img'] = this.adImg;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
