class LocationDataModel {
  String? message;
  List<LocationModel>? alllocations;

  LocationDataModel({this.message, this.alllocations});

  LocationDataModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['alllocations'] != null) {
      alllocations = <LocationModel>[];
      json['alllocations'].forEach((v) {
        alllocations!.add(new LocationModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.alllocations != null) {
      data['alllocations'] = this.alllocations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LocationModel {
  int? id;
  String? title;
  String? latitude;
  String? longtude;
  int? status;
  String? tagColor;
  double? distance;

  LocationModel(
      {this.id,
      this.title,
      this.latitude,
      this.longtude,
      this.status,
      this.tagColor,
      this.distance});

  LocationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    latitude = json['latitude'];
    longtude = json['longtude'];
    status = json['status'];
    tagColor = json['tag_color'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['latitude'] = this.latitude;
    data['longtude'] = this.longtude;
    data['status'] = this.status;
    data['tag_color'] = this.tagColor;
    data['distance'] = this.distance;
    return data;
  }
}
