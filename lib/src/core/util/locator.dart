import 'package:bird_guard/src/data/local/local_storage/local_storage.dart';
import 'package:bird_guard/src/data/local/secure_storage/secure_storage.dart';
import 'package:bird_guard/src/data/network/api_client.dart';
import 'package:bird_guard/src/data/repository/bird_repository.dart';
import 'package:bird_guard/src/data/repository/system_repository.dart';
import 'package:get_it/get_it.dart';

import '../../data/repository/auth_repository.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<LocalStorage>(LocalStorage());
  locator.registerSingleton<SystemRepository>(SystemRepository());
  locator.registerSingleton<SecureStorage>(SecureStorage());
  locator.registerSingleton<ApiClient>(ApiClient());
  locator.registerSingleton<AuthRepository>(AuthRepository());
  locator.registerSingleton<BirdRepository>(BirdRepository());


}