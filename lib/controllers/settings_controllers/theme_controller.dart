import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  // Existing theme mode
  final themeMode = ThemeMode.system.obs;
  
  // New appearance features
  final selectedColorScheme = 'blue'.obs;
  final fontSize = 'medium'.obs;
  final isHighContrast = false.obs;
  final reducedAnimations = false.obs;
  
  SharedPreferences? _prefs;
  Timer? _saveTimer;

  // Color scheme options
  final Map<String, Color> colorSchemes = {
    'blue': Colors.blue,
    'purple': Colors.purple,
    'green': Colors.green,
    'orange': Colors.orange,
    'teal': Colors.teal,
    'pink': Colors.pink,
  };

  // Font size multipliers
  final Map<String, double> fontSizeMultipliers = {
    'small': 0.85,
    'medium': 1.0,
    'large': 1.15,
    'extra_large': 1.3,
  };

  @override
  void onInit() {
    super.onInit();
    _initPrefs();
  }

  @override
  void onClose() {
    _saveTimer?.cancel();
    super.onClose();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    loadSettings();
  }

  void loadSettings() {
    if (_prefs == null) return;
    
    // Load theme mode
    final modeIndex = _prefs!.getInt('themeMode') ?? ThemeMode.system.index;
    themeMode.value = ThemeMode.values[modeIndex];
    
    // Load color scheme
    selectedColorScheme.value = _prefs!.getString('colorScheme') ?? 'blue';
    
    // Load font size
    fontSize.value = _prefs!.getString('fontSize') ?? 'medium';
    
    // Load accessibility settings
    isHighContrast.value = _prefs!.getBool('highContrast') ?? false;
    reducedAnimations.value = _prefs!.getBool('reducedAnimations') ?? false;
    
    // Apply loaded settings
    _updateAppTheme();
  }

  void setThemeImmediate(ThemeMode mode) {
    themeMode.value = mode;
    _updateAppTheme();
    _debounceSave();
  }

  void setColorScheme(String scheme) {
    if (colorSchemes.containsKey(scheme)) {
      selectedColorScheme.value = scheme;
      _updateAppTheme();
      _debounceSave();
    }
  }

  void setFontSize(String size) {
    if (fontSizeMultipliers.containsKey(size)) {
      fontSize.value = size;
      _updateAppTheme();
      _debounceSave();
    }
  }

  void toggleHighContrast() {
    isHighContrast.value = !isHighContrast.value;
    _updateAppTheme();
    _debounceSave();
  }

  void toggleReducedAnimations() {
    reducedAnimations.value = !reducedAnimations.value;
    _debounceSave();
  }

  void _updateAppTheme() {
    final seedColor = colorSchemes[selectedColorScheme.value]!;
    final fontMultiplier = fontSizeMultipliers[fontSize.value]!;
    
    // Create light theme
    final lightColorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.light,
    );
    
    // Create dark theme
    final darkColorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
    );
    
    final lightTheme = ThemeData(
      colorScheme: isHighContrast.value 
          ? _createHighContrastScheme(lightColorScheme)
          : lightColorScheme,
      textTheme: _createTextTheme(fontMultiplier),
      useMaterial3: true,
    );
    
    final darkTheme = ThemeData(
      colorScheme: isHighContrast.value 
          ? _createHighContrastScheme(darkColorScheme)
          : darkColorScheme,
      textTheme: _createTextTheme(fontMultiplier),
      useMaterial3: true,
    );
    
    Get.changeTheme(lightTheme);
    Get.changeTheme(darkTheme);
    Get.changeThemeMode(themeMode.value);
  }

  TextTheme _createTextTheme(double fontMultiplier) {
    return ThemeData().textTheme.apply(
      fontSizeFactor: fontMultiplier,
      fontFamily: 'Roboto', // You can make this configurable too
    );
  }

  ColorScheme _createHighContrastScheme(ColorScheme baseScheme) {
    return baseScheme.copyWith(
      primary: baseScheme.brightness == Brightness.light 
          ? Colors.black 
          : Colors.white,
      onPrimary: baseScheme.brightness == Brightness.light 
          ? Colors.white 
          : Colors.black,
      secondary: baseScheme.brightness == Brightness.light 
          ? Colors.grey[800] 
          : Colors.grey[200],
    );
  }

  void _debounceSave() {
    _saveTimer?.cancel();
    _saveTimer = Timer(const Duration(milliseconds: 500), () {
      _saveSettingsToPrefs();
    });
  }

  Future<void> _saveSettingsToPrefs() async {
    try {
      final prefs = _prefs ?? await SharedPreferences.getInstance();
      await Future.wait([
        prefs.setInt('themeMode', themeMode.value.index),
        prefs.setString('colorScheme', selectedColorScheme.value),
        prefs.setString('fontSize', fontSize.value),
        prefs.setBool('highContrast', isHighContrast.value),
        prefs.setBool('reducedAnimations', reducedAnimations.value),
      ]);
    } catch (e) {
      debugPrint('Failed to save theme preferences: $e');
    }
  }

  // Helper getters
  String get currentColorSchemeName => selectedColorScheme.value;
  String get currentFontSizeName => fontSize.value;
  double get currentFontMultiplier => fontSizeMultipliers[fontSize.value] ?? 1.0;
  
  // Reset to defaults
  void resetToDefaults() {
    themeMode.value = ThemeMode.system;
    selectedColorScheme.value = 'blue';
    fontSize.value = 'medium';
    isHighContrast.value = false;
    reducedAnimations.value = false;
    _updateAppTheme();
    _debounceSave();
  }
}