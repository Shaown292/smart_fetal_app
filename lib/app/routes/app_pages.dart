import 'package:get/get.dart';

import '../modules/bluetooth/bindings/bluetooth_binding.dart';
import '../modules/bluetooth/views/bluetooth_view.dart';
import '../modules/checking_position/bindings/checking_position_binding.dart';
import '../modules/checking_position/views/checking_position_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.CHECKING_POSITION,
      page: () => const CheckingPositionView(),
      binding: CheckingPositionBinding(),
    ),
    GetPage(
      name: _Paths.BLUETOOTH,
      page: () => const BluetoothView(),
      binding: BluetoothBinding(),
    ),
  ];
}
