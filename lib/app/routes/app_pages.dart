import 'package:get/get.dart';
import 'package:movie/app/modules/chat_module/chat_binding.dart';
import 'package:movie/app/modules/chat_module/chat_page.dart';
import 'package:movie/app/modules/search_module/search_binding.dart';
import 'package:movie/app/modules/search_module/search_page.dart';
import 'package:movie/app/modules/base_module/base_binding.dart';
import 'package:movie/app/modules/base_module/base_page.dart';
import 'package:movie/app/modules/seriesdetails_module/seriesdetails_binding.dart';
import 'package:movie/app/modules/seriesdetails_module/seriesdetails_page.dart';
import 'package:movie/app/modules/landing_module/landing_binding.dart';
import 'package:movie/app/modules/landing_module/landing_page.dart';
import 'package:movie/app/modules/details_module/details_binding.dart';
import 'package:movie/app/modules/details_module/details_page.dart';
import 'package:movie/app/modules/home_module/home_binding.dart';
import 'package:movie/app/modules/home_module/home_page.dart';
import 'package:movie/app/modules/splash_module/splash_page.dart';
part './app_routes.dart';

class AppPages {
  AppPages._();
  static final pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.initial,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: AppRoutes.details,
      page: () => const DetailsPage(),
      binding: DetailsBinding(),
    ),
    GetPage(
      name: AppRoutes.landing,
      page: () => const LandingPage(),
      binding: LandingBinding(),
    ),
    GetPage(
      name: AppRoutes.seriesdetails,
      page: () => const SeriesDetailsPage(),
      binding: SeriesDetailsBinding(),
    ),
    GetPage(
        name: AppRoutes.base,
        page: () => const BasePage(),
        binding: BaseBinding(),
    ),
    GetPage(
        name: AppRoutes.search,
        page: () => const SearchPage(),
        binding: SearchBinding(),
    ),
    GetPage(
        name: AppRoutes.chat,
        page: () => const ChatPage(),
        binding: ChatBinding(),
    ),
  ];
}
