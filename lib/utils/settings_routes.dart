import 'package:flutter/material.dart';
//import 'package:projectmovie/pages/settings/subpages/saved_list_page.dart';
import 'package:projectmovie/pages/settings/subpages/appearance_page.dart';
//import 'package:projectmovie/pages/settings/subpages/language_page.dart';
//import 'package:projectmovie/pages/settings/subpages/account_settings_page.dart';
//import 'package:projectmovie/pages/settings/subpages/storage_downloads_page.dart';
//import 'package:projectmovie/pages/settings/subpages/help_support_page.dart';
import 'package:projectmovie/about_page.dart';
//import 'package:projectmovie/pages/auth/login_page.dart';

final Map<String, Widget Function()> settingsRoutes = {
  //'Saved List': () => SavedListPage(),
  'Appearance': () => AppearancePage(),
  //'Language': () => LanguagePage(),
  //'Account Settings': () => AccountSettingsPage(),
  //'Storage & Downloads': () => StorageDownloadsPage(),
  //'Help & Support': () => HelpSupportPage(),
  'About': () => AboutPage(),
};
