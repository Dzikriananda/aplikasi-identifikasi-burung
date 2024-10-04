import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage storage = const FlutterSecureStorage();


  writeSecureData(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  deleteSecureData(String key) async {
    return await storage.delete(key: key);
  }

  Future<dynamic> readSecureData(String key) async{
    return await storage.read(key: key);
  }

  purgeSecureStorage() async {
    return await storage.deleteAll();
  }
}