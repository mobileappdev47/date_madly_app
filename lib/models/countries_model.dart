class CountriesModel {
  List<Cities>? cities;
  List<Flags>? flags;

  CountriesModel({this.cities, this.flags});

  CountriesModel.fromJson(Map<String, dynamic> json) {
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities!.add(Cities.fromJson(v));
      });
    }
    if (json['flags'] != null) {
      flags = <Flags>[];
      json['flags'].forEach((v) {
        flags!.add(Flags.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cities != null) {
      data['cities'] = cities!.map((v) => v.toJson()).toList();
    }
    if (flags != null) {
      data['flags'] = flags!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cities {
  String? sId;
  String? name;
  String? stateName;
  String? countryName;

  Cities({this.sId, this.name, this.stateName, this.countryName});

  Cities.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    stateName = json['state_name'];
    countryName = json['country_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['state_name'] = stateName;
    data['country_name'] = countryName;
    return data;
  }
}

class Flags {
  String? sId;
  String? emoji;

  Flags({this.sId, this.emoji});

  Flags.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    emoji = json['emoji'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['emoji'] = emoji;
    return data;
  }
}
