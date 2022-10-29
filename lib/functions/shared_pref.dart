import 'dart:convert';

import 'package:get/get.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

Future<bool> initGetX() async {
  var prefs = await StreamingSharedPreferences.instance;
  Get.put(prefs);
  return true;
}

class SharePrefFunc {
  static const nowPlayingKey = "nowPlaying";
  static StreamingSharedPreferences pref = Get.find();

  static setNowPlaying(Map<String, dynamic> song) {
    StreamingSharedPreferences pref = Get.find();
    String encodedMap = json.encode(song);
    pref.setString(nowPlayingKey, encodedMap);
  }

  static setIsCurrentPlaying(bool value) {
    pref.setBool("isNowPlaying", value);
  }

  static bool getIsCurrentPlaying() {
    Preference<bool> data = pref.getBool("isNowPlaying", defaultValue: false);
    return data.getValue();
  }

  static Map<String, dynamic> getnowPlayingSound() {
    Preference<String> data = pref.getString("nowPlaying", defaultValue: "{}");
    Map<String, dynamic> decodedData = json.decode(data.getValue());
    return decodedData;
  }

  static plyrSetVolu({double? newValue}) {
    pref.setDouble("volume", newValue ?? 1.0);
  }

  static updateLike(songName) {
    if (checkIsLiked(songName)) {
      unLikeSound(songName);
    } else {
      addLikedSound(songName);
    }
  }

  static addLikedSound(songName) {
    List<String> liked = getLikedSounds();
    liked.add(songName);
    pref.getStringList("likedSongs", defaultValue: []).setValue(liked);
  }

  static unLikeSound(songName) {
    List<String> liked = getLikedSounds();
    liked.remove(songName);
    pref.getStringList("likedSongs", defaultValue: []).setValue(liked);
  }

  static List<String> getLikedSounds() {
    return pref.getStringList("likedSongs", defaultValue: []).getValue();
  }

  static bool checkIsLiked(songName) {
    List<String> liked = getLikedSounds();
    return liked.contains(songName) ? true : false;
  }
}
