import 'package:date_madly_app/models/profile_model.dart';

class LikeDislikeProfile {
  List<LikedDislikeProfile>? likedDislikeProfile;
  LikeDislikeProfile({this.likedDislikeProfile});

  LikeDislikeProfile.fromJson(Map<String, dynamic> json) {
    if (json['likedDislikeProfile'] != null) {
      likedDislikeProfile = <LikedDislikeProfile>[];
      json['likedDislikeProfile'].forEach((v) {
        likedDislikeProfile!.add(LikedDislikeProfile.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (likedDislikeProfile != null) {
      data['likedDislikeProfile'] =
          likedDislikeProfile!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LikedDislikeProfile {
  String? sId;
  String? userID;
  LikedID? likedID;
  int? status;
  int? iV;

  LikedDislikeProfile(
      {this.sId, this.userID, this.likedID, this.status, this.iV});

  LikedDislikeProfile.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userID = json['userID'];
    likedID =
        json['likedID'] != null ? LikedID.fromJson(json['likedID']) : null;
    status = json['status'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userID'] = userID;
    if (likedID != null) {
      data['likedID'] = likedID!.toJson();
    }
    data['status'] = status;
    data['__v'] = iV;
    return data;
  }
}

class LikedID {
  String? sId;
  String? name;
  List<String>? deviceTokens;
  List<String>? images;
  int? profileScore;
  int? phoneNo;
  String? gender;
  String? dob;
  int? height;
  String? live;
  String? relationStatus;
  String? degree;
  String? designation;
  String? company;
  String? income;
  List<String>? describe;
  int? visibility;
  int? spark;
  String? createdAt;
  String? updatedAt;
  int? iV;
  BasicInfo? basicInfo;
  int? isOnline;

  LikedID(
      {this.sId,
      this.name,
      this.deviceTokens,
      this.images,
      this.profileScore,
      this.phoneNo,
      this.gender,
      this.dob,
      this.height,
      this.live,
      this.relationStatus,
      this.degree,
      this.designation,
      this.company,
      this.income,
      this.describe,
      this.visibility,
      this.spark,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.basicInfo,
      this.isOnline});

  LikedID.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    if (json['device_tokens'] != null) {
      deviceTokens = json['device_tokens'].cast<String?>();
    }
    images = json['images'].cast<String>();
    profileScore = json['profileScore'];
    phoneNo = json['phoneNo'];
    gender = json['gender'];
    dob = json['dob'];
    height = json['height'];
    live = json['live'];
    relationStatus = json['relationStatus'];
    degree = json['degree'];
    designation = json['designation'];
    company = json['company'];
    income = json['income'];
    if (json['describe'] != null) {
      describe = json['describe'].cast<String>();
    }

    visibility = json['visibility'];
    spark = json['spark'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    basicInfo = json['basic_Info'] != null
        ? BasicInfo.fromJson(json['basic_Info'])
        : null;
    isOnline = json['isOnline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['device_tokens'] = deviceTokens;
    data['images'] = images;
    data['profileScore'] = profileScore;
    data['phoneNo'] = phoneNo;
    data['gender'] = gender;
    data['dob'] = dob;
    data['height'] = height;
    data['live'] = live;
    data['relationStatus'] = relationStatus;
    data['degree'] = degree;
    data['designation'] = designation;
    data['company'] = company;
    data['income'] = income;
    data['describe'] = describe;
    data['visibility'] = visibility;
    data['spark'] = spark;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    if (basicInfo != null) {
      data['basic_Info'] = basicInfo!.toJson();
    }
    data['isOnline'] = isOnline;
    return data;
  }
}

// class BasicInfo {
//   String? sId;
//   String? sunSign;

//   BasicInfo({this.sId, this.sunSign});

//   BasicInfo.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     sunSign = json['sun_sign'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = sId;
//     data['sun_sign'] = sunSign;
//     return data;
//   }
// }
