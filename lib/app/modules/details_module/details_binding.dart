import 'package:get/get.dart';

import '../../../app/data/provider/details_provider.dart';
import '../../../app/modules/details_module/details_controller.dart';

class DetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailsController>(
      () => DetailsController(
        provider: DetailsProvider(),
      ),
    );
  }
}
