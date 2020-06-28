import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:beautifulsoup/beautifulsoup.dart';
import 'package:sound_on_fire/models/Autocomplete.dart';
import 'package:sound_on_fire/models/Track.dart';
import 'package:sound_on_fire/util/constants.dart';

Future<String> fetchUrl(url) async {
  final response = await http.get(
    Uri.encodeFull(url),
  );
  return response.body.toString();
}

Future<String> getClientId() async {
  String body = await fetchUrl("$soundCloudHost/mt-marcy/cold-nights");
  Beautifulsoup soup = Beautifulsoup(body);
  final scriptElements = soup.find_all("script");
  for (var element in scriptElements) {
    if (element.attributes["src"] != null) {
      String script = await fetchUrl(element.attributes["src"]);
      RegExp exp = new RegExp(r'client_id:"([a-zA-Z0-9]+)"');
      Iterable<Match> matches = exp.allMatches(script);
      if (matches.length == 0) {
        continue;
      }
      for (var match in matches) {
        return match.group(1).toString();
      }
    }
  }
  return "";
}

Future<String> getStreamUrl(clientID, trackID, {transcodeURL = ""}) async {
  String transcodingURL = transcodeURL;
  if (transcodingURL != "") {
    return getMediaUrl(clientID, transcodingURL);
  }
  String body =
      await fetchUrl("$soundCloudApiHost/tracks/$trackID?client_id=$clientID");
  Map<String, dynamic> trackInfo = jsonDecode(body);
  for (var transcoding in trackInfo["media"]["transcodings"]) {
    if (transcoding["format"]["protocol"] == "progressive") {
      transcodingURL = transcoding["url"];
      break;
    }
  }
  return getMediaUrl(clientID, transcodingURL);
}

Future<String> getMediaUrl(clientID, transcodingURL) async {
  if (transcodingURL != "") {
    String body = await fetchUrl(transcodingURL + "?client_id=" + clientID);
    Map<String, dynamic> urlInfo = jsonDecode(body);
    return urlInfo["url"];
  }
  return "";
}

Future<AutocompleteResponse> queryResults(
    String query, int limit, String clientId) async {
  if (query != "") {
    final response = await http.get(
        '$soundCloudApiHost/search/queries?q=$query&client_id=$clientId&limit=$limit&offset=0');

    // print('Response Status-Code: ${response.statusCode}');
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      // print(response.body);
      return AutocompleteResponse.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to query results');
    }
  } else {
    return AutocompleteResponse(collection: [], nextHref: "", queryUrn: "");
  }
}

Future<SearchResponse> searchTracks(
    String query, int limit, String clientId) async {
  if (query != "") {
    final response = await http.get(
        '$soundCloudApiHost/search/tracks?q=$query&client_id=$clientId&limit=$limit&offset=0');

    // print('Response Status-Code: ${response.statusCode}');
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      // print(response.body);
      return SearchResponse.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to query results');
    }
  } else {
    return SearchResponse(
        collection: [], totalResults: 0, nextHref: "", queryUrn: "");
  }
}
