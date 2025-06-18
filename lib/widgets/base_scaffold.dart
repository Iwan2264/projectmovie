import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/navigation_controller.dart';
import '../pages/movie/movie_list_page.dart';
import '../pages/home/home_page.dart';
import '../pages/settings/settings_page.dart';

class BaseScaffold extends StatelessWidget {
  final String? titleText;
  final Widget? child;

  const BaseScaffold({super.key, this.titleText, this.child});

  @override
  Widget build(BuildContext context) {
    final navController = Get.find<NavigationController>();

    final pages = [
      MovieListPage(),
      HomePage(),
      SettingsPage(),
    ];

    return Obx(() {
      return Scaffold(
        appBar: titleText != null
            ? AppBar(
                title: Text(titleText!),
                centerTitle: true,
              )
            : null,
        body: child ?? IndexedStack(
          index: navController.selectedIndex.value,
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: navController.selectedIndex.value,
          onTap: (index) => navController.selectedIndex.value = index,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
      );
    });
  }
}