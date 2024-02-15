import 'dart:io';
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
}
