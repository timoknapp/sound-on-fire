class AutocompleteResponse {
  final List<AutocompleteResult> collection;
  final String? nextHref;
  final String queryUrn;

  AutocompleteResponse({required this.collection, required this.nextHref, required this.queryUrn});

  factory AutocompleteResponse.fromJson(Map<String, dynamic> json) {
    List<AutocompleteResult> list = [];
    if (json['collection'].length > 0) {
      for (var item in json['collection']) {
        list.add(AutocompleteResult.fromJson(item));
      }
    }
    return AutocompleteResponse(
      collection: list,
      nextHref: json['next_href'],
      queryUrn: json['query_urn'],
    );
  }
}

class AutocompleteResult {
  final String output;
  final String query;

  AutocompleteResult({required this.output, required this.query});

  factory AutocompleteResult.fromJson(Map<String, dynamic> json) {
    return AutocompleteResult(
      output: json['output'],
      query: json['query'],
    );
  }
}