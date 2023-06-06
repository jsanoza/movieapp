import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:movie/app/utils/network_connectivitiy.dart';
import '../../../app/data/provider/landing_provider.dart';

class LandingController extends GetxController with NetworkConnectivityMixin {
  final LandingProvider? provider;
  LandingController({this.provider});
  var canVibrate = false.obs;

  initVibrate() async {
    canVibrate.value = await Vibrate.canVibrate;
  }

  @override
  void onInit() {
    initVibrate();
    initNetworkConnectivity();
    super.onInit();
  }
}
