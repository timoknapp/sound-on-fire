import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:beautifulsoup/beautifulsoup.dart';
import 'package:sound_on_fire/model/QueryResult.dart';

Future<String> fetchURL(url) async {
  final response = await http.get(
    Uri.encodeFull(url),
  );
  return response.body.toString();
}

String findScriptURL(html) {
  Beautifulsoup soup = Beautifulsoup(html);
  final scriptElements = soup.find_all("script");
  for (var element in scriptElements) {
    if (element.attributes["src"] != null) {
      if (element.attributes["src"].contains("49-")) {
        return element.attributes["src"];
      }
    }
  }
  return "";
}

Future<String> getClientID() async {
  String body = await fetchURL("https://soundcloud.com/mt-marcy/cold-nights");
  String url = findScriptURL(body);
  String script = await fetchURL(url);
  RegExp exp = new RegExp(r'client_id:"([a-zA-Z0-9]+)"');
  Iterable<Match> matches = exp.allMatches(script);
  for (var match in matches) {
    return match.group(1).toString();
  }
  return "";
}

Future<String> getStreamURL(clientID, trackID) async {
  String body = await fetchURL(
      "https://api-v2.soundcloud.com/tracks/$trackID?client_id=$clientID");
  Map<String, dynamic> trackInfo = jsonDecode(body);
  String transcodingURL = "";
  for (var transcoding in trackInfo["media"]["transcodings"]) {
    if (transcoding["format"]["protocol"] == "progressive") {
      transcodingURL = transcoding["url"];
      break;
    }
  }
  if (transcodingURL != "") {
    body = await fetchURL(transcodingURL + "?client_id=" + clientID);
    Map<String, dynamic> urlInfo = jsonDecode(body);
    return urlInfo["url"];
  }
  return "";
}

Future<QueryResponse> queryResults(String query, String client_id,
    String app_version, String app_locale) async {
  final response = await http.get(
      'https://api-v2.soundcloud.com/search/queries?q=$query&client_id=$client_id&limit=10&offset=0&linked_partitioning=1&app_version=$app_version&app_locale=$app_locale');

  print('Response Status-Code: ${response.statusCode}');
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, then parse the JSON.
    print(response.body);
    return QueryResponse.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    throw Exception('Failed to query results');
  }
}
