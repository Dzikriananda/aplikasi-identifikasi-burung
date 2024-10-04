import 'package:bird_guard/src/core/localization/lang/en_us.dart';
import 'package:bird_guard/src/core/localization/lang/id_id.dart';
import 'package:bird_guard/src/core/util/file_manager.dart';
import 'package:get/get.dart';


class AppLocalizations extends Translations {
  static late Map<String,String> idJson;
  static late Map<String,String> engJson;

  static initJson() async {
    idJson = await FileManager().readJson("assets/localization/id.json");
    engJson = await FileManager().readJson("assets/localization/eng.json");
  }

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': engJson,
    'id_ID': idJson,
  };
}