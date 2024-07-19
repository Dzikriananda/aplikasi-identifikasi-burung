import 'package:bird_guard/src/core/environment_settings.dart';
import 'package:bird_guard/main.dart' as Main;

void main() async {
  EnvironmentSettings.setEnvironment(EnvironmentMode.development);
  Main.main();
}