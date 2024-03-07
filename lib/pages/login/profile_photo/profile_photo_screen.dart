import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_madly_app/api/sign_up_api.dart';
import 'package:date_madly_app/api/upload_image_api.dart';
import 'package:date_madly_app/common/text_style.dart';
import 'package:date_madly_app/models/sign_up_model.dart';
import 'package:date_madly_app/models/upload_image_model.dart';
import 'package:date_madly_app/pages/home/main.dart';
import 'package:date_madly_app/pages/new/enter_personal_data/enter_personal_data_screen.dart';
import 'package:date_madly_app/utils/assert_re.dart';
import 'package:date_madly_app/utils/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../../utils/colors.dart';
import '../../../utils/font_family.dart';
import '../../../utils/texts.dart';

class ProfilePhotoScreen extends StatefulWidget {
  ProfilePhotoScreen({Key? key, this.from, this.networkImageListApi})
      : super(key: key);

  final String? from;
  final List? networkImageListApi;

  @override
  State<ProfilePhotoScreen> createState() => _ProfilePhotoScreenState();
}

class _ProfilePhotoScreenState extends State<ProfilePhotoScreen> {
  File? imageFile;
  File? imageFile2;
  int selectedindex = -1;
  String imageError = '';
  bool loader = false;
  List netWorkImageList = [
    'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg',
    'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg?cs=srgb&dl=pexels-anjana-c-674010.jpg&fm=jpg',
  ];

  Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<void> downloadAndSaveImage(imageUrl, index) async {
    try {
      final http.Response response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        final path = await localPath;

        File file = File('$path/image$index.jpg');

        await file.writeAsBytes(response.bodyBytes);
        print("Image downloaded and saved as ${file}");
        imageList[index] = file;
      } else {
        print("Failed to download image. Status code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  imageValidation() {
    if (imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Please select atLeast one image!',
          style: TextStyle(color: ColorRes.white),
        ),
        backgroundColor: Colors.red,
      ));
      setState(() {
        imageError = 'Add Profile Image';
      });
    } else {
      setState(() {
        imageError = "";
      });
    }
  }

  val() async {
    imageValidation();
  }

  validation() {
    val();
    if (imageError == '') {
      return true;
    } else {
      return false;
    }
  }

  Future<void> pickImage(
      {required ImageSource source, required int index}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        selectedindex = index;
        imageList[index] = imageFile!;

        if (widget.from != null && widget.from == 'enter') {
          newImageFile.add(imageFile!);
        }
      });
    } else {
      print('No image selected.');
    }
  }

  UploadImageModel uploadImageModel = UploadImageModel();

  uploadApi() async {
    try {
      loader = true;
      setState(() {});
      for (int i = 0; i < imageList.length; i++) {
        if (imageList[i].path.isNotEmpty) {
          uploadImageModel =
              await UploadImageApi.uploadImageApi(imageList[i], context);
        } else {}
      }
      if (uploadImageModel.profile != null &&
          uploadImageModel.profile!.images != null &&
          uploadImageModel.profile!.images!.isNotEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (c) => EnterPersonalDataScreen(),
          ),
        );
      } else {}

      loader = false;
      setState(() {});
    } catch (e) {
      loader = false;
    }
  }

  uploadApifromUpdate() async {
    try {
      loader = true;
      setState(() {});
      for (int i = 0; i < newImageFile.length; i++) {
        if (newImageFile[i].path.isNotEmpty) {
          uploadImageModel =
              await UploadImageApi.uploadImageApi(newImageFile[i], context);
        } else {}
      }
      if (uploadImageModel.profile != null &&
          uploadImageModel.profile!.images != null &&
          uploadImageModel.profile!.images!.isNotEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (c) => EnterPersonalDataScreen(),
          ),
        );
      } else {}

      loader = false;
      setState(() {});
    } catch (e) {
      loader = false;
    }
  }

  imageUrlApi() async {
    try {
      loader = true;
      setState(() {});
      for (int i = 0; i < widget.networkImageListApi!.length; i++) {
        await downloadAndSaveImage(widget.networkImageListApi![i], i);
      }
      loader = false;
      setState(() {});
    } catch (e) {
      loader = false;
      print(e.toString());
    }
  }

  List<File> imageList = List.generate(30, (index) => File(''));
  List<File> newImageFile = [];
  @override
  void initState() {
    if (widget.from != null && widget.from == 'enter') {
      imageUrlApi();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.of(context).size.height / 13,
        width: MediaQuery.of(context).size.width / 1,
        child: CupertinoButton(
            color: ColorRes.appColor,
            child: Text(Strings.done),
            onPressed: () async {
              FocusScope.of(context).unfocus();
              if (validation()) {
                if (widget.from != null && widget.from == 'enter') {
                  await uploadApifromUpdate();
                } else {
                  await uploadApi();
                }
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (c) => EnterPersonalDataScreen(),
                //   ),
                // );
              }
            }),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 15,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back),
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 25,
                  ),
                  Text(
                    Strings.upload_profile,
                    style: mulishbold.copyWith(
                        color: ColorRes.darkGrey, fontSize: 21),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 30,
                  ),
                  Text(
                    Strings.Please_upload,
                    style: mulish14400.copyWith(
                        fontFamily: Fonts.poppins, fontSize: 12),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                height: MediaQuery.of(context).size.height / 3,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              15,
                                        ),
                                        Text(
                                          Strings.add_photos,
                                          style: mulish14400.copyWith(
                                            fontSize: 24,
                                            fontFamily: Fonts.poppinsSemiBold,
                                            color: ColorRes.darkGrey,
                                          ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              40,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                            pickImage(
                                                index: index,
                                                source: ImageSource.gallery);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: ColorRes.appColor,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                50,
                                              ),
                                            ),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                13,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1,
                                            child: Text(
                                              Strings.add_from_galary,
                                              style: mulish14400.copyWith(
                                                fontFamily: Fonts.poppins,
                                                color: Colors.white,
                                                fontSize: 15,
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                          ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              40,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                            pickImage(
                                                index: index,
                                                source: ImageSource.camera);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: ColorRes.appColor,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                50,
                                              ),
                                            ),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                13,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1,
                                            child: Text(
                                              Strings.use_camera,
                                              style: mulish14400.copyWith(
                                                fontFamily: Fonts.poppins,
                                                color: Colors.white,
                                                fontSize: 15,
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                          setState(() {
                            selectedindex == index;
                          });
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height / 5,
                          width: MediaQuery.of(context).size.width / 3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorRes.lightGrey,
                          ),
                          child: imageList[index].path.isEmpty
                              ? Image.asset(
                                  AssertRe.gallary,
                                  scale: 3,
                                  //,
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    imageList[index],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                        ),
                      );
                    },
                    itemCount: imageList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 7,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 10,
                    ),
                  ),
                  imageError != ''
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Text(
                              imageError,
                              style: errorText(),
                            ),
                          ),
                        )
                      : SizedBox(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 7,
                  ),
                ],
              ),
            ),
          ),
          loader == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
