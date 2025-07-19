import '../models/news_response.dart';

class MockNewsApiService {
  static const List<Map<String, dynamic>> _mockArticles = [
    {
      'title': 'Breaking: Flutter 4.0 Released with Amazing Features',
      'description': 'Flutter team announces the release of Flutter 4.0 with revolutionary performance improvements and new widgets.',
      'url': 'https://google.com',
      'urlToImage': 'https://picsum.dev/static/1/300/200',
      'publishedAt': '2025-01-15T10:30:00Z',
      'author': 'Flutter Team',
      'source': {'name': 'Flutter Official'},
    },
    {
      'title': 'AI Revolution: ChatGPT Reaches 1 Billion Users',
      'description': 'OpenAI announces that ChatGPT has reached a milestone of 1 billion active users worldwide.',
      'url': 'https://google.com',
      'urlToImage': 'https://picsum.dev/static/222/300/200',
      'publishedAt': '2025-01-15T09:15:00Z',
      'author': 'OpenAI Team',
      'source': {'name': 'OpenAI'},
    },
    {
      'title': 'Climate Change: New Renewable Energy Breakthrough',
      'description': 'Scientists develop new solar panel technology that is 50% more efficient than current solutions.',
      'url': 'https://google.com',
      'urlToImage': 'https://picsum.dev/static/333/300/200',
      'publishedAt': '2025-01-15T08:45:00Z',
      'author': 'Dr. Sarah Johnson',
      'source': {'name': 'Green Tech News'},
    },
    {
      'title': 'Space Exploration: Mars Mission Update',
      'description': 'NASA provides latest updates on the Mars exploration mission with new discoveries about water on Mars.',
      'url': 'https://google.com',
      'urlToImage': 'https://picsum.dev/static/113/300/200',
      'publishedAt': '2025-01-15T07:20:00Z',
      'author': 'NASA',
      'source': {'name': 'NASA'},
    },
    {
      'title': 'Tech Giants Unite for Quantum Computing Initiative',
      'description': 'Microsoft, Google, and IBM announce joint venture to accelerate quantum computing development.',
      'url': 'https://google.com',
      'urlToImage': 'https://picsum.dev/static/12/300/200',
      'publishedAt': '2025-01-15T06:30:00Z',
      'author': 'Tech Reporters',
      'source': {'name': 'Tech Today'},
    },
    {
      'title': 'Healthcare: AI Diagnoses Diseases Faster Than Doctors',
      'description': 'A new AI system can diagnose rare diseases in seconds, outperforming human experts.',
      'url': 'https://google.com',
      'urlToImage': 'https://picsum.dev/static/34/300/200',
      'publishedAt': '2025-01-15T05:50:00Z',
      'author': 'Jane Doe',
      'source': {'name': 'Medical News'},
    },
    {
      'title': 'Education: Virtual Reality Classrooms Go Mainstream',
      'description': 'Schools worldwide adopt VR technology for immersive learning experiences.',
      'url': 'https://google.com',
      'urlToImage': 'https://picsum.dev/static/34/300/200',
      'publishedAt': '2025-01-15T05:10:00Z',
      'author': 'John Smith',
      'source': {'name': 'EdTech Times'},
    },
    {
      'title': 'Finance: Cryptocurrency Market Hits New High',
      'description': 'Bitcoin and Ethereum reach record prices as institutional investors pour in.',
      'url': 'https://google.com',
      'urlToImage': 'https://picsum.dev/static/24/300/200',
      'publishedAt': '2025-01-15T04:30:00Z',
      'author': 'Crypto Analyst',
      'source': {'name': 'Crypto Daily'},
    },
    {
      'title': 'Environment: Ocean Cleanup Project Succeeds',
      'description': 'Massive ocean cleanup initiative removes 1 million tons of plastic from the Pacific.',
      'url': 'https://google.com',
      'urlToImage': 'https://picsum.dev/static/114/300/200',
      'publishedAt': '2025-01-15T03:45:00Z',
      'author': 'Marine Biologist',
      'source': {'name': 'Eco News'},
    },
    {
      'title': 'Sports: Historic Win at the World Cup',
      'description': 'Underdog team claims victory in a dramatic World Cup final.',
      'url': 'https://google.com',
      'urlToImage': 'https://picsum.dev/static/213/300/200',
      'publishedAt': '2025-01-15T03:00:00Z',
      'author': 'Sports Desk',
      'source': {'name': 'Sports World'},
    },
    {
      'title': 'Travel: Space Tourism Tickets Now Available',
      'description': 'Commercial space flights open for public bookings, starting at \$250,000.',
      'url': 'https://google.com',
      'urlToImage': 'https://picsum.dev/static/134/300/200',
      'publishedAt': '2025-01-15T02:20:00Z',
      'author': 'Travel Editor',
      'source': {'name': 'Travel Weekly'},
    },
    {
      'title': 'Business: Remote Work Becomes Permanent',
      'description': 'Major companies announce permanent remote work policies for employees.',
      'url': 'https://google.com',
      'urlToImage': 'https://picsum.dev/static/121/300/200',
      'publishedAt': '2025-01-15T01:40:00Z',
      'author': 'Business Reporter',
      'source': {'name': 'Business Insider'},
    },
    {
      'title': 'Science: New Species Discovered in Amazon',
      'description': 'Researchers find dozens of new animal and plant species in the Amazon rainforest.',
      'url': 'https://google.com',
      'urlToImage': 'https://picsum.dev/static/134/300/200',
      'publishedAt': '2025-01-15T01:00:00Z',
      'author': 'Science Correspondent',
      'source': {'name': 'Nature Journal'},
    },
    {
      'title': 'Automotive: Electric Cars Outsell Gas Vehicles',
      'description': 'For the first time, electric vehicle sales surpass gasoline cars globally.',
      'url': 'https://google.com',
      'urlToImage': 'https://picsum.dev/static/1374/300/200',
      'publishedAt': '2025-01-14T23:50:00Z',
      'author': 'Auto Analyst',
      'source': {'name': 'Auto News'},
    },
    {
      'title': 'Fashion: Sustainable Materials Dominate Runways',
      'description': 'Top designers showcase eco-friendly collections at Fashion Week.',
      'url': 'https://google.com',
      'urlToImage': 'https://picsum.dev/static/12134/300/200',
      'publishedAt': '2025-01-14T22:30:00Z',
      'author': 'Fashion Editor',
      'source': {'name': 'Vogue'},
    },
    {
      'title': 'Food: Lab-Grown Meat Hits Supermarkets',
      'description': 'First lab-grown meat products now available for consumers in major cities.',
      'url': 'https://google.com',
      'urlToImage': 'https://picsum.dev/static/1213/300/200',
      'publishedAt': '2025-01-14T21:15:00Z',
      'author': 'Food Critic',
      'source': {'name': 'Gourmet News'},
    },
    {
      'title': 'Entertainment: Record-Breaking Box Office Weekend',
      'description': 'Latest blockbuster film shatters opening weekend records worldwide.',
      'url': 'https://google.com',
      'urlToImage': 'https://picsum.dev/static/2134/300/200',
      'publishedAt': '2025-01-14T20:00:00Z',
      'author': 'Entertainment Reporter',
      'source': {'name': 'Hollywood Times'},
    },
    {
      'title': 'Politics: Historic Peace Agreement Signed',
      'description': 'Leaders sign a landmark peace agreement ending decades of conflict.',
      'url': 'https://google.com',
      'urlToImage': 'https://picsum.dev/static/1234/300/200',
      'publishedAt': '2025-01-14T19:30:00Z',
      'author': 'Political Analyst',
      'source': {'name': 'World Politics'},
    },
    {
      'title': 'Technology: 6G Networks Begin Rollout',
      'description': 'Telecom companies start deploying 6G networks in major cities.',
      'url': 'https://google.com',
      'urlToImage': 'https://picsum.dev/static/1134/300/200',
      'publishedAt': '2025-01-14T18:45:00Z',
      'author': 'Tech Writer',
      'source': {'name': 'Tech Radar'},
    },
    {
      'title': 'Gaming: Esports Prize Pools Reach New Heights',
      'description': 'Top esports tournaments offer record-breaking prize money in 2025.',
      'url': 'https://google.com',
      'urlToImage': 'https://picsum.dev/static/1214/300/200',
      'publishedAt': '2025-01-14T18:00:00Z',
      'author': 'Game Reviewer',
      'source': {'name': 'GameSpot'},
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
