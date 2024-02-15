import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../network/api.dart';
import '../../providers/home_main_provider.dart';
import '../../utils/body_builder.dart';
import '../../utils/enum/api_request_status.dart';
import '../home/full_screen_image.dart';

class LikeProfile extends StatefulWidget {
  const LikeProfile({Key? key}) : super(key: key);

  @override
  State<LikeProfile> createState() => _LikeProfileState();
}

var userID;

class _LikeProfileState extends State<LikeProfile> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) => Provider.of<HomeMainProvider>(context, listen: false)
          .getSingleProfile(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeMainProvider>(
      builder: (BuildContext context, HomeMainProvider homeMainProvider,
          Widget? child) {
        return Scaffold(
          appBar: AppBar(),
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: _buildBody(homeMainProvider, context),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              homeMainProvider.apiRequestStatus == APIRequestStatus.loaded
                  ? FloatingActionButton.extended(
                      heroTag: "Decline",
                      backgroundColor: Colors.grey,
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () async {
                        print("clicked");
                        var request =
                            homeMainProvider.likeDislikeRequested(userID, 1);
                        if (await request) {
                          if (!mounted) return;
                          Navigator.pop(context, 'declined');
                        }
                      },
                      label: Text("Decline".toUpperCase(),
                          style: const TextStyle(color: Colors.white)))
                  : SizedBox(),
              const SizedBox(width: 20),
              homeMainProvider.apiRequestStatus == APIRequestStatus.loaded
                  ? FloatingActionButton.extended(
                      heroTag: "Accept",
                      backgroundColor: Colors.green[800],
                      icon: const Icon(Icons.check, color: Colors.white),
                      onPressed: () async {
                        var request =
                            homeMainProvider.likeDislikeRequested(userID, 0);
                        if (await request) {
                          if (!mounted) return;
                          Navigator.pop(context, 'accepted');
                        }
                      },
                      label: Text("Accept".toUpperCase(),
                          style: const TextStyle(color: Colors.white)))
                  : SizedBox(),
            ],
          ),
        );
      },
    );
  }

  _buildBody(HomeMainProvider homeMainProvider, context) {
    return BodyBuilder(
        apiRequestStatus: homeMainProvider.apiRequestStatus,
        child: _buildBodyList(homeMainProvider, context),
        reload: () => homeMainProvider.getSingleProfile());
  }

  _buildBodyList(HomeMainProvider homeMainProvider, context) {
    var item = homeMainProvider.singleProfileModel;
    var images = item.profile?[0].images;
    var min = item.profile?[0].height;
    homeMainProvider.getHeight(min);
    var height = "${homeMainProvider.feet}'${homeMainProvider.inch}''";
    // var age = item.age;
    var name = item.profile?[0].name!;
    var live = item.profile?[0].live;
    var age = item.profile != null
        ? calculateAge(DateTime.parse(item.profile![0].dob!))
        : "";
    userID = item.profile?[0].sId;

    // BasicInfo
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
    var gender = item.profile?[0].gender;

    return Stack(
      children: [
        ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.15,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: images != null &&
                                  images.length != 0 &&
                                  images.isNotEmpty
                              ? PageView.builder(
                                  itemCount: images.length,
                                  pageSnapping: true,
                                  onPageChanged: (value) => homeMainProvider
                                      .changeImageIndicator(value),
                                  itemBuilder: (context, pagePosition) {
                                    return GestureDetector(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (c) => FullScreenImage(
                                                    name: name!,
                                                    image: Api
                                                            .cloudFrontImageURL +
                                                        images[pagePosition]))),
                                        child: CachedNetworkImage(
                                            imageUrl: Api.cloudFrontImageURL +
                                                images[pagePosition],
                                            fit: BoxFit.cover,
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error)));
                                  })
                              : Image.asset(gender == 'Man'
                                  ? "assets/images/male_placeholder.jpg"
                                  : "assets/images/female_placeholder.jpg"))),
                  images != null
                      ? Positioned(
                          bottom: 20,
                          width: images.length <= 4
                              ? MediaQuery.of(context).size.width
                              : MediaQuery.of(context).size.width / 3,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: indicators(images.length,
                                  homeMainProvider.activePage, context)))
                      : SizedBox()
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18, top: 10),
              child: Text("$name, $age, $height",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20)),
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
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            GridView(
              addRepaintBoundaries: false,
              shrinkWrap: true, // use
              addAutomaticKeepAlives: false,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  childAspectRatio: 2.5),
              children: [
                if (sunSign != null)
                  SelectCard(
                      name: "Sun Sign", value: sunSign, icon: Icons.sunny),
                if (favCuisine != null)
                  SelectCard(
                      name: "Favourite Cuisine",
                      value: favCuisine,
                      icon: Icons.dinner_dining),
                if (political != null)
                  SelectCard(
                      name: "Political Views",
                      value: political,
                      icon: Icons.policy),
                if (lookingFor != null)
                  SelectCard(
                      name: "Looking For",
                      value: lookingFor,
                      icon: Icons.favorite),
                if (personality != null)
                  SelectCard(
                      name: "Personality",
                      value: personality,
                      icon: Icons.person_pin),
                if (firstDate != null)
                  SelectCard(
                      name: "First Date",
                      value: firstDate,
                      icon: Icons.date_range),
                if (drink != null)
                  SelectCard(
                      name: "Drink",
                      value: drink,
                      icon: Icons.local_drink_rounded),
                if (smoke != null)
                  SelectCard(
                      name: "Smoke", value: smoke, icon: Icons.smoking_rooms),
                if (religion != null)
                  SelectCard(
                      name: "Religion",
                      value: religion,
                      icon: Icons.stacked_line_chart_outlined),
                if (favPastime != null)
                  SelectCard(
                      name: "Favourite Pastime",
                      value: favPastime,
                      icon: Icons.gamepad_outlined),
                const SizedBox(height: 30)
              ],
            )

            // SelectCard(),
          ],
        ),
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
