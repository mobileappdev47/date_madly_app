import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_madly_app/providers/home_main_provider.dart';
import 'package:flutter/material.dart';

import '../../network/api.dart';
import 'full_screen_image.dart';

class CustomImageScroller extends StatelessWidget {
  const CustomImageScroller(
      {super.key,
      required this.images,
      required this.homeMainProvider,
      required this.name});

  final List<String> images;
  final HomeMainProvider homeMainProvider;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height / 2.15,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            PageView.builder(
                pageSnapping: true,
                itemCount: images.length,
                onPageChanged: (value) =>
                    homeMainProvider.changeImageIndicator(value),
                itemBuilder: (context, pagePosition) {
                  return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => FullScreenImage(
                                  name: name!,
                                  image: Api.cloudFrontImageURL +
                                      images[pagePosition]))),
                      child: CachedNetworkImage(
                          imageUrl:
                              Api.cloudFrontImageURL + images[pagePosition],
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error)));
                }),
            Positioned(
                bottom: 20,
                width: images.length <= 4
                    ? MediaQuery.of(context).size.width / 1.09
                    : MediaQuery.of(context).size.width / 3,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: indicators(
                        images.length, homeMainProvider.activePage, context)))
          ],
        ));
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
}
