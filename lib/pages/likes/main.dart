import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_madly_app/api/update_request_status.dart';
import 'package:date_madly_app/common/text_style.dart';
import 'package:date_madly_app/models/get_like_dislike_model.dart';
import 'package:date_madly_app/models/update_request_status.dart';
import 'package:date_madly_app/pages/likes/like_profile.dart';
import 'package:date_madly_app/utils/assert_re.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../api/get_like_dislike_api.dart';
import '../../common/text_feild_common.dart';
import '../../network/api.dart';
import '../../providers/likes_provider.dart';
import '../../utils/body_builder.dart';
import '../../utils/colors.dart';
import '../../utils/text_style.dart';
import '../../utils/texts.dart';
import '../me/main.dart';
import '../new_match/new_match_screen.dart';

class Likes extends StatefulWidget {
  const Likes({Key? key}) : super(key: key);

  @override
  State<Likes> createState() => _LikesState();
}

class _LikesState extends State<Likes> {
  bool loder = false;
  GetLikeDislikeModel getLikeDislikeModel = GetLikeDislikeModel();
  UpdateRequestModel updateRequestModel = UpdateRequestModel();
  LikeDislikeapicall() async {
    try {
      loder = true;
      setState(() {});
      getLikeDislikeModel =
          await GetLikedDislikeProfilesApi.getlikedDislikeProfilesapi(0);
      loder = false;
      setState(() {});
    } catch (e) {
      print('==============>${e.toString()}');
    }
  }

