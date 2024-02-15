import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_madly_app/network/api.dart';
import 'package:date_madly_app/pages/login/degree.dart';
import 'package:date_madly_app/pages/login/upload_image.dart';
import 'package:date_madly_app/pages/me/additional_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/edit_profile_provider.dart';
import '../../utils/body_builder.dart';
import '../login/designation.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

late SharedPreferences sharedPreferences;

class _EditProfileState extends State<EditProfile> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) => Provider.of<EditProfileProvider>(context, listen: false)
          .getSingleProfile(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EditProfileProvider>(builder: (BuildContext context,
        EditProfileProvider editProfileProvider, Widget? child) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(title: const Text("Edit Profile"), centerTitle: true),
        body: _buildBody(editProfileProvider, context),
      );
    });
  }
}

_buildBody(EditProfileProvider editProfileProvider, context) {
  return BodyBuilder(
      apiRequestStatus: editProfileProvider.apiRequestStatus,
      child: _buildBodyList(editProfileProvider, context),
      reload: () => editProfileProvider.getSingleProfile());
}

_buildBodyList(EditProfileProvider editProfileProvider, context) {
  var item = editProfileProvider.singleProfileModel;
  var min = item.profile?[0].height;
  editProfileProvider.getHeight(min);
  var height = "${editProfileProvider.feet}'${editProfileProvider.inch}''";
  // var age = item.age;
  var name = item.profile?[0].name != null ? item.profile![0].name! : '';
  var live = item.profile?[0].live;
  var age = item.profile != null
      ? calculateAge(DateTime.parse(item.profile![0].dob!))
      : "";

  var company = item.profile?[0].company;
  var income = item.profile?[0].income;
  var degree = item.profile?[0].degree;
  var designation = item.profile?[0].designation;
  var id = item.profile?[0].sId;
  var sunSign = item.profile?[0].basicInfo!.sunSign;
  var favCuisine = item.profile?[0].basicInfo!.favCuisine;
  var political = item.profile?[0].basicInfo!.political;
  var lookingFor = item.profile?[0].basicInfo!.lookingFor;
  var personality = item.profile?[0].basicInfo!.personality;
  var firstDate = item.profile?[0].basicInfo!.firstDate;
  var drink = item.profile?[0].basicInfo!.drink;
  var smoke = item.profile?[0].basicInfo!.smoke;
  var religion = item.profile?[0].basicInfo!.religion;
  var favPastime = item.profile?[0].basicInfo!.favPastime;
  var images = item.profile?[0].images != null ? item.profile![0].images : [];
  var gender = editProfileProvider.gender;
  var email = item.profile?[0].email;
  // print("Gender:- " + gender.toString());

  return ListView(
    // mainAxisAlignment: MainAxisAlignment.start,
    // crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Stack(
        children: [
          Stack(
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Hero(
                        tag: name,
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height / 2.15,
                            width: MediaQuery.of(context).size.width,
                            child: Stack(
                              children: [
                                images!.length != 0
                                    ? PageView.builder(
                                        itemCount: images.length,
                                        pageSnapping: true,
                                        onPageChanged: (value) =>
                                            editProfileProvider
                                                .changeImageIndicator(value),
                                        itemBuilder: (context, pagePosition) {
                                          return CachedNetworkImage(
                                              imageUrl: Api.cloudFrontImageURL +
                                                  images[pagePosition],
                                              fit: BoxFit.cover,
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error));
                                        })
                                    : Image.asset(gender == 'Man'
                                        ? "assets/images/male_placeholder.jpg"
                                        : "assets/images/female_placeholder.jpg"),
                                Positioned(
                                    bottom: 20,
                                    left: images.length <= 4
                                        ? MediaQuery.of(context).size.width /
                                            2.45
                                        : MediaQuery.of(context).size.width / 3,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: indicators(
                                            images.length,
                                            editProfileProvider.activePage,
                                            context))),
                              ],
                            )),

                        // child: Image.network(
                        //     height:
                        //         MediaQuery.of(context).size.height / 2.2,
                        //     "https://www.orissapost.com/wp-content/uploads/2020/06/carryminati-1024x576.jpg",
                        //     fit: BoxFit.cover),
                      ))),
            ],
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (c) => UploadImage(
                          newLogin: false,
                          profileModel:
                              editProfileProvider.singleProfileModel))),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                      width: 50,
                      color: Colors.black.withOpacity(0.3),
                      child: Padding(
                          padding: const EdgeInsets.all(12.5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [Icon(Icons.edit, color: Colors.white)],
                          )))),
            ),
          )
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(left: 18, top: 10),
        child: Text("$name, $age, $height",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 12, top: 2),
        child: Row(
          children: [
            const Icon(Icons.location_on, color: Colors.grey),
            const SizedBox(width: 5),
            const Text("Lives in ",
                style: TextStyle(fontWeight: FontWeight.w300)),
            Text(live ?? "",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
      ),
      const SizedBox(height: 10),
      Card(
        child: ListTile(
          leading: Icon(Icons.email),
          title: Text("Email"),
          subtitle: Text(email.toString()),
        ),
      ),
      Card(
        child: ListTile(
          leading: const Icon(Icons.work),
          title: Text(designation ?? ""),
          subtitle: Text("$company - $income"),
          trailing: GestureDetector(
              onTap: () async {
                sharedPreferences = await SharedPreferences.getInstance();
                var designation = sharedPreferences.getString("designation");
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return Designation(
                          show: true,
                          company: company!,
                          income: income!,
                          designation: designation ?? "",
                          id: id!);
                    },
                  ),
                );
                var newDesignation = sharedPreferences.getString("designation");
                if (designation != newDesignation) {
                  editProfileProvider.getSingleProfile();
                }
              },
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                      width: 50,
                      color: Colors.black.withOpacity(0.3),
                      child: Padding(
                          padding: const EdgeInsets.all(12.5),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(Icons.edit, color: Colors.white)
                              ]))))),
        ),
      ),
      Card(
          child: ListTile(
              leading: const Icon(Icons.school),
              title: Text(degree ?? ""),
              subtitle: const Text.rich(TextSpan(children: [
                TextSpan(
                    text: 'Add Institute Name',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                        decorationThickness: 2,
                        decorationColor: Colors.blue))
              ])),
              // subtitle: const Text.rich(
              //   TextSpan(
              //       text: 'By using our mobile app, you agree to our ',
              //       children: [
              //         TextSpan(
              //             text: 'Term of Use',
              //             style: TextStyle(
              //               decoration: TextDecoration.underline,
              //             )),
              //         TextSpan(text: ' and '),
              //         TextSpan(
              //             text: 'Privacy Policy',
              //             style: TextStyle(
              //               decoration: TextDecoration.underline,
              //             )),
              //       ]),
              // ),
              trailing: GestureDetector(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return Degree(show: true, id: id!);
                        },
                      ),
                    );
                    if (result != null) {
                      editProfileProvider.getSingleProfile();
                    }
                  },
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                          width: 50,
                          color: Colors.black.withOpacity(0.3),
                          child: Padding(
                              padding: const EdgeInsets.all(12.5),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(Icons.edit, color: Colors.white)
                                  ]))))))),
      GridView(
        shrinkWrap: true, // use
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
            childAspectRatio: 2.5),
        children: [
          GestureDetector(
              onTap: () async {
                final result = await Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) {
                    return AdditionalDetails(
                        pageNo: 1, value: sunSign ?? "___");
                  },
                ));
                if (result != null) {
                  editProfileProvider.getSingleProfile();
                }
              },
              child: SelectCard(
                  name: "Sun Sign",
                  value: sunSign ?? "___",
                  icon: Icons.sunny)),
          GestureDetector(
            onTap: () async {
              final result = await Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) {
                  return AdditionalDetails(
                      pageNo: 2, value: favCuisine ?? "___");
                },
              ));
              if (result != null) {
                editProfileProvider.getSingleProfile();
              }
            },
            child: SelectCard(
                name: "Favourite Cuisine",
                value: favCuisine ?? "___",
                icon: Icons.dinner_dining),
          ),
          GestureDetector(
            onTap: () async {
              final result = await Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) {
                  return AdditionalDetails(
                      pageNo: 3, value: political ?? "___");
                },
              ));
              if (result != null) {
                editProfileProvider.getSingleProfile();
              }
            },
            child: SelectCard(
                name: "Political Views",
                value: political ?? "___",
                icon: Icons.policy),
          ),
          GestureDetector(
            onTap: () async {
              final result = await Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) {
                  return AdditionalDetails(
                      pageNo: 4, value: lookingFor ?? "___");
                },
              ));
              if (result != null) {
                editProfileProvider.getSingleProfile();
              }
            },
            child: SelectCard(
                name: "Looking For",
                value: lookingFor ?? "___",
                icon: Icons.favorite),
          ),
          GestureDetector(
            onTap: () async {
              final result = await Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) {
                  return AdditionalDetails(
                      pageNo: 5, value: personality ?? "___");
                },
              ));
              if (result != null) {
                editProfileProvider.getSingleProfile();
              }
            },
            child: SelectCard(
                name: "Personality",
                value: personality ?? "___",
                icon: Icons.person_pin),
          ),
          GestureDetector(
            onTap: () async {
              final result = await Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) {
                  return AdditionalDetails(
                      pageNo: 6, value: firstDate ?? "___");
                },
              ));
              if (result != null) {
                editProfileProvider.getSingleProfile();
              }
            },
            child: SelectCard(
                name: "First Date",
                value: firstDate ?? "___",
                icon: Icons.date_range),
          ),
          GestureDetector(
            onTap: () async {
              final result = await Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) {
                  return AdditionalDetails(pageNo: 7, value: drink ?? "___");
                },
              ));
              if (result != null) {
                editProfileProvider.getSingleProfile();
              }
            },
            child: SelectCard(
                name: "Drink",
                value: drink ?? "___",
                icon: Icons.local_drink_rounded),
          ),
          GestureDetector(
            onTap: () async {
              final result = await Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) {
                  return AdditionalDetails(pageNo: 8, value: smoke ?? "___");
                },
              ));
              if (result != null) {
                editProfileProvider.getSingleProfile();
              }
            },
            child: SelectCard(
                name: "Smoke",
                value: smoke ?? "___",
                icon: Icons.smoking_rooms),
          ),
          GestureDetector(
            onTap: () async {
              final result = await Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) {
                  return AdditionalDetails(pageNo: 9, value: religion ?? "___");
                },
              ));
              if (result != null) {
                editProfileProvider.getSingleProfile();
              }
            },
            child: SelectCard(
                name: "Religion",
                value: religion ?? "___",
                icon: Icons.stacked_line_chart_outlined),
          ),
          GestureDetector(
            onTap: () async {
              final result = await Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) {
                  return AdditionalDetails(
                      pageNo: 10, value: favPastime ?? "___");
                },
              ));
              if (result != null) {
                editProfileProvider.getSingleProfile();
              }
            },
            child: SelectCard(
                name: "Favourite Pastime",
                value: favPastime ?? "___",
                icon: Icons.gamepad_outlined),
          ),
        ],
      ),
      const SizedBox(height: 10),
    ],
  );
}

