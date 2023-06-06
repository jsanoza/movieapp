import 'package:get/get.dart';

import '../../../app/data/provider/chat_provider.dart';
import '../../../app/modules/chat_module/chat_controller.dart';

class ChatBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(
      () => ChatController(
        provider: ChatProvider(),
      ),
    );
  }
}
