import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:wavsound/functions/shared_pref.dart';

class PlayerFunc {
  static final player = AudioPlayer();
  static Duration seekDur = const Duration(seconds: 10);

  static initPlayer() async {
    Map<String, dynamic> lastSound = SharePrefFunc.getnowPlayingSound();
    if (lastSound != {} || lastSound != "{}") {
      player.setAudioSource(AudioSource.uri(Uri.parse(lastSound["url"]),
          tag: MediaItem(
              id: lastSound["url"],
              title: lastSound["song"],
              album: lastSound["source"],
              artUri: Uri.parse(lastSound["image"]))));
      player.setVolume(SharePrefFunc.pref
              .getDouble("volume", defaultValue: 100.0)
              .getValue() /
          100);
    }
  }

  static onNewSongClick(Map<String, dynamic> song, callback) async {
    SharePrefFunc.setNowPlaying(song);

    player.setAudioSource(AudioSource.uri(Uri.parse(song["url"]),
        tag: MediaItem(
            id: song["url"],
            title: song["song"],
            album: song["source"],
            artUri: Uri.parse(song["image"]))));
    player.setVolume(
        SharePrefFunc.pref.getDouble("volume", defaultValue: 100.0).getValue() /
            100);
    player.play();
    SharePrefFunc.setIsCurrentPlaying(true);
    callback();
  }

  static onLike(bool isLiked, songName) {
    if (isLiked) {
      SharePrefFunc.addLikedSound(songName);
    } else {
      SharePrefFunc.unLikeSound(songName);
    }
  }

  static setVolume(newValue) {
    SharePrefFunc.plyrSetVolu(newValue: newValue);
    player.setVolume(newValue / 100 ?? 1.0);
  }

  static onPause({bool? isPause}) {
    Map<String, dynamic> nowPlaying = SharePrefFunc.getnowPlayingSound();
    nowPlaying.update("paused", (value) => isPause ?? !value);
    SharePrefFunc.setNowPlaying(nowPlaying);

    if (nowPlaying['paused']) {
      player.pause();
    } else {
      player.play();
    }
  }

  static skip() {
    player.seek(player.position + seekDur);
  }

  static rewind() {
    player.seek(player.position - seekDur);
  }
}




// class Tmp{
//     static final player = AudioPlayer();
//   static Duration seekDur = const Duration(seconds: 10);
//     static onRepeat() {
//     Map<String, dynamic> nowPlaying = SharePrefFunc.getnowPlayingSound();
//     nowPlaying.update("loop", (value) => !value);
//     SharePrefFunc.setNowPlaying(nowPlaying);

//     if (nowPlaying["loop"]) {
//       player.setLoopMode(LoopMode.all);
//     } else {
//       player.setLoopMode(LoopMode.off);
//     }
//   }


// }
