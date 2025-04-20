import 'package:awesome_video_player/awesome_video_player.dart';

BetterPlayerVideoFormat? detectVideoFormat(String url) {
  if (url.contains(".mpd")) {
    return BetterPlayerVideoFormat.dash;
  } else if (url.contains(".m3u8")) {
    return BetterPlayerVideoFormat.hls;
  } else if (url.contains(".ism") || url.contains(".isml")) {
    return BetterPlayerVideoFormat.ss;
  } else if (url.contains(".mp4")) {
    return BetterPlayerVideoFormat.other;
  } else {
    return null;
  }
}

BetterPlayerDrmType getDrmType(String type) {
  switch (type.toLowerCase()) {
    case 'clearkey':
      return BetterPlayerDrmType.clearKey;
    case 'widevine':
      return BetterPlayerDrmType.widevine;
    case 'fairplay':
      return BetterPlayerDrmType.fairplay;
    default:
      return BetterPlayerDrmType.clearKey;
  }
}
