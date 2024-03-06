import 'dart:convert';
import 'dart:io';

import 'package:date_madly_app/models/profile_model.dart';
import 'package:date_madly_app/network/api.dart';
import 'package:date_madly_app/pages/home/main.dart';
import 'package:date_madly_app/providers/upload_image_provider.dart';
import 'package:date_madly_app/utils/body_builder.dart';
import 'package:date_madly_app/utils/enum/api_request_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key, required this.newLogin, this.profileModel});

  final bool newLogin;
  final ProfileModel? profileModel;

  @override
  State<UploadImage> createState() => _UploadImageState();
}

File? _image;

class _UploadImageState extends State<UploadImage> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback(
      (_) => Provider.of<UploadImageProvider>(context, listen: false)
          .getAllImages(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UploadImageProvider>(builder: (BuildContext context,
        UploadImageProvider uploadImageProvider, Widget? child) {
      return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: widget.newLogin ? null : AppBar(),
          body: _buildBody(uploadImageProvider),
          bottomNavigationBar: uploadImageProvider.apiRequestStatus ==
                  APIRequestStatus.loaded
              ? FilledButton(
                  style: ElevatedButton.styleFrom(
                    shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                  onPressed: () {
                    widget.newLogin
                        ? Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (c) => const HomeMain()))
                        : Navigator.pop(context);
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Text("Done",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold))))
              : SizedBox());
    });
  }

  _buildBody(UploadImageProvider uploadImageProvider) {
    return RefreshIndicator(
        onRefresh: () => uploadImageProvider.getAllImages(),
        child: BodyBuilder(
            apiRequestStatus: uploadImageProvider.apiRequestStatus,
            child: _buildBodyList(uploadImageProvider),
            reload: () => uploadImageProvider.getAllImages()));
  }

  _buildBodyList(UploadImageProvider uploadImageProvider) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.newLogin
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FilledButton.tonal(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => const HomeMain()));
                          },
                          child: Text("SKIP"))
                    ],
                  )
                : SizedBox(),
            const Text("Upload a profile Photo",
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 24,
                    letterSpacing: 0.8)),
            const SizedBox(height: 10),
            const Text(
                "Please upload atleast one real photo of yourself to start liking profiles.",
                style: TextStyle(fontWeight: FontWeight.w300)),
            const SizedBox(height: 20),
            Column(
              children: [
                GridView.builder(
                  itemCount: 9,
                  addRepaintBoundaries: false,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1,
                      childAspectRatio: 0.75),
                  itemBuilder: (BuildContext context, int index) {
                    var imageNotNull = uploadImageProvider.singleProfileModel
                                .profile?[0].images?.length !=
                            null
                        ? uploadImageProvider
                            .singleProfileModel.profile![0].images!.length
                        : 0;
                    return GestureDetector(
                      onTap: () => imageNotNull > index
                          ? uploadImageProvider.singleProfileModel.profile![0]
                                      .images![index].length >
                                  index
                              ? _replaceImage(
                                  uploadImageProvider,
                                  uploadImageProvider.singleProfileModel
                                      .profile![0].images![index],
                                  index)
                              : print("NEVER EXECUTED")
                          : _uploadImage(uploadImageProvider, false, '', 0),
                      child: Card(
                          child: Container(
                              height: 150,
                              width: MediaQuery.of(context).size.width / 3.5,
                              child: imageNotNull > index
                                  ? uploadImageProvider
                                              .singleProfileModel
                                              .profile![0]
                                              .images![index]
                                              .length >
                                          index
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
                                              Api.cloudFrontImageURL +
                                                  uploadImageProvider
                                                      .singleProfileModel
                                                      .profile![0]
                                                      .images![index],
                                              fit: BoxFit.cover))
                                      : Icon(Icons.image)
                                  : Icon(Icons.camera))),
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _replaceImage(
      UploadImageProvider uploadImageProvider, String oldImageURL, int index) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
            height: 125,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        _uploadImage(
                            uploadImageProvider, true, oldImageURL, index);
                      },
                      leading: const Icon(Icons.replay_circle_filled),
                      title: const Text('Replace Image'),
                    ),
                    // ListTile(
                    //     leading: Icon(Icons.label_important),
                    //     title:
                    //         Text('Make this Profile Image')),
                    ListTile(
                        onTap: () => Navigator.pop(context),
                        leading: const Icon(Icons.cancel),
                        title: const Text('Cancel'))
                  ],
                )));
      },
    );
  }

  _uploadImage(UploadImageProvider uploadImageProvider, bool replace,
      String oldImgURL, int index) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
            height: 300,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0, top: 10),
                      child: Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Icon(Icons.close))),
                    ),
                    // Spacer(),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            replace ? "Replace Photos" : "Add Photos",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          SizedBox(height: 18),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 1.4,
                              child: FilledButton(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.camera_alt),
                                      const SizedBox(width: 8),
                                      Text("Add from Gallery".toUpperCase()),
                                    ],
                                  ),
                                  style: Constants.buttonWithoutColor(context),
                                  onPressed: () => _getImage(
                                      ImageSource.gallery,
                                      context,
                                      uploadImageProvider,
                                      replace,
                                      oldImgURL,
                                      index))),
                          SizedBox(height: 12),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.6,
                            child: TextButton(
                                onPressed: () => _getImage(
                                    ImageSource.camera,
                                    context,
                                    uploadImageProvider,
                                    replace,
                                    oldImgURL,
                                    0),
                                style: Constants.tonalButton(context),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.camera),
                                    SizedBox(width: 8),
                                    Text("Use Camera".toUpperCase()),
                                  ],
                                )),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 1.4,
                              child: Divider()),
                          SizedBox(height: 5),
                          Text(
                            "100% Secured Guaranteed",
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 13,
                                color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                  ],
                )));
      },
    );
  }

  _getImage(
      ImageSource source,
      context,
      UploadImageProvider uploadImageProvider,
      bool replace,
      String oldImgURL,
      int index) async {
    XFile? pickedFile = await ImagePicker().pickImage(
        source: source, maxWidth: 1800, maxHeight: 1800, imageQuality: 90);
    if (pickedFile != null) {
      // _image = File(pickedFile.path);
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 75,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: Constants.appName,
              toolbarColor: Theme.of(context).colorScheme.secondaryContainer,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(title: Constants.appName),
          WebUiSettings(
            context: context,
            presentStyle: CropperPresentStyle.dialog,
            boundary: const CroppieBoundary(
              width: 520,
              height: 520,
            ),
            viewPort:
                const CroppieViewPort(width: 480, height: 480, type: 'circle'),
            enableExif: true,
            enableZoom: true,
            showZoomer: true,
          ),
        ],
      );
      if (croppedFile != null) {
        setState(() {
          _image = File(croppedFile.path);
        });
        String base64image = convertImagetoBase64();
        replace
            ? uploadImageProvider.replaceImage(oldImgURL, base64image, index)
            : uploadImageProvider.uploadImage(base64image);
        Navigator.pop(context);
      }
    }
  }

  convertImagetoBase64() {
    List<int> imageBytes = _image!.readAsBytesSync();
    String base64Image = "data:image/png;base64," + base64Encode(imageBytes);
    return base64Image;
  }
}
