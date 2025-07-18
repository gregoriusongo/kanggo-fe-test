import 'package:dio/dio.dart';
import '../models/news_response.dart';

class NewsApiService {
  static const String _baseUrl = 'https://newsapi.org/v2';
  static const String _apiKey = 'API_KEY_REMOVED'; // Replace with your actual API key
  
  final Dio _dio;

  NewsApiService() : _dio = Dio() {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);
  }

  Future<NewsResponse> getTopHeadlines({
    int page = 1,
    int pageSize = 20,
    String? query,
    String country = 'us',
  }) async {
    try {
      final response = await _dio.get(
        '/top-headlines',
        queryParameters: {
          'apiKey': _apiKey,
          'page': page,
          'pageSize': pageSize,
          'country': country,
          if (query != null && query.isNotEmpty) 'q': query,
        },
      );

      return NewsResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<NewsResponse> searchEverything({
    required String query,
    int page = 1,
    int pageSize = 20,
    String sortBy = 'publishedAt',
  }) async {
    try {
      final response = await _dio.get(
        '/everything',
        queryParameters: {
          'apiKey': _apiKey,
          'q': query,
          'page': page,
          'pageSize': pageSize,
          'sortBy': sortBy,
        },
      );

      return NewsResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return Exception('Connection timeout. Please check your internet connection.');
      case DioExceptionType.badResponse:
        if (e.response?.statusCode == 401) {
          return Exception('Invalid API key. Please check your configuration.');
        } else if (e.response?.statusCode == 429) {
          return Exception('Too many requests. Please try again later.');
        }
        return Exception('Server error: ${e.response?.statusCode}');
      case DioExceptionType.cancel:
        return Exception('Request was cancelled');
      case DioExceptionType.unknown:
      default:
        return Exception('Network error. Please check your internet connection.');
    }
  }
}
