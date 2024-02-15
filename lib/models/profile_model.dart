class ProfileModel {
  List<Profile>? profile;

  ProfileModel({this.profile});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    if (json['profile'] != null) {
      profile = <Profile>[];
      json['profile'].forEach((v) {
        profile!.add(Profile.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profile != null) {
      data['profile'] = profile!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Profile {
  String? sId;
  String? name;
  List<String>? images;
  String? dob;
  int? height;
  String? live;
  String? degree;
  String? designation;
  String? income;
  String? company;
  String? email;
  int? phoneNo;
  String? gender;
  BasicInfo? basicInfo;

  Profile(
      {this.sId,
      this.name,
      this.images,
      this.dob,
      this.height,
      this.live,
      this.degree,
      this.designation,
      this.income,
      this.company,
      this.email,
      this.phoneNo,
      this.gender,
      this.basicInfo});

  Profile.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    if (json['images'] != null) {
      images = json['images'].cast<String>();
    }
    dob = json['dob'];
    height = json['height'];
    degree = json['degree'];
    designation = json['designation'];
    live = json['live'];
    income = json['income'];
    company = json['company'];
    phoneNo = json['phoneNo'];
    email = json['email'];
    gender = json['gender'];
    basicInfo = json['basic_Info'] != null
        ? BasicInfo.fromJson(json['basic_Info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['images'] = images;
    data['dob'] = dob;
    data['height'] = height;
    data['live'] = live;
    data['degree'] = degree;
    data['designation'] = designation;
    data['income'] = income;
    data['company'] = company;
    data['email'] = email;
    data['phoneNo'] = phoneNo;
    data['gender'] = gender;
    if (basicInfo != null) {
      data['basic_Info'] = basicInfo!.toJson();
    }
    return data;
  }
}

class BasicInfo {
  String? sId;
  String? userID;
  String? sunSign;
  String? favCuisine;
  String? political;
  String? lookingFor;
  String? personality;
  String? firstDate;
  String? drink;
  String? smoke;
  String? religion;
  String? favPastime;
  String? createdAt;
  String? updatedAt;
  int? iV;

  BasicInfo(
      {this.sId,
      this.userID,
      this.sunSign,
      this.favCuisine,
      this.political,
      this.lookingFor,
      this.personality,
      this.drink,
      this.smoke,
      this.religion,
      this.favPastime,
      this.firstDate,
      this.createdAt,
      this.updatedAt,
      this.iV});

  BasicInfo.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userID = json['user'];
    sunSign = json['sun_sign'];
    favCuisine = json['cuisine'];
    political = json['political_views'];
    lookingFor = json['looking_for'];
    personality = json['personality'];
    firstDate = json['first_date'];
    drink = json['drink'];
    smoke = json['smoke'];
    religion = json['religion'];
    favPastime = json['fav_pastime'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userID'] = userID;
    data['sun_sign'] = sunSign;
    data['cuisine'] = favCuisine;
    data['political_views'] = political;
    data['looking_for'] = lookingFor;
    data['personality'] = personality;
    data['first_date'] = firstDate;
    data['drink'] = drink;
    data['smoke'] = smoke;
    data['fav_pastime'] = favPastime;
    data['first_date'] = firstDate;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
