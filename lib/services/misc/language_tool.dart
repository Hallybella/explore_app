import 'package:explore_hng/services/api_services/lang_convert.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleString extends Translations {
  final GetLang _langController = Get.find();
  @override
  Map<String, Map<String, String>> get keys {
    print("Great guy");
    return _langController.langData;
  }
}
