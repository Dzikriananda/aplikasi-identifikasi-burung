import 'dart:developer';

import 'package:bird_guard/src/core/classes/enum.dart';
import 'package:hive/hive.dart';

class LocalStorage {
  late Box box;
  late Box historyBox;
  late Box speciesListBox;

  init() async {
    box = await Hive.openBox('localStorage');
    historyBox = await Hive.openBox('history');
    speciesListBox = await Hive.openBox('speciesList');
  }

  reOpenBox() async {
    if(!historyBox.isOpen && !speciesListBox.isOpen) {
      historyBox = await Hive.openBox('history');
      speciesListBox = await Hive.openBox('speciesList');
    } else {
      log('box diopen');
    }
  }

  Future<void> saveData(String key, dynamic value) async {
    await box.put(key, value);
  }

  Future<int?> saveObject(boxType type,dynamic data,{String? key}) async {
    switch(type) {
      case boxType.speciesList : {
        return await speciesListBox.add(data);
      }
      case boxType.history : {
        return await historyBox.add(data);
      }
      case boxType.general : {
          await box.put(key,data);
      }
    }
    // if(type == boxType.history) {
    //   await historyBox.add(data);
    // } else if(type == boxType.speciesList) {
    //   await speciesListBox.add(data);
    // } else {
    //   await box.put(key,data);
    // }
  }

  Future<void> deleteObject(int id) async {
    await historyBox.delete(id);
  }

  Future<dynamic> readAllObject(boxType type) async {
    switch(type) {
      case boxType.speciesList : {
        var value = speciesListBox.values;
      }
      case boxType.history : {
        var value = historyBox.values;
      }
      case boxType.general : {
        var value = box.values;
      }
    }
  }

  Future<dynamic> readSingleObject(boxType type,String id) async {
    switch(type) {
      case boxType.history : {
        var value = historyBox.values.where((item) => item.id == int.parse(id)).toList();
        if(value.isNotEmpty) {
          return value[0];
        } else {
          return null;
        }
      }
      case boxType.speciesList: {
        var value = speciesListBox.values.where((item) => item.id == int.parse(id)).toList();
        if(value.isNotEmpty) {
          return value[0];
        } else {
          return null;
        }
      }
      case boxType.general : {
        var value = box.get(id);
        return value;
      }
    }
    // if(type == boxType.history) {
    //   var value = historyBox.values.where((item) => item.id == id).toList();
    //   if(value.isNotEmpty) {
    //     return value[0];
    //   } else {
    //     return null;
    //   }
    // } else if(type == boxType.speciesList) {
    //   var value = speciesListBox.values.where((item) => item.id == id).toList();
    //   if(value.isNotEmpty) {
    //     return value[0];
    //   } else {
    //     return null;
    //   }
    // } else {
    //   var value = box.get(id);
    //   return value;
    // }
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

  // Future<dynamic> readSize() async {
  //   print(historyBox.size)
  // }

  Future<void> deleteCache() async {
    await historyBox.deleteFromDisk();
    await speciesListBox.deleteFromDisk();
    await box.delete('imageCompressionLevel');
  }

  Future<void> closeDatabase() async {
    await box.close();
    await historyBox.close();
  }


}