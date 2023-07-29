import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class SearchResponse {
  final List<Track> collection;
  final int totalResults;
  final String nextHref;
  final String queryUrn;

  SearchResponse(
      {required this.collection, required this.totalResults, required this.nextHref, required this.queryUrn});

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    List<Track> list = [];
    if (json['collection'].length > 0) {
      for (var item in json['collection']) {
        Track track = Track.fromJson(item);
        if (track.isNull() == false) list.add(track);
      } 
    }
    return SearchResponse(
      collection: list,
      totalResults: json['total_results'],
      nextHref: json['next_href'],
      queryUrn: json['query_urn'],
    );
  }
}

class Track {
  final int id;
  final String title;
  final String? description;
  final String uri;
  final String transcodingURL;
  String streamUrl;
  final Duration duration;
  final int? playbackCount;
  final String? artwork;
  final int likesCount;
  DateTime? date;// = DateTime.now();
  final String username;

  Track({
    this.id = -1,
    this.title = "", 
    this.description,
    this.uri = "",
    this.transcodingURL = "",
    this.duration = const Duration(seconds: 0),
    this.playbackCount = 0,
    this.artwork = "",
    this.likesCount = 0,
    this.date,
    this.streamUrl = "",
    this.username = "",
  });

  // write method isNull() which will check if id, title streamUrl and uri is null
  bool isNull() {
    if (this.id == -1 ||
        this.title == "" ||
        this.transcodingURL == "" ||
        this.duration == Duration(seconds: 0) ||
        this.uri == "") {
      return true;
    } else {
      return false;
    }
  }

  void setStreamUrl(String streamUrl) {
    this.streamUrl = streamUrl;
  }

  String printDuration() {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(this.duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(this.duration.inSeconds.remainder(60));
    return "${twoDigits(this.duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  String printPlaycount() {
    var numberFormat = NumberFormat.compact(locale: 'en');
    return numberFormat.format(this.playbackCount);
  }

  String printLikescount() {
    var numberFormat = NumberFormat.compact(locale: 'en');
    return numberFormat.format(this.likesCount);
  }

  String printUploadSince() {
    var now = DateTime.now();
    if (this.date != null) {
      var old = this.date;
      Duration difference = now.difference(old!);
      final timeAgo = now.subtract(difference);
      return timeago.format(timeAgo);
    } else {
      return "";
    }
  }

  factory Track.fromJson(Map<String, dynamic> json) {
    String transcodingURL = "";
    for (var transcoding in json['media']['transcodings']) {
      if (transcoding["format"]["protocol"] == "progressive") {
        transcodingURL = transcoding["url"];
        break;
      }
    }
    if (transcodingURL != "") {
      return Track(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        uri: json['uri'],
        transcodingURL: transcodingURL,
        duration: Duration(milliseconds: json['duration']),
        playbackCount:
            json['playback_count'] != null ? json['playback_count'] : 0,
        artwork: json['artwork_url'],
        likesCount: json['likes_count'] != null ? json['likes_count'] : 0,
        date: DateTime.parse(json['display_date']),
        username: json['user']['username'] != null ? json['user']['username'] : "",
      );
    } else {
      // This will ignore all track which do not consist of "protocol" type "progressive"
      return Track();
    }
  }
}
