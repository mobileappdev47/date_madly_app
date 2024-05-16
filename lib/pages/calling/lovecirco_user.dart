class LoveCircoUser {
  String? uid;
  String? name;
  String? displayName;
  String? email;
  String? status;
  int? state;
  String? profilePhoto;
  String? coverImage;
  String? playerId;

  LoveCircoUser({
    this.uid,
    this.name,
    this.displayName,
    this.email,
    this.status,
    this.state,
    this.profilePhoto,
    this.coverImage,
    this.playerId,
  });

  Map<String, dynamic> toMap(LoveCircoUser user) {
    var data = <String, dynamic>{};
    data['uid'] = user.uid;
    data['name'] = user.name;
    data['display_name'] = user.displayName;
    data['email'] = user.email;
    data["status"] = user.status;
    data["state"] = user.state;
    data["profile_photo"] = user.profilePhoto;
    data["cover_image"] = user.coverImage;
    data["player_id"] = user.playerId;
    return data;
  }

  LoveCircoUser.fromMap(Map<String, dynamic> mapData) {
    uid = mapData['uid'];
    name = mapData['name'];
    displayName = mapData['display_name'];
    email = mapData['email'];
    status = mapData['status'];
    state = mapData['state'];
    profilePhoto = mapData['profile_photo'];
    coverImage = mapData['cover_image'];
    playerId = mapData["player_id"];
  }
}
