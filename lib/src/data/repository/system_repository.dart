
import 'package:bird_guard/src/core/util/locator.dart';
import 'package:bird_guard/src/data/local/local_storage/local_storage.dart';

class SystemRepository {

  LocalStorage storage = locator<LocalStorage>();

  Future<void> changeThemeMode(bool value) async {
    return await storage.saveData('isDarkMode', value);
  }

  Future<void> saveImageCompressionLevel(int level) async {
    return await storage.saveData('imageCompressionLevel', level);
  }

  Future<int?> getImageCompressionLevel() async {
    return await storage.readData('imageCompressionLevel');
  }

  Future<void> deleteCache() async {
    return await storage.deleteCache();
  }

  Future<void> reOpenDatabase() async {
    return await storage.reOpenBox();
  }

  Future<bool?> getThemeMode() async {
    return await storage.readData('isDarkMode');
  }

  Future<void> changeLocalization(String value) async {
    return await storage.saveData('localization', value);
  }

  Future<String?> getLocalization() async {
    return await storage.readData('localization');
  }

  Future<void> setAppFirstTimeOpened() async {
    return await storage.saveData('isFirstTimeAppOpened', false);
  }

  Future<bool?> getAppFirstTimeOpened() async {
    return await storage.readData('isFirstTimeAppOpened');
  }



}
