import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;
import '../../models/rest_country_model.dart';
import 'api_endpoints.dart';

class GetLang extends GetxController {
  Map<String, Map<String, String>> langData = {};

  getCountryData({String? langType}) async {
    final apiUrl = Uri.parse(AppUtils.restCountryUrl);
    final response = await http.get(
      apiUrl,
      headers: {
        "Accept": "application/json",
      },
    );
    if (response.statusCode == 200) {
      for (int i = 0;
          i < restCountryModelFromJson(response.body)[0].translations!.length;
          i++) {
        if (restCountryModelFromJson(response.body)[0].translations != null) {
          restCountryModelFromJson(response.body)[0]
              .translations!
              .forEach((key, value) {
            // languas.add(key);
            langData.addEntries({
              langType!: {
                restCountryModelFromJson(response.body)[i].name!.common!:
                    value.common.toString()
              }
            }.entries);
          });
        }
      }
      print(langData);
      return langData;
    } else {
      print(response.body);
      return [];
    }
  }
}