  updateRequestStatusApi({String? likeId, int? status, String? rID}) async {
    try {
      loder = true;
      setState(() {});
      updateRequestModel =
          await UpdateRequestApi.updateRequestApi(likeId, status, rID);
      loder = false;
      setState(() {});
    } catch (e) {
      loder = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    LikeDislikeapicall();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LikesProvider>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: ColorRes.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: ColorRes.white,
          // leading: GestureDetector(
          //   onTap: () {
          //     Navigator.of(context).pushReplacement(MaterialPageRoute(
          //       builder: (context) {
          //         return Profile();
          //       },
          //     ));
          //   },
          //   child: Icon(
          //     Icons.arrow_back_ios_new_rounded,
          //     color: ColorRes.appColor,
          //   ),
          // ),
          title: Text(
            Strings.Match_Request,
            style:
                mulishbold.copyWith(fontSize: 18.75, color: ColorRes.appColor),
          ),
          // actions: [
          //   Builder(
          //     builder: (BuildContext context) {
          //       return IconButton(
          //         icon: Image.asset(
          //           AssertRe.right_drawer,
          //           scale: 3,
          //         ),
          //         onPressed: () {
          //           Scaffold.of(context).openDrawer();
          //         },
          //       );
          //     },
          //   ),
          // ],
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: Column(
                  children: [
                    NewTextField(
                      onChange: (p0) {
                        value.searching(p0, getLikeDislikeModel.likedProfiles);
                      },
                      controller: value.searchController,
                      hintText: Strings.Search_Match_Request,
                      prefix: AssertRe.Search_Icon,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    (value.searchController.text.isEmpty)
                        ? GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.7,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10),
                            itemCount:
                                getLikeDislikeModel.likedProfiles?.length ?? 0,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  getLikeDislikeModel.likedProfiles?[index]
                                                  .userId?.images !=
                                              null &&
                                          getLikeDislikeModel
                                              .likedProfiles![index]
                                              .userId!
                                              .images!
                                              .isNotEmpty
                                      ? ClipRRect(
                                          child: CachedNetworkImage(
                                            imageUrl: getLikeDislikeModel
                                                    .likedProfiles?[index]
                                                    .userId
                                                    ?.images?[0] ??
                                                '',
                                            fit: BoxFit.cover,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            placeholder: (context, url) =>
                                                Image.asset(
                                              'assets/images/image_placeholder.png',
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              fit: BoxFit.cover,
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Image.asset(
                                              'assets/images/image_placeholder.png',
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        )
                                      : ClipRRect(
                                          child: CachedNetworkImage(
                                            imageUrl: '',
                                            fit: BoxFit.cover,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            placeholder: (context, url) =>
                                                Image.asset(
                                              'assets/images/image_placeholder.png',
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              fit: BoxFit.cover,
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Image.asset(
                                              'assets/images/image_placeholder.png',
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 15),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            getLikeDislikeModel
                                                    .likedProfiles?[index]
                                                    .userId
                                                    ?.name ??
                                                '',
                                            style: mulishbold.copyWith(
                                              fontSize: 16.41,
                                              color: ColorRes.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          height: 110,
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  await updateRequestStatusApi(
                                                      likeId: getLikeDislikeModel
                                                              .likedProfiles?[
                                                                  index]
                                                              .userId
                                                              ?.id ??
                                                          '',
                                                      status: 1,
                                                      rID: getLikeDislikeModel
                                                              .likedProfiles?[
                                                                  index]
                                                              .id ??
                                                          '');

                                                  await LikeDislikeapicall();
                                                },
                                                child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.grey.shade50,
                                                  ),
                                                  child: Icon(
                                                    Icons.close,
                                                    color: ColorRes.darkGrey,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  await updateRequestStatusApi(
                                                      likeId: getLikeDislikeModel
                                                              .likedProfiles?[
                                                                  index]
                                                              .userId
                                                              ?.id ??
                                                          '',
                                                      status: 0,
                                                      rID: getLikeDislikeModel
                                                              .likedProfiles?[
                                                                  index]
                                                              .id ??
                                                          '');
                                                  await LikeDislikeapicall();
                                                },
                                                child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: ColorRes.appColor,
                                                  ),
                                                  child: Icon(
                                                    Icons.favorite_border,
                                                    color: ColorRes.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              );
                            },
                          )
                        : GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.7,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10),
                            itemCount: value.filterList.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  value.filterList?[index].userId?.images !=
                                              null &&
                                          value.filterList![index].userId!
                                              .images!.isNotEmpty
                                      ? ClipRRect(
                                          child: CachedNetworkImage(
                                            imageUrl: value.filterList?[index]
                                                    .userId?.images?[0] ??
                                                '',
                                            fit: BoxFit.cover,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            placeholder: (context, url) =>
                                                Image.asset(
                                              'assets/images/image_placeholder.png',
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              fit: BoxFit.cover,
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Image.asset(
                                              'assets/images/image_placeholder.png',
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        )
                                      : ClipRRect(
                                          child: CachedNetworkImage(
                                            imageUrl: '',
                                            fit: BoxFit.cover,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            placeholder: (context, url) =>
                                                Image.asset(
                                              'assets/images/image_placeholder.png',
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              fit: BoxFit.cover,
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Image.asset(
                                              'assets/images/image_placeholder.png',
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 15),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            value.filterList?[index].userId
                                                    ?.name ??
                                                '',
                                            style: mulishbold.copyWith(
                                              fontSize: 16.41,
                                              color: ColorRes.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          height: 110,
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  await updateRequestStatusApi(
                                                      likeId: value
                                                              .filterList[index]
                                                              .userId
                                                              ?.id ??
                                                          '',
                                                      status: 1,
                                                      rID: value
                                                              .filterList[index]
                                                              .id ??
                                                          '');
                                                  await LikeDislikeapicall();
                                                },
                                                child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.grey.shade50,
                                                  ),
                                                  child: Icon(
                                                    Icons.close,
                                                    color: ColorRes.darkGrey,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  await updateRequestStatusApi(
                                                      likeId: value
                                                              .filterList[index]
                                                              .userId
                                                              ?.name ??
                                                          '',
                                                      status: 0,
                                                      rID: value
                                                              .filterList[index]
                                                              .id ??
                                                          '');
                                                  await LikeDislikeapicall();
                                                },
                                                child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: ColorRes.appColor,
                                                  ),
                                                  child: Icon(
                                                    Icons.favorite_border,
                                                    color: ColorRes.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              );
                            },
                          )
                  ],
                ),
              ),
            ),
            loder == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox(),
          ],
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
