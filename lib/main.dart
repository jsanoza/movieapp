import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:movie/app/data/model/adapter/trending_movies_adapter.dart';
import 'package:movie/app/data/model/adapter/trending_series_adapter.dart';
import 'package:movie/app/themes/app_colors.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:movie/app/routes/app_pages.dart';
import 'package:movie/app/themes/app_theme.dart';
import 'package:movie/app/translations/app_translations.dart';
import 'package:movie/app/utils/common.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'app/data/model/adapter/upcoming_movies_adapter.dart';
import 'app/data/model/adapter/upcoming_series_adapter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Get the application documents directory
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();

  // Initialize Hive
  Hive.init(appDocumentDirectory.path);

  // Register the adapter
  Hive.registerAdapter(UpcomingMoviesListAdapter());
  Hive.registerAdapter(TrendingMoviesListAdapter());
  Hive.registerAdapter(UpcomingSeriesListAdapter());
  Hive.registerAdapter(TrendingSeriesListAdapter());

  // Open the Hive box
  await Hive.openBox('newUpComingBox');
  await Hive.openBox('newTrendingBox');
  await Hive.openBox('newUpcomingSeriesBox');
  await Hive.openBox('newTrendingSeriesBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // debugInvertOversizedImages = true;

    return GestureDetector(
      // Dismiss keyboard when clicked outside
      onTap: () => Common.dismissKeyboard(),
      child: GetMaterialApp(
        builder: (context, child) => ResponsiveWrapper.builder(
          child,
          defaultScaleFactor: 1.2,
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(450, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
          background: const ColoredBox(color: AppColors.white),
        ),
        initialRoute: AppRoutes.initial,
        theme: AppThemes.themData,
        getPages: AppPages.pages,
        locale: AppTranslation.locale,
        translationsKeys: AppTranslation.translations,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
