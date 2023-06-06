import 'package:get/get.dart';

import '../../../app/data/provider/search_provider.dart';
import '../../../app/modules/search_module/search_controller.dart';

class SearchBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchPageController>(
      () => SearchPageController(
        provider: SearchProvider(),
      ),
    );
  }
}
