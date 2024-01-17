class DashboardResponse {
  bool? status;
  String? message;
  int? statusCode;
  DashboardData? data;

  DashboardResponse({this.status, this.message, this.statusCode, this.data});

  DashboardResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
    data =
        json['data'] != null ? new DashboardData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['status_code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DashboardData {
  int? totalUsers;
  int? totalDownloads;
  int? totalAdsRevenue;
  int? totalFish;
  int? mostTaggedFish;

  DashboardData(
      {this.totalUsers,
      this.totalDownloads,
      this.totalAdsRevenue,
      this.totalFish,
      this.mostTaggedFish});

  DashboardData.fromJson(Map<String, dynamic> json) {
    totalUsers = json['total_users'];
    totalDownloads = json['total_downloads'];
    totalAdsRevenue = json['total_ads_revenue'];
    totalFish = json['total_fish'];
    mostTaggedFish = json['most_tagged_fish'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_users'] = this.totalUsers;
    data['total_downloads'] = this.totalDownloads;
    data['total_ads_revenue'] = this.totalAdsRevenue;
    data['total_fish'] = this.totalFish;
    data['most_tagged_fish'] = this.mostTaggedFish;
    return data;
  }
}
