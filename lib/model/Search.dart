import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class SearchResponse {
  final List<SearchResult> collection;
  final int totalResults;
  final String nextHref;
  final String queryUrn;

  SearchResponse(
      {this.collection, this.totalResults, this.nextHref, this.queryUrn});

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    List<SearchResult> list = [];
    if (json['collection'].length > 0) {
      for (var item in json['collection']) {
        list.add(SearchResult.fromJson(item));
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

class SearchResult {
  final int id;
  final String title;
  final String description;
  final String uri;
  final String transcodingURL;
  final Duration duration;
  final int playbackCount;
  final String artwork;
  final int likesCount;
  final DateTime date;

  SearchResult({
    this.id,
    this.title,
    this.description,
    this.uri,
    this.transcodingURL,
    this.duration,
    this.playbackCount,
    this.artwork,
    this.likesCount,
    this.date,
  });

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
    var numberFormat = NumberFormat.compact(locale: 'de');
    return numberFormat.format(this.playbackCount);
  }

  String printLikescount() {
    var numberFormat = NumberFormat.compact(locale: 'de');
    return numberFormat.format(this.likesCount);
  }

  String printUploadSince() {
    var now = DateTime.now();
    var old = this.date;
    Duration difference = now.difference(old);
    final timeAgo = now.subtract(difference);

    return timeago.format(timeAgo);
  }

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    String transcodingURL = "";
    for (var transcoding in json['media']['transcodings']) {
      if (transcoding["format"]["protocol"] == "progressive") {
        transcodingURL = transcoding["url"];
        break;
      }
    }
    return SearchResult(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      uri: json['uri'],
      transcodingURL: transcodingURL,
      duration: Duration(milliseconds: json['duration']),
      playbackCount: json['playback_count'],
      artwork: json['artwork_url'],
      likesCount: json['likes_count'],
      date: DateTime.parse(json['display_date']),
    );
  }
}

// Track Search
// {
//   "collection": [
//     {
//       "comment_count": 1116,
//       "full_duration": 6588201,
//       "downloadable": true,
//       "created_at": "2013-07-03T17:10:06Z",
//       "description": "This set was recorded at the \"Bachstelzen\"-Floor during Fusion Festival 2013.\nBecome our Superfriend: www.facebook.com/andhimmusic\nTweet with us: twitter.com/andhim_official\nGet our music on Beatport: http://www.beatport.com/artist/andhim/134386",
//       "media": {
//         "transcodings": [
//           {
//             "url": "https://api-v2.soundcloud.com/media/soundcloud:tracks:99537297/f6382682-7653-4d90-9c0a-f9e3d4929b78/stream/hls",
//             "preset": "mp3_0_0",
//             "duration": 6588201,
//             "snipped": false,
//             "format": {
//               "protocol": "hls",
//               "mime_type": "audio/mpeg"
//             },
//             "quality": "sq"
//           },
//           {
//             "url": "https://api-v2.soundcloud.com/media/soundcloud:tracks:99537297/f6382682-7653-4d90-9c0a-f9e3d4929b78/stream/progressive",
//             "preset": "mp3_0_0",
//             "duration": 6588201,
//             "snipped": false,
//             "format": {
//               "protocol": "progressive",
//               "mime_type": "audio/mpeg"
//             },
//             "quality": "sq"
//           },
//           {
//             "url": "https://api-v2.soundcloud.com/media/soundcloud:tracks:99537297/4dac11ad-2c05-4b5c-9e57-36456096792b/stream/hls",
//             "preset": "opus_0_0",
//             "duration": 6588201,
//             "snipped": false,
//             "format": {
//               "protocol": "hls",
//               "mime_type": "audio/ogg; codecs=\"opus\""
//             },
//             "quality": "sq"
//           }
//         ]
//       },
//       "title": "andhim live at Fusion Festival 2013",
//       "publisher_metadata": null,
//       "duration": 6588201,
//       "has_downloads_left": true,
//       "artwork_url": "https://i1.sndcdn.com/artworks-000052089664-ruhdt8-large.jpg",
//       "public": true,
//       "streamable": true,
//       "tag_list": "andhim live fusion \"dj mix\" \"bachstelzen \" 2013 \"andhim live\" \"andhim dj set\"",
//       "download_url": "https://api.soundcloud.com/tracks/99537297/download",
//       "genre": "Super-House",
//       "id": 99537297,
//       "reposts_count": 2864,
//       "state": "finished",
//       "label_name": null,
//       "last_modified": "2020-02-17T20:43:32Z",
//       "commentable": true,
//       "policy": "MONETIZE",
//       "visuals": null,
//       "kind": "track",
//       "purchase_url": null,
//       "sharing": "public",
//       "uri": "https://api.soundcloud.com/tracks/99537297",
//       "secret_token": null,
//       "download_count": 54183,
//       "likes_count": 21472,
//       "urn": "soundcloud:tracks:99537297",
//       "license": "all-rights-reserved",
//       "purchase_title": null,
//       "display_date": "2013-07-03T17:10:06Z",
//       "embeddable_by": "all",
//       "release_date": null,
//       "user_id": 873178,
//       "monetization_model": "BLACKBOX",
//       "waveform_url": "https://wave.sndcdn.com/MElGlogYrT05_m.json",
//       "permalink": "andhim-live-at-fusion",
//       "permalink_url": "https://soundcloud.com/andhim/andhim-live-at-fusion",
//       "user": {
//         "avatar_url": "https://i1.sndcdn.com/avatars-000040375728-f607j6-large.jpg",
//         "city": "Cologne / Berlin",
//         "comments_count": 132,
//         "country_code": "DE",
//         "created_at": "2010-04-16T09:31:03Z",
//         "creator_subscriptions": [
//           {
//             "product": {
//               "id": "creator-pro-unlimited"
//             }
//           }
//         ],
//         "creator_subscription": {
//           "product": {
//             "id": "creator-pro-unlimited"
//           }
//         },
//         "description": "---- BOOKING CONTACT ----\n\nBookings // Love Letters: markus@return-booking.com \nBookings for North and South America: supreet@artistalife.com\nSuperfriends Records (Label Management): peter@superfriends.de\n\n\n----------------------------------------------------",
//         "followers_count": 196325,
//         "followings_count": 56,
//         "first_name": "",
//         "full_name": "",
//         "groups_count": 0,
//         "id": 873178,
//         "kind": "user",
//         "last_modified": "2019-12-12T10:36:14Z",
//         "last_name": "",
//         "likes_count": 135,
//         "playlist_likes_count": 2,
//         "permalink": "andhim",
//         "permalink_url": "https://soundcloud.com/andhim",
//         "playlist_count": 25,
//         "reposts_count": null,
//         "track_count": 159,
//         "uri": "https://api.soundcloud.com/users/873178",
//         "urn": "soundcloud:users:873178",
//         "username": "andhim",
//         "verified": false,
//         "visuals": {
//           "urn": "soundcloud:users:873178",
//           "enabled": true,
//           "visuals": [
//             {
//               "urn": "soundcloud:visuals:70630342",
//               "entry_time": 0,
//               "visual_url": "https://i1.sndcdn.com/visuals-000000873178-yzqoZY-original.jpg",
//               "link": "http://po.st/HMTAHSpotify"
//             }
//           ]
//         }
//       },
//       "playback_count": 815716
//     }
//   ],
//   "total_results": 8950,
//   "next_href": "https://api-v2.soundcloud.com/search/tracks?q=andhim&offset=20&query_urn=soundcloud%3Asearch%3Ac2412a327ab7433094190907f178ec7e&limit=20",
//   "query_urn": "soundcloud:search:c2412a327ab7433094190907f178ec7e"
// }
