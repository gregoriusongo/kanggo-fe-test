import '../models/news_response.dart';

class MockNewsApiService {
  static const List<Map<String, dynamic>> _mockArticles = [
    {
      'title': 'Breaking: Flutter 4.0 Released with Amazing Features',
      'description': 'Flutter team announces the release of Flutter 4.0 with revolutionary performance improvements and new widgets.',
      'url': 'https://flutter.dev/flutter-4.0',
      'urlToImage': 'https://via.placeholder.com/300x200?text=Flutter+4.0',
      'publishedAt': '2025-01-15T10:30:00Z',
      'author': 'Flutter Team',
      'source': {'name': 'Flutter Official'},
    },
    {
      'title': 'AI Revolution: ChatGPT Reaches 1 Billion Users',
      'description': 'OpenAI announces that ChatGPT has reached a milestone of 1 billion active users worldwide.',
      'url': 'https://openai.com/chatgpt-1billion',
      'urlToImage': 'https://via.placeholder.com/300x200?text=ChatGPT+Milestone',
      'publishedAt': '2025-01-15T09:15:00Z',
      'author': 'OpenAI Team',
      'source': {'name': 'OpenAI'},
    },
    {
      'title': 'Climate Change: New Renewable Energy Breakthrough',
      'description': 'Scientists develop new solar panel technology that is 50% more efficient than current solutions.',
      'url': 'https://renewableenergy.com/breakthrough',
      'urlToImage': 'https://via.placeholder.com/300x200?text=Solar+Energy',
      'publishedAt': '2025-01-15T08:45:00Z',
      'author': 'Dr. Sarah Johnson',
      'source': {'name': 'Green Tech News'},
    },
    {
      'title': 'Space Exploration: Mars Mission Update',
      'description': 'NASA provides latest updates on the Mars exploration mission with new discoveries about water on Mars.',
      'url': 'https://nasa.gov/mars-mission-update',
      'urlToImage': 'https://via.placeholder.com/300x200?text=Mars+Mission',
      'publishedAt': '2025-01-15T07:20:00Z',
      'author': 'NASA',
      'source': {'name': 'NASA'},
    },
    {
      'title': 'Tech Giants Unite for Quantum Computing Initiative',
      'description': 'Microsoft, Google, and IBM announce joint venture to accelerate quantum computing development.',
      'url': 'https://quantumcomputing.com/joint-venture',
      'urlToImage': 'https://via.placeholder.com/300x200?text=Quantum+Computing',
      'publishedAt': '2025-01-15T06:30:00Z',
      'author': 'Tech Reporters',
      'source': {'name': 'Tech Today'},
    },
  ];

  Future<NewsResponse> getTopHeadlines({
    int page = 1,
    int pageSize = 20,
    String? query,
    String country = 'us',
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    List<Map<String, dynamic>> filteredArticles = List.from(_mockArticles);

    // Apply search filter if query is provided
    if (query != null && query.isNotEmpty) {
      filteredArticles = _mockArticles.where((article) {
        final title = article['title']?.toString().toLowerCase() ?? '';
        final description = article['description']?.toString().toLowerCase() ?? '';
        final searchQuery = query.toLowerCase();
        return title.contains(searchQuery) || description.contains(searchQuery);
      }).toList();
    }

    // Simulate pagination
    final startIndex = (page - 1) * pageSize;
    
    final paginatedArticles = filteredArticles.skip(startIndex).take(pageSize).toList();

    return NewsResponse(
      status: 'ok',
      totalResults: filteredArticles.length,
      articles: paginatedArticles,
    );
  }

  Future<NewsResponse> searchEverything({
    required String query,
    int page = 1,
    int pageSize = 20,
    String sortBy = 'publishedAt',
  }) async {
    return getTopHeadlines(
      page: page,
      pageSize: pageSize,
      query: query,
    );
  }
}
