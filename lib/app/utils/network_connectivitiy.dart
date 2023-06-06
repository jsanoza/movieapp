import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/app/utils/common.dart';

mixin NetworkConnectivityMixin {
  StreamSubscription<ConnectivityResult>? subscription;

  @protected
  void initNetworkConnectivity() {
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      checkNetworkConnectivity();
    });
  }

  @protected
  void disposeNetworkConnectivity() {
    subscription?.cancel();
  }

  @protected
  Future<void> checkNetworkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      if(!Get.isSnackbarOpen){
        Common.showError("No network connection. You are now viewing the app offline mode.", Duration(milliseconds: 5000));
      }
    }
  }
}
