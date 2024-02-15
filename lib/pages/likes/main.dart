import 'package:date_madly_app/pages/likes/like_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../common/text_feild_common.dart';
import '../../network/api.dart';
import '../../providers/likes_provider.dart';
import '../../utils/body_builder.dart';
import '../../utils/colors.dart';
import '../../utils/text_style.dart';
import '../me/main.dart';
import '../new_match/new_match_screen.dart';

class Likes extends StatefulWidget {
  const Likes({super.key});

  @override
  State<Likes> createState() => _LikesState();
}

class _LikesState extends State<Likes> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LikesProvider>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: ColorRes.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ColorRes.white,
          leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) {
                    return Me();
                  },
                ));
              },
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: ColorRes.appColor,
              )),
          title: Text(
            'Match Request',
            style: appbarTitle(),
          ),
          actions: [
            Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Image.asset(
                    'assets/icons/right_drawer.png',
                    scale: 3,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 25),
                    child: CommonTextField(
                      controller: value.searchController,
                      hintText: 'Search Match Request',
                      isPrefixIcon: true,
                      prefix: 'assets/icons/Search_Icon.png',
                    ),
                  ),
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      // mainAxisSpacing: 10,
                      //   crossAxisSpacing: 10
                    ),
                    itemCount: matches.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            Container(
                              // height: 400,
                              //  width: 60,
                              //  decoration: BoxDecoration(color: ColorRes.appColor),
                              child: Image.asset(
                                matches[index].image,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                              child: Column(
                                children: [
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(matches[index].text,style: TextStyle(color: ColorRes.white,fontSize: 15,fontWeight: FontWeight.w700),)),
                                  SizedBox(height: 5  ,),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/icons/Location_Icon.png',
                                        scale: 4.5,
                                        color: ColorRes.white,
                                      ),
                                      SizedBox(width: 5,),
                                      Expanded(child: Text(matches[index].loaction,style: TextStyle(color: ColorRes.white,fontSize: 13,fontWeight: FontWeight.w500)))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 110,
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(90),
                                              color: Colors.grey.shade50),
                                          child: Icon(
                                            Icons.close,
                                            color: ColorRes.darkGrey,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (c) => NewMatchScreen()));
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(90),
                                                color: ColorRes.appColor),
                                            child: Icon(Icons.favorite_border,color: ColorRes.white,),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class match {
  final String image;
  final String text;
  final String loaction;

  match(this.image, this.text, this.loaction);
}

List<match> matches = [
  match('assets/icons/m1.png', 'Clara, 22', '5 Km'),
  match('assets/icons/m2.png', 'Eveline, 19', '8 Km'),
  match('assets/icons/m3.png', 'Melly, 20', '15 Km'),
  match('assets/icons/m4.png', 'Renna, 23', '10 Km'),
];

