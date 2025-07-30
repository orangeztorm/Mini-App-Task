# Mini App Task

A Flutter application that displays a list of items fetched from a mock API with search functionality and persistent favorites.

## 📱 Features

- **Item List Display**: Fetches and displays items from a mock API (JSONPlaceholder)
- **Search Functionality**: Real-time search by item title
- **Favorite Management**: Toggle and persist favorite items locally
- **Colored Tags**: Items display with colored tags (New, Old, Hot)
- **Timestamp Display**: Shows time since item was added
- **Favorite Counter Badge**: App bar badge showing number of favorite items
- **Pull-to-Refresh**: Refresh items by pulling down
- **Pagination**: Load more items with infinite scrolling

## 🏗️ Architecture

This project follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── core/                          # Core utilities and shared code
│   ├── constants/                 # App-wide constants
│   ├── error/                     # Error handling (Failures & Exceptions)
│   ├── network/                   # Network connectivity checking
│   └── usecases/                  # Base use case interface
├── features/
│   └── items/                     # Items feature
│       ├── data/                  # Data layer
│       │   ├── datasources/       # Remote & Local data sources
│       │   ├── models/            # Data models with JSON serialization
│       │   └── repositories/      # Repository implementations
│       ├── domain/                # Domain layer
│       │   ├── entities/          # Business entities
│       │   ├── repositories/      # Repository interfaces
│       │   └── usecases/          # Business use cases
│       └── presentation/          # Presentation layer
│           ├── bloc/              # State management (BLoC pattern)
│           │   ├── items/         # Items loading BLoC
│           │   ├── favorite/      # Favorites management BLoC
│           │   └── search/        # Search functionality BLoC
│           ├── pages/             # UI screens
│           └── widgets/           # Reusable UI components
└── injection_container/           # Dependency injection setup
```

## 🧱 State Management - BLoC Pattern

The app uses **BLoC (Business Logic Component)** pattern with proper separation of concerns:

### 1. ItemsBloc

Handles item loading with states:

- `ItemsStatus.initial`
- `ItemsStatus.loading`
- `ItemsStatus.loadingMore`
- `ItemsStatus.success`
- `ItemsStatus.failure`

### 2. FavoriteBloc

Manages favorite operations with states:

- `FavoriteStatus.initial`
- `FavoriteStatus.loading`
- `FavoriteStatus.success`
- `FavoriteStatus.failure`

### 3. SearchBloc

Handles search functionality with states:

- `SearchStatus.initial`
- `SearchStatus.loading`
- `SearchStatus.success`
- `SearchStatus.empty`
- `SearchStatus.failure`

**Why BLoC?**

- **Predictable State Management**: Clear state transitions and easy testing
- **Separation of Concerns**: Business logic separated from UI
- **Reactive Programming**: Stream-based architecture
- **Testability**: Easy to unit test business logic
- **Scalability**: Works well for complex applications

## 🛠️ Technologies & Libraries

- **Flutter** - UI framework
- **Dart** - Programming language
- **BLoC/Cubit** - State management
- **Get It** - Dependency injection
- **Injectable** - Code generation for DI
- **Dio** - HTTP client
- **Shared Preferences** - Local storage
- **Dartz** - Functional programming (Either for error handling)
- **Equatable** - Value comparison
- **JSON Annotation** - JSON serialization

## 📦 Installation & Setup

### Prerequisites

- Flutter SDK (>=3.8.0)
- Dart SDK
- Android Studio / VS Code with Flutter extension

### Steps

1. **Clone the repository**

   ```bash
   git clone https://github.com/orangeztorm/Mini-App-Task.git
   cd Mini-App-Task
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Generate code (for JSON serialization and DI)**

   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## 🧪 Testing

The project includes comprehensive tests:

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test file
flutter test test/features/items/domain/usecases/get_items_test.dart
```

## 📱 Usage

1. **View Items**: The app loads items automatically on startup
2. **Search**: Use the search bar to filter items by title
3. **Toggle Favorites**: Tap the heart icon on any item to add/remove from favorites
4. **View Favorite Count**: Check the badge on the heart icon in the app bar
5. **Refresh**: Pull down on the list to refresh items
6. **Load More**: Scroll to the bottom to load more items

## 🏆 Technical Decisions & Assumptions

### Architecture Decisions

- **Clean Architecture**: Ensures maintainability and testability
- **BLoC Pattern**: Provides predictable state management
- **Repository Pattern**: Abstracts data sources
- **Dependency Injection**: Makes the app modular and testable

### Assumptions Made

- **Mock API**: Using JSONPlaceholder API for demo purposes
- **Tag Assignment**: Tags are randomly assigned based on item ID
- **Timestamp Simulation**: Timestamps are generated based on item ID
- **Pagination Simulation**: Simulated since the mock API doesn't support true pagination
- **Offline Support**: Basic caching implementation for offline viewing

### Error Handling

- **Network Errors**: Graceful handling with retry options
- **Cache Failures**: Fallback to remote data
- **User Feedback**: Clear error messages and loading states

## 🚀 Future Enhancements

- [ ] **Real Pagination**: Implement with a real API that supports pagination
- [ ] **Offline Mode**: Enhanced offline capabilities
- [ ] **Push Notifications**: For new items
- [ ] **Dark Theme**: Theme switching
- [ ] **Item Details**: Detailed view for each item
- [ ] **Favorites Page**: Dedicated page for favorite items
- [ ] **Advanced Search**: Filter by tags, date, etc.
- [ ] **Performance**: Image loading optimization

## 🤝 Contributing

This project follows standard Flutter development practices:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Ensure all tests pass
6. Submit a pull request

## 📄 License

This project is created as a coding challenge and is for demonstration purposes.

---

> This is a challenge by **Coodesh**

## 👨‍💻 Developer

**Taiwo Kehinde**

- GitHub: [@orangeztorm](https://github.com/orangeztorm)

---

**Project Status**: ✅ Complete with all required features implemented
