import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:beautifulsoup/beautifulsoup.dart';

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
