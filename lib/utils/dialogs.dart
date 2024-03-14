import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_madly_app/utils/colors.dart';
import 'package:date_madly_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'custom_alert.dart';

class Dialogs {
  showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CustomAlert(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 15.0),
              Text(Constants.appName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 24)),
              const SizedBox(height: 25.0),
              const Text('Are you sure you want to quit?',
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0)),
              const SizedBox(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                      height: 40.0,
                      width: 130.0,
                      child: OutlinedButton(
                          child: Text('No'),
                          onPressed: () => Navigator.pop(context))),
                  SizedBox(
                    height: 40.0,
                    width: 130.0,
                    child: FilledButton(
                      // style: ButtonStyle(
                      //   shape: OutlinedBorder(
                      //       borderRadius: BorderRadius.circular(5.0)),
                      // ),

                      onPressed: () => exit(0),
                      // color: Theme.of(context).colorScheme.secondary,
                      child: const Text('Yes'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

  showPurchaseDialog(BuildContext context, Function openCheckout) {
    showDialog(
        context: context,
        builder: (context) => CustomAlert(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // const SizedBox(height: 15.0),
                      // Text(
                      //   Constants.appName,
                      //   style: const TextStyle(
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 16.0,
                      //   ),
                      // ),
                      const SizedBox(height: 15.0),
                      const Text(
                        'Features',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(height: 25.0),
                      const Text("No Ads"),
                      const SizedBox(height: 10.0),
                      const Text("Download acts works offline"),
                      const SizedBox(height: 10.0),
                      const Text("Text to speech Act"),
                      const SizedBox(height: 40.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            height: 40.0,
                            width: 130.0,
                            child: OutlinedButton(
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.circular(5.0),
                              // ),
                              onPressed: () => openCheckout(),
                              // color: Theme.of(context).colorScheme.secondary,
                              child: const Text(
                                'Purchase',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40.0,
                            width: 130.0,
                            child: FilledButton(
                              child: Text('Cancel'),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ],
                      )
                    ]),
              ),
            ));
  }

  showImageFullView(BuildContext context, image) {
    showDialog(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Container(
          height: MediaQuery.of(context).size.width - 150,
          width: MediaQuery.of(context).size.width - 40,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: image,
                  // height: MediaQuery.of(context).size.width - 150,
                  width: MediaQuery.of(context).size.width - 40,
                  fit: BoxFit.fill,
                  placeholder: (context, url) => Image.asset(
                    'assets/images/image_placeholder.png',
                    // height: MediaQuery.of(context).size.width - 150,
                    width: MediaQuery.of(context).size.width - 40,
                    fit: BoxFit.fill,
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/images/image_placeholder.png',
                    // height: MediaQuery.of(context).size.width - 150,
                    width: MediaQuery.of(context).size.width - 40,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, top: 10),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorRes.appColor,
                    ),
                    child: Icon(
                      Icons.close,
                      color: ColorRes.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
