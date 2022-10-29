import 'package:get/get.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

Future<bool> initSessionManager() async {
  var prefs = await StreamingSharedPreferences.instance;
  Get.put(prefs);
  return true;
}
