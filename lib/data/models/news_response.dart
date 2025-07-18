class NewsResponse {
  final String status;
  final int totalResults;
  final List<Map<String, dynamic>> articles;

  const NewsResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    return NewsResponse(
      status: json['status'] ?? '',
      totalResults: json['totalResults'] ?? 0,
      articles: List<Map<String, dynamic>>.from(json['articles'] ?? []),
    );
  }
}
