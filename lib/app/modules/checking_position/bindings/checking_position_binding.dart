import 'package:get/get.dart';

import '../controllers/checking_position_controller.dart';

class CheckingPositionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckingPositionController>(
      () => CheckingPositionController(),
    );
  }
}
