import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:beautifulsoup/beautifulsoup.dart';
import 'package:sound_on_fire/model/Query.dart';
import 'package:sound_on_fire/model/Search.dart';

const String scHost = 'https://soundcloud.com';
const String scApiHost = 'https://api-v2.soundcloud.com';

Future<String> fetchURL(url) async {
  final response = await http.get(
    Uri.encodeFull(url),
  );
  return response.body.toString();
}

String findScriptURL(html, prefix) {
  Beautifulsoup soup = Beautifulsoup(html);
  final scriptElements = soup.find_all("script");
  for (var element in scriptElements) {
    if (element.attributes["src"] != null) {
      if (element.attributes["src"].contains("$prefix-")) {
        return element.attributes["src"];
      }
    }
  }
  return "";
}

Future<String> getClientID() async {
  String body = await fetchURL("$scHost/mt-marcy/cold-nights");
  for (var prefix in ['49', '48']) {
    String url = findScriptURL(body, prefix);
    String script = await fetchURL(url);
    RegExp exp = new RegExp(r'client_id:"([a-zA-Z0-9]+)"');
    Iterable<Match> matches = exp.allMatches(script);
    if (matches.length == 0) {
      continue;
    }
    for (var match in matches) {
      return match.group(1).toString();
    }
  }
  return "";
}

Future<String> getStreamURL(clientID, trackID, {transcodeURL = ""}) async {
  String transcodingURL = transcodeURL;
  if (transcodingURL != "") {
    return getMediaUrl(clientID, transcodingURL);
  }
  String body =
      await fetchURL("$scApiHost/tracks/$trackID?client_id=$clientID");
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
    String body = await fetchURL(transcodingURL + "?client_id=" + clientID);
    Map<String, dynamic> urlInfo = jsonDecode(body);
    return urlInfo["url"];
  }
  return "";
}

Future<QueryResponse> queryResults(String query, String clientId) async {
  if (query != "") {
    final response = await http.get(
        '$scApiHost/search/queries?q=$query&client_id=$clientId&limit=7&offset=0');

    print('Response Status-Code: ${response.statusCode}');
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      // print(response.body);
      return QueryResponse.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to query results');
    }
  } else {
    return QueryResponse(collection: [], nextHref: "", queryUrn: "");
  }
}

Future<SearchResponse> searchResults(String query, String clientId) async {
  if (query != "") {
    final response = await http.get(
        '$scApiHost/search/tracks?q=$query&client_id=$clientId&limit=40&offset=0');

    print('Response Status-Code: ${response.statusCode}');
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      print(response.body);
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
