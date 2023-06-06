import 'dart:developer';

import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import '../../../app/data/provider/chat_provider.dart';
import '../../data/model/tmdb/series_details.dart';
import '../../utils/common.dart';
import '../../utils/network_connectivitiy.dart';

class ChatController extends GetxController with NetworkConnectivityMixin {
  final ChatProvider? provider;
  ChatController({this.provider});

  var isLoaded = false.obs;
  var top = 0.0.obs;
  var headerImageurl = "".obs;
  var titleOrName = "".obs;
  var overview = "".obs;
  var releaseYear = "".obs;
  var answer = "".obs;

  var isSubmitted = false.obs;

  List<String> questions = [
    "Unique Synopsis",
    "Creative First Impressions",
    "Imaginative Summary",
  ];

  var canVibrate = false.obs;

  initVibrate() async {
    canVibrate.value = await Vibrate.canVibrate;
  }

  void updateTop(double value) {
    top.value = value;
  }

  sendChat(String questions) async {
    Common.showLoading();
    isSubmitted.value = false;
    final messages = [
      {'role': 'user', 'content': "You are a movie critic. Provide a $questions of the movie/series ${titleOrName.value} release/first air date ${releaseYear.value}. Avoid using '\' and other special characters aside from ''' "},
    ];
    var response = await provider!.completeChat(message: messages).whenComplete(() {
      Get.back();
    });
    answer.value = response;
    isSubmitted.value = true;
  }

  @override
  void onInit() {
    isLoaded.value = true;
    initNetworkConnectivity();
    super.onInit();
  }
}
