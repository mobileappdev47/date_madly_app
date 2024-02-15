import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../providers/city_provider.dart';
import '../../utils/constants.dart';

class CurrentCity extends StatefulWidget {
  const CurrentCity({super.key});

  @override
  State<CurrentCity> createState() => _CurrentCityState();
}

class _CurrentCityState extends State<CurrentCity> {
  String? _name = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<CityProvider>(
      builder:
          (BuildContext context, CityProvider cityProvider, Widget? child) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            title: const Text("Current City"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              TextFormField(
                autofocus: true,
                decoration: Constants.deco("", "Find your current location"),
                keyboardType: TextInputType.name,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s"))
                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'City is required';
                  } else if (value.length < 4) {
                    return 'City is required';
                  }
                  return null;
                },
                onChanged: (String? val) {
                  _name = val;
                  if (_name!.length >= 4) {
                    cityProvider.searchCity("^$_name");
                  } else {
                    cityProvider.setZeroCities();
                  }
                },
              ),
              const SizedBox(height: 10),
              cityProvider.countriesModel.cities == null ||
                      cityProvider.countriesModel.cities!.isEmpty
                  ? const Text("Please type at least 4 characters to search",
                      style: TextStyle(fontWeight: FontWeight.bold))
                  : const SizedBox(),
              Expanded(
                child: ListView.separated(
                  itemCount: cityProvider.countriesModel.cities != null
                      ? cityProvider.countriesModel.cities!.length
                      : 0,
                  itemBuilder: (BuildContext context, int index) {
                    var fullCity =
                        "${cityProvider.countriesModel.cities![index].name!}, ${cityProvider.countriesModel.cities![index].stateName!}, ${cityProvider.countriesModel.cities![index].countryName!}";
                    return ListTile(
                        onTap: () {
                          Navigator.pop(context, fullCity);
                          cityProvider.setZeroCities();
                        },
                        leading: Text(
                          cityProvider.countriesModel.flags![index].emoji!,
                          style: const TextStyle(fontSize: 25),
                        ),
                        title: Text(
                          fullCity,
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer),
                        ));
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                ),
              )
            ]),
          ),
        );
      },
    );
  }
}
