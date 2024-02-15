import 'dart:convert' show json;

import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart' show TextEditingController, debugPrint;

import '../models/data_models.dart';

class CountryProvider with ChangeNotifier {
  /// loading countries data from json
  /// setting up listeners
  ///
  CountryProvider() {
    loadCountriesFromJSON();
    searchController.addListener(_search);
  }

  List<Country> _countries = [];

  List<Country> get countries => _countries;

//  set countries(List<Country> value) {
//    _countries = value;
//    notifyListeners();
//  }

  List<Country> _searchResults = [];

  List<Country> get searchResults => _searchResults;

  set searchResults(List<Country> value) {
    _searchResults = value;
    print('SearchResults ${searchResults.length}');
    notifyListeners();
  }

  Country _selectedCountry = Country();

  Country get selectedCountry => _selectedCountry;

  set selectedCountry(Country value) {
    _selectedCountry = value;
    notifyListeners();
  }

  final TextEditingController _searchController = TextEditingController();

  TextEditingController get searchController => _searchController;

  Future loadCountriesFromJSON() async {
    try {
      if (countries.isEmpty) {
        var file =
            await rootBundle.loadString('data/country_phone_codes.json');
        var countriesJson = json.decode(file);
        List<Country> listOfCountries = [];
        for (var country in countriesJson) {
          listOfCountries.add(Country.fromJson(country));
        }
        _countries = listOfCountries;
        notifyListeners();
        // Selecting India
        selectedCountry = listOfCountries[100];
        searchResults = listOfCountries;
      }
    } catch (err) {
      debugPrint("Unable to load countries data");
      rethrow;
    }
  }

  ///  This will be the listener for searching the query entered by user for their country, (dialog pop-up),
  ///  searches for the query and returns list of countries matching the query by adding the results to the sink of [searchResults]
  void _search() {
    String query = searchController.text;
    print(query);
    if (query.isEmpty || query.length == 1) {
      searchResults = countries;
    } else {
      List<Country> results = [];
      for (var c in countries) {
        if (c.toString().toLowerCase().contains(query.toLowerCase())) {
          results.add(c);
        }
      }
      searchResults = results;
      print("results length: ${searchResults.length}");
//      print('added few countries based on search ${searchResults.length}');
    }
  }

  void resetSearch() {
    searchResults = countries;
  }
}
