import 'package:get/get.dart';

import '../../../app/data/provider/seriesdetails_provider.dart';
import '../../../app/modules/seriesdetails_module/seriesdetails_controller.dart';

class SeriesDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SeriesDetailsController>(
      () => SeriesDetailsController(
        provider: SeriesDetailsProvider(),
      ),
    );
  }
}
