import 'package:get/get.dart';

import '../../../app/data/provider/landing_provider.dart';
import '../../../app/modules/landing_module/landing_controller.dart';

class LandingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LandingController>(
      () => LandingController(
        provider: LandingProvider(),
      ),
    );
  }
}
