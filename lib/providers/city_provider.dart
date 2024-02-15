import 'package:date_madly_app/models/countries_model.dart';
import 'package:flutter/cupertino.dart';

import '../network/api.dart';
import '../utils/enum/api_request_status.dart';
import '../utils/functions.dart';

class CityProvider with ChangeNotifier {
  CountriesModel countriesModel = CountriesModel();
  APIRequestStatus apiRequestStatus = APIRequestStatus.loading;
  Api api = Api();
  bool showLoading = false;

  searchCity(city) async {
    showLoading = true;
    try {
      CountriesModel profile = await api.getCities("${Api.countriesURL}/$city");
      setProfile(profile);
      setApiRequestStatus(APIRequestStatus.loaded);
      showLoading = false;
    } catch (e) {
      checkError(e);
    }
  }

  void setProfile(value) {
    countriesModel = value;
    notifyListeners();
  }

  void setZeroCities() {
    countriesModel.cities = [];
    countriesModel.flags = [];
    notifyListeners();
  }

  void checkError(e) {
    if (Functions.checkConnectionError(e)) {
      setApiRequestStatus(APIRequestStatus.connectionError);
    } else {
      setApiRequestStatus(APIRequestStatus.error);
    }
  }

  void setApiRequestStatus(APIRequestStatus value) {
    apiRequestStatus = value;
    notifyListeners();
  }
}
