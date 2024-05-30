import 'package:bird_guard/src/data/model/detail_model/detail_model.dart';
import 'package:hive/hive.dart';

class LocalStorage {
  late Box box;
  late Box historyBox;

  // LocalStorage() {
  //   init();
  // }

  init() async {
    box = await Hive.openBox('localStorage');
    historyBox = await Hive.openBox('history');
  }

  Future<void> saveData(String key, dynamic value) async {
    await box.put(key, value);
  }

  Future<void> saveObject(dynamic data) async {
    await historyBox.add(data);
  }

  Future<void> deleteObject(int id) async {
    await historyBox.delete(id);
  }

  Future<dynamic> readAllObject() async {
    var value = historyBox.values;
    value.forEach((element) {print('elemenet : ${element.key}');});
    return historyBox.values;
  }

  Future<void> deleteData(String id) async {
    box.delete(id);
  }

  dynamic readLightData(String id) {
    return box.get(id);
  }

  Future<dynamic> readData(String id) async {
    return await box.get(id);
  }

  Future<void> resetDatabase() async {
    // await box.deleteFromDisk();
    await historyBox.deleteFromDisk();
  }

  Future<void> closeDatabase() async {
    await box.close();
    await historyBox.close();
  }


}