import 'package:bird_guard/src/core/localization/lang/en_us.dart';
import 'package:bird_guard/src/core/localization/lang/id_id.dart';
import 'package:get/get.dart';


class AppLocalizations extends Translations {

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': EnglishUs.getString(),
    'id_ID': IndonesiaId.getString(),
  };
}