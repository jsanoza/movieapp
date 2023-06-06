import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/app/modules/home_module/trial.dart';
import 'package:movie/app/routes/app_pages.dart';
import 'package:movie/app/utils/loading.dart';

class SplashPage extends GetWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offNamed(AppRoutes.landing);
      // Get.off(NewsScreen());
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              color: Colors.black,
              child: Loading(
                loadingType: LoadingType.doubleBounce,
              ),
            ),
          )
        ],
      ),
    );
  }
}
