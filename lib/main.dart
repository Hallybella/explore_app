import 'package:explore_hng/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'Screen/home.dart';
import 'controllers/theme_controllers/app_theme.dart';
import 'controllers/theme_controllers/theme_service.dart';
import 'services/api_services/lang_convert.dart';
import 'services/misc/language_tool.dart';

void main() async {
  await GetStorage.init();
  // final translator = GoogleTranslator();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  // final GetLang lazyLangController = Get.lazyPut();
  // This widget is the root of your application.
  Locale? _locale;

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: Get.deviceLocale,
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      home: const MyHomePage(),
    );
  }
}
