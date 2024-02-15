import 'package:flutter/material.dart';

import '../utils/enum/api_request_status.dart';
import 'error_widget.dart';
import 'loading_widget.dart';

class BodyBuilder extends StatelessWidget {
  final APIRequestStatus apiRequestStatus;
  final Widget child;
  final Function reload;
  final String text;

  const BodyBuilder(
      {Key? key,
      required this.apiRequestStatus,
      required this.child,
      required this.reload,
      this.text = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    switch (apiRequestStatus) {
      case APIRequestStatus.loading:
        return const LoadingWidget();
      case APIRequestStatus.unInitialized:
        return const LoadingWidget();
      case APIRequestStatus.connectionError:
        return MyErrorWidget(
          refreshCallBack: reload,
          isConnection: true,
        );
      case APIRequestStatus.error:
        return MyErrorWidget(
          refreshCallBack: reload,
          isConnection: false,
        );
      case APIRequestStatus.loaded:
        return child;
      default:
        return const LoadingWidget();
    }
  }
}
