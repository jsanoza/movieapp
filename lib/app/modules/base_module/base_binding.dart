import 'package:get/get.dart';
import 'package:movie/app/data/provider/home_provider.dart';

import '../../../app/data/provider/base_provider.dart';
import '../../../app/modules/base_module/base_controller.dart';
import '../home_module/home_controller.dart';

class BaseBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BaseController>(
      () => BaseController(
        provider: BaseProvider(),
      ),
    );

    Get.lazyPut<HomeController>(
      () => HomeController(
        provider: HomeProvider(),
      ),
    );
  }
}
