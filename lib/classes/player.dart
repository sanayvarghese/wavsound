class PlayingSound {
  String song;
  String image;
  String url;
  bool paused;
  bool loop;
  int timer;
  String source;

  PlayingSound(
    this.song,
    this.image,
    this.url,
    this.paused,
    this.loop,
    this.timer,
    this.source,
  );
}

class Sounds {
  String song;
  String image;
  String url;
  String source;
  bool downloaded;
  bool favorite;

  Sounds(this.song, this.image, this.url, this.source, this.downloaded,
      this.favorite);
}
