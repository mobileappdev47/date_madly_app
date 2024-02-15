class UserModel {
  User? user;
  String? jwtToken;
  UserModel({this.user});

  UserModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    jwtToken = json['jwtToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['jwtToken'] = jwtToken;
    return data;
  }
}

class User {
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
  String? sId;
  String? jwtToken;
  String? createdAt;
  String? updatedAt;
  int? iV;

  User(
      {this.name,
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
      this.sId,
      this.jwtToken,
      this.createdAt,
      this.updatedAt,
      this.iV});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    deviceTokens = json['device_tokens'].cast<String>();
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
    describe = json['describe'].cast<String>();
    visibility = json['visibility'];
    spark = json['spark'];
    sId = json['_id'];
    jwtToken = json['jwtToken'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    data['_id'] = sId;
    data['jwtToken'] = jwtToken;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
