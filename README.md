# News App

A modern Flutter news application that fetches articles from NewsAPI.org, supports pagination, search functionality, and allows users to save their favorite articles locally.

## Quick Start

The app includes **mock data** by default, so you can run it immediately without needing an API key:

```bash
flutter run
```

This will show sample news articles that demonstrate all the app's features including search, pagination, and favorites.

## Architecture

This app follows clean architecture principles with proper separation of concerns:

```
lib/
├── core/
│   └── dependencies.dart         # Dependency injection 
├── data/
│   ├── models/                   # Data models
│   │   ├── article.dart
│   │   └── news_response.dart
│   ├── repositories/             # Repository interfaces 
│   │   ├── news_repository.dart
│   │   └── news_repository_impl.dart
│   └── services/                 # External services
│       ├── news_api_service.dart
│       ├── mock_news_api_service.dart
│       └── database_service.dart
└── presentation/
    ├── blocs/                    # BLoC state management
    │   ├── news/
    │   │   ├── news_bloc.dart
    │   │   ├── news_event.dart
    │   │   └── news_state.dart
    │   └── favorites/
    │       ├── favorites_bloc.dart
    │       ├── favorites_event.dart
    │       └── favorites_state.dart
    ├── pages/                    # UI screens
    │   ├── home_page.dart
    │   ├── news_list_page.dart
    │   └── favorites_page.dart
    └── widgets/                  # Reusable UI components
        ├── article_card.dart
        ├── search_widget.dart
        └── common_widgets.dart
```

## Technologies Used

- **Flutter**: UI framework
- **BLoC**: State management pattern
- **Dio**: HTTP client for API calls
- **SQLite**: Local database for favorites
- **Cached Network Image**: Efficient image loading and caching
- **URL Launcher**: Opening articles in external browser

## Libraries

```yaml
dependencies:
  flutter_bloc: ^8.1.3          # State management
  equatable: ^2.0.5             # Value equality
  dio: ^5.3.2                   # HTTP client
  sqflite: ^2.3.0               # Local database
  path: ^1.8.3                  # File path utilities
  cached_network_image: ^3.3.0  # Image caching
  intl: ^0.18.1                 # Date formatting
  url_launcher: ^6.2.1          # URL launching
```

## Setup Instructions

### Prerequisites

- VS Code
- Flutter SDK (>=3.3.0)
- Android Studio
- Android emulator or physical device

### API Key Configuration

**Note**: The app comes with mock data enabled by default, so you can test it immediately without an API key.

To use real NewsAPI data:

1. Get a free API key from [NewsAPI.org](https://newsapi.org/)
2. Open `lib/data/services/news_api_service.dart`
3. Replace `YOUR_API_KEY_HERE` with your actual API key:

```dart
static const String _apiKey = 'your_actual_api_key_here';
```

4. Open `lib/core/dependencies.dart` and change:

```dart
static bool _useMockData = false; // Set to false to use real API
```

### Installation

1. Clone the repository:
```bash
git clone https://github.com/gregoriusongo/kanggo-fe-test.git
cd kanggo_fe_test
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Build Instructions

### Debug Build
```bash
flutter run
```

### Release Build (Android)
```bash
flutter build apk --release
```

### Release Build (iOS)
```bash
flutter build ios --release
```

## Project Structure Details

### Data Layer
- **Models**: Plain Dart classes representing data structures
- **Services**: External data sources (API, Database)
- **Repositories**: Abstraction layer between data sources and business logic

### Presentation Layer
- **BLoC**: Business logic and state management
- **Pages**: Full screen widgets / UI Screen
- **Widgets**: Reusable UI components

### Key Components

#### News BLoC
Handles news fetching, pagination, search, and favorite toggling:
- `LoadNews`: Fetch initial news or refresh
- `LoadMoreNews`: Pagination
- `SearchNews`: Search functionality
- `ToggleFavorite`: Add/remove favorites

#### Favorites BLoC
Manages favorite articles:
- `LoadFavorites`: Load saved favorites
- `RemoveFromFavorites`: Remove from favorites

#### Database Service
SQLite-based local storage for favorites with methods:
- `addToFavorites()`
- `removeFromFavorites()`
- `getFavorites()`
- `isFavorite()`

#### News API Service
HTTP client for NewsAPI.org:
- `getTopHeadlines()`: Fetch latest news
- `searchEverything()`: Search articles
- Error handling for network issues
