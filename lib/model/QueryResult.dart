class QueryResponse {
  final List<QueryResult> collection;
  final String next_href;
  final String query_urn;

  QueryResponse({this.collection, this.next_href, this.query_urn});

  factory QueryResponse.fromJson(Map<String, dynamic> json) {
    List<QueryResult> list = [];
    if (json['collection'].length > 0) {
      for (var item in json['collection']) {
        list.add(QueryResult.fromJson(item));
      }
    }
    return QueryResponse(
      collection: list,
      next_href: json['next_href'],
      query_urn: json['query_urn'],
    );
  }
}

class QueryResult {
  final String output;
  final String query;

  QueryResult({this.output, this.query});

  factory QueryResult.fromJson(Map<String, dynamic> json) {
    return QueryResult(
      output: json['output'],
      query: json['query'],
    );
  }
}

// {
//   "collection":[
//     {"output":"kobosil","query":"kobosil"},{"output":"kobosil set","query":"kobosil set"}
//   ],
//   "next_href":null,
//   "query_urn":"soundcloud:search-autocomplete:5fb8a248ee5442a88058001bea8863d0"
// }
