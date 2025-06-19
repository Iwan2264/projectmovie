import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';

import 'controllers/theme_controller.dart';
import 'controllers/navigation_controller.dart';
import 'controllers/watchlist_controller.dart';

import 'pages/movie/movie_details_page.dart';
import 'widgets/base_scaffold.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await GetStorage.init(); 
  Get.put(ThemeController(), permanent: true);
  Get.put(NavigationController(), permanent: true);
   Get.put(WatchlistController());
  runApp(const ProjectMovieApp());
}

class ProjectMovieApp extends StatelessWidget {
  const ProjectMovieApp({super.key}); // ✅ const constructor

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() => GetMaterialApp(
          title: 'Movie App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.red,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.red,
          ),
          themeMode: themeController.isDarkMode.value
              ? ThemeMode.dark
              : ThemeMode.light,

          home: const BaseScaffold(),

          getPages: [
            GetPage(
              name: '/movie/:id',
              page: () {
                final id = int.tryParse(Get.parameters['id'] ?? '') ?? 0;
                return MovieDetailsPage(movieId: id);
              },
            ),
          ],
        ));
  }
}
