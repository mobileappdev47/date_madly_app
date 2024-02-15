class FetchLikeProfile {
  String? userID;
  String? likedID;
  int? status;
  String? sId;
  int? iV;

  FetchLikeProfile({this.userID, this.likedID, this.status, this.sId, this.iV});

  FetchLikeProfile.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    likedID = json['likedID'];
    status = json['status'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] = userID;
    data['likedID'] = likedID;
    data['status'] = status;
    data['_id'] = sId;
    data['__v'] = iV;
    return data;
  }
}