/*

class Likes extends StatefulWidget {
  const Likes({Key? key}) : super(key: key);

  @override
  State<Likes> createState() => _LikesState();
}

class _LikesState extends State<Likes> {
  @override
  void initState() {
    super.initState();
    Provider.of<LikesProvider>(context, listen: false)
                .likeDislikeProfile
                .likedDislikeProfile ==
            null
        ? SchedulerBinding.instance.addPostFrameCallback(
            (_) => Provider.of<LikesProvider>(context, listen: false)
                .getAllLikes(),
          )
        : print("ran mutiple times");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LikesProvider>(builder:
        (BuildContext context, LikesProvider likesProvider, Widget? child) {
      return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
              title: Text(
                  "Likes You (${likesProvider.likeDislikeProfile.likedDislikeProfile?.length ?? 0})"),
              centerTitle: true,
              leading: Container()),
          body: _buildBody(likesProvider));
    });
  }

  _buildBody(LikesProvider likesProvider) {
    return RefreshIndicator(
        onRefresh: () => likesProvider.getAllLikes(),
        child: BodyBuilder(
            apiRequestStatus: likesProvider.apiRequestStatus,
            child: _buildBodyList(likesProvider),
            reload: () => likesProvider.getAllLikes()));
  }

  _buildBodyList(LikesProvider likesProvider) {
    if (likesProvider.likeDislikeProfile.likedDislikeProfile?.length == 0) {
      return RefreshIndicator(
        onRefresh: () => likesProvider.getAllLikes(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/anim/404.json', reverse: true),
              Text("No one has like you. Try uploading images to get likes",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.titleLarge!.color,
                      fontSize: 18,
                      fontWeight: FontWeight.w700)),
              const SizedBox(height: 10),
              FilledButton.tonal(
                  onPressed: () => likesProvider.getAllLikes(),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: const Text('REFRESH',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      )))
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GridView.builder(
        itemCount: likesProvider.likeDislikeProfile.likedDislikeProfile?.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1 / 1.5),
        itemBuilder: (BuildContext context, int index) {
          var item = likesProvider
              .likeDislikeProfile.likedDislikeProfile![index].likedID!;
          var age = item.dob != null
              ? likesProvider.calculateAge(DateTime.parse(item.dob!))
              : "";
          var images = likesProvider
              .likeDislikeProfile.likedDislikeProfile?[index].likedID!.images;
          var gender = likesProvider
              .likeDislikeProfile.likedDislikeProfile?[index].likedID!.gender;

          return GestureDetector(
            onTap: () async {
              final req = await Navigator.push(
                  context, MaterialPageRoute(builder: (c) => LikeProfile()));
              print("req $req");
              if (!mounted) return;

              // After the Selection Screen returns a result, hide any previous snackbars
              // and show the new result.

              if (req != null) {
                likesProvider.getAllLikes();
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text('$req')));
              }
            },
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  // child: ImageFiltered(
                  //   imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        image: DecorationImage(
                            image: images!.length != 0
                                ? NetworkImage(
                                    Api.cloudFrontImageURL + images[0])
                                : AssetImage(gender == 'Man'
                                        ? "assets/images/male_placeholder.jpg"
                                        : "assets/images/female_placeholder.jpg")
                                    as ImageProvider,
                            fit: BoxFit.fitHeight)),
                    // child: ImageFiltered(
                    // )
                  ),
                  // ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                      height: double.infinity,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.black26]))),
                ),
                // const Positioned(
                //     right: 10,
                //     top: 10,
                //     child: Icon(Icons.lock, size: 28, color: Colors.white)),
                Positioned(
                  bottom: 15,
                  left: 15,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: Text(
                        "${"${item.name!.split(" ")[0]}${item.name!.split(" ").length >= 2 ? " " + item.name!.split(" ")[1][0].toUpperCase() : ''}"}, $age",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                ),

                // Container(
                //   width: MediaQuery.of(context).size.width / 2,
                //   decoration: BoxDecoration(
                //     boxShadow: [
                //       BoxShadow(
                //           color: Colors.black.withOpacity(0.5),
                //           // spreadRadius: 1,
                //           // blurRadius: 1,
                //           offset: const Offset(0, 3) // changes position of shadow
                //           )
                //     ],
                //   ),
                //   child: ShaderMask(
                //     shaderCallback: (rect) {
                //       return const LinearGradient(
                //         begin: Alignment.bottomCenter,
                //         end: Alignment.topCenter,
                //         colors: [Colors.transparent, Color(0xFF111122)],
                //       ).createShader(
                //           Rect.fromLTRB(0, 0, rect.width, rect.height / 1));
                //     },
                //     blendMode: BlendMode.dstIn,
                //     child: InkWell(
                //       splashColor:
                //           Theme.of(context).colorScheme.tertiaryContainer,
                //       onTap: () => print("je"),
                //       child: ClipRRect(
                //         borderRadius: BorderRadius.circular(8.0),
                //         child: Image.network(
                //             height: MediaQuery.of(context).size.height / 2.2,
                //             "https://www.orissapost.com/wp-content/uploads/2020/06/carryminati-1024x576.jpg",
                //             fit: BoxFit.cover),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
*/