List<Widget> indicators(imagesLength, currentIndex, context) {
  return List<Widget>.generate(imagesLength, (index) {
    return Container(
      margin: EdgeInsets.all(3),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          color: currentIndex == index
              ? Theme.of(context).colorScheme.secondary
              : Colors.black26,
          shape: BoxShape.circle),
    );
  });
}

String calculateAge(DateTime birthDate) {
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - birthDate.year;
  int month1 = currentDate.month;
  int month2 = birthDate.month;
  if (month2 > month1) {
    age--;
  } else if (month1 == month2) {
    int day1 = currentDate.day;
    int day2 = birthDate.day;
    if (day2 > day1) {
      age--;
    }
  }
  return age.toString();
}

class SelectCard extends StatelessWidget {
  const SelectCard(
      {Key? key, required this.name, required this.value, required this.icon})
      : super(key: key);
  final String name;
  final String? value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: Card(
        color: value == '___' ? Colors.black26 : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Row(
            children: [
              Icon(icon, color: value == '___' ? Colors.white : null),
              // Icon(name == 'Sun Sign'
              //     ? Icons.sunny
              //     : name == 'Favourite Cuisine'
              //         ? Icons.dinner_dining
              //         : Icons.abc),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: value == '___' ? Colors.white : null)),
                  Text(value!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: value == '___' ? Colors.white : null))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
