# Sinflix - Movie Streaming App

A modern Flutter application for movie streaming built with clean architecture, BLoC state management, and featuring an immersive movie discovery experience.

## 🎬 Overview

Sinflix is a comprehensive movie streaming application that provides users with an engaging platform to discover, browse, and manage their favorite movies. The app features a sophisticated swipe-based discovery system, detailed movie information, and personalized user profiles.

## ✨ Key Features

### 🔐 Authentication System

- **User Registration & Login**: Secure authentication with email and password
- **Social Login Options**: Integration ready for Google, Apple, and Facebook
- **Secure Token Management**: JWT tokens stored securely with flutter_secure_storage
- **Auto-login**: Persistent session management with automatic token refresh

### 🎭 Movie Discovery

- **Swipe-to-Discover**: Tinder-like card interface for movie discovery
- **Infinite Scroll**: Load more movies seamlessly as you browse
- **Detailed Movie Info**: Comprehensive movie details including cast, director, plot, ratings
- **High-Quality Images**: Multiple movie images with gallery view
- **IMDb Integration**: Real ratings and movie data from IMDb

### ❤️ Favorites Management

- **One-tap Favorites**: Quick favorite/unfavorite functionality
- **Favorites Collection**: Dedicated section for saved movies
- **Optimistic Updates**: Instant UI feedback with background sync

### 🎨 User Experience

- **Adaptive Theming**: Automatic dark/light mode based on system settings
- **Smooth Animations**: Lottie animations for enhanced user experience
- **Image Galleries**: Full-screen image viewing with pinch-to-zoom
- **Responsive Design**: Optimized for different screen sizes

### 🌍 Internationalization

- **Multi-language Support**: English and Turkish localization
- **RTL Support**: Right-to-left language support ready
- **Dynamic Language Switching**: Change language without restart

### 📱 Modern Architecture

- **Clean Architecture**: Separation of concerns with data, domain, and presentation layers
- **BLoC Pattern**: Reactive state management with flutter_bloc
- **Dependency Injection**: Modular architecture with get_it and injectable
- **Type Safety**: Freezed for immutable data classes and union types

## 🏗️ Architecture Overview

```
lib/
├── core/                    # Core functionality
│   ├── constants/          # App constants and assets
│   ├── di/                 # Dependency injection setup
│   ├── error/              # Error handling and failures
│   ├── localization/       # Internationalization setup
│   ├── logger/             # Comprehensive logging system
│   ├── network/            # HTTP client configuration
│   ├── router/             # Navigation and routing
│   ├── storage/            # Secure storage management
│   ├── theme/              # Theme and styling
│   ├── usecases/           # Base usecase definitions
│   └── utils/              # Utility functions
├── features/               # Feature modules
│   ├── auth/              # Authentication feature
│   │   ├── data/          # API services, models, repositories
│   │   ├── domain/        # Entities, repositories, usecases
│   │   └── presentation/  # UI components, BLoCs, pages
│   ├── discover/          # Movie discovery feature
│   ├── home/              # Home screen with movie grid
│   ├── main/              # Main layout and navigation
│   ├── movie/             # Movie details and management
│   └── profile/           # User profile and favorites
├── shared/                # Shared widgets and components
└── main.dart              # Application entry point
```

## 🛠️ Tech Stack & Dependencies

### Core Framework

- **Flutter 3.8.1+**: Cross-platform UI framework
- **Dart**: Modern programming language

### State Management & Architecture

- **flutter_bloc 8.1.6**: Reactive state management
- **get_it 8.0.0** & **injectable 2.5.0**: Dependency injection
- **dartz 0.10.1**: Functional programming utilities
- **equatable 2.0.5**: Value equality without boilerplate

### Networking & Data

- **dio 5.7.0**: Powerful HTTP client
- **retrofit 4.4.1**: Type-safe REST client
- **json_annotation 4.9.0**: JSON serialization
- **flutter_secure_storage 9.2.2**: Secure token storage

### UI & User Experience

- **cached_network_image 3.4.1**: Optimized image loading and caching
- **shimmer 3.0.0**: Loading placeholders
- **lottie 3.1.3**: Beautiful animations
- **google_fonts 6.2.1**: Custom typography
- **go_router 14.6.2**: Declarative routing

### Code Generation

- **freezed 2.5.7**: Immutable classes and unions
- **build_runner 2.4.13**: Code generation runner
- **injectable_generator 2.6.2**: DI code generation
- **retrofit_generator 9.1.2**: API client generation
- **json_serializable 6.8.0**: JSON serialization

### Development Tools

- **flutter_lints 5.0.0**: Comprehensive linting
- **logger 2.4.0**: Advanced logging system

## � Getting Started

### Prerequisites

```bash
Flutter SDK: >=3.8.1
Dart SDK: Latest stable
Android Studio or VS Code
iOS development tools (for iOS builds)
```

### Installation

1. **Clone the repository**

```bash
git clone https://github.com/Berkawaii/Nodelabs-CaseStudy-Sinflix.git
cd Nodelabs-CaseStudy-Sinflix
```

2. **Install dependencies**

```bash
flutter pub get
```

3. **Generate code**

```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

4. **Run the application**

```bash
flutter run
```

### Using VS Code Tasks

The project includes predefined VS Code tasks for common operations:

```bash
# Get dependencies
Ctrl+Shift+P -> Tasks: Run Task -> Flutter: Get Packages

# Build runner (one-time)
Ctrl+Shift+P -> Tasks: Run Task -> Flutter: Build Runner

# Build runner (watch mode)
Ctrl+Shift+P -> Tasks: Run Task -> Flutter: Build Runner Watch

# Run tests
Ctrl+Shift+P -> Tasks: Run Task -> Flutter: Test

# Analyze code
Ctrl+Shift+P -> Tasks: Run Task -> Flutter: Analyze
```

## 🔧 Configuration

### API Configuration

The application connects to the NodeLabs case study API:

- **Base URL**: `https://caseapi.servicelabs.tech/`
- **Authentication**: JWT token-based
- **Content-Type**: `application/json`

### API Endpoints

#### Authentication

```http
POST /user/login
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "password123"
}
```

```http
POST /user/register
Content-Type: application/json

{
  "name": "User Name",
  "email": "user@example.com",
  "password": "password123"
}
```

#### Movies

```http
GET /movies?page=1
Authorization: <jwt_token>
```

#### Toggle Favorite

```http
POST /movies/{movieId}/favorite
Authorization: <jwt_token>
```

## 🎨 Design System

### Color Palette

- **Primary**: Modern blue accent
- **Background**: Adaptive light/dark backgrounds
- **Cards**: Elevated surfaces with shadows
- **Text**: High contrast, accessible typography

### Typography

- **Font Family**: Google Fonts (Inter)
- **Scale**: Responsive typography scale
- **Weights**: Light, Regular, Medium, Bold

### Components

- **Custom Text Fields**: Consistent input styling
- **Movie Cards**: Engaging card design with gradients
- **Buttons**: Multiple button variants
- **Navigation**: Bottom tab navigation

## 🌍 Internationalization

### Supported Languages

- **English (en)**: Default language
- **Turkish (tr)**: Complete translation

### Adding New Languages

1. Create language file in `lib/core/localization/`
2. Add translations for all required keys
3. Update `AppLocalizations.supportedLocales`
4. Run code generation

## 📊 State Management

The app uses BLoC pattern for state management:

### Authentication BLoC

```dart
// Events
LoginRequested(email, password)
RegisterRequested(name, email, password)
LogoutRequested()
AuthStatusChecked()

// States
AuthInitial()
AuthLoading()
AuthAuthenticated(user)
AuthUnauthenticated()
AuthError(message)
```

### Movie BLoC

```dart
// Events
LoadMovies(page)
LoadMoreMovies()
RefreshMovies()
ToggleFavorite(movieId)

// States
MovieInitial()
MovieLoading()
MovieLoaded(movies, hasReachedMax, currentPage)
MovieError(message)
```

## 🧪 Testing

### Running Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/widget_test.dart
```

### Test Coverage

The project includes comprehensive tests for:

- Widget tests for UI components
- Unit tests for business logic
- Integration tests for features

## 📦 Building for Production

### Android

```bash
# Debug APK
flutter build apk --debug

# Release APK
flutter build apk --release

# App Bundle (recommended for Google Play)
flutter build appbundle --release
```

### iOS

```bash
# Debug build
flutter build ios --debug

# Release build
flutter build ios --release

# Create IPA
flutter build ipa --release
```

## 🔍 Code Quality

### Linting

The project uses comprehensive linting rules:

- **flutter_lints**: Official Flutter linting
- **Custom rules**: Additional quality checks

### Code Generation

- **Freezed**: Immutable data classes
- **Injectable**: Dependency injection
- **Retrofit**: Type-safe API clients
- **JSON Serializable**: JSON handling

### Logging

Comprehensive logging system with different levels:

- **Debug**: Development information
- **Info**: General application flow
- **Warning**: Potential issues
- **Error**: Actual errors with stack traces

## 📱 Features Deep Dive

### Movie Discovery

The discovery feature implements a card-based interface similar to dating apps:

- Swipe right to like a movie
- Swipe left to pass
- Automatic loading of new movies
- Smooth animations and transitions

### User Profile

- Display user information
- Favorite movies grid
- Settings and preferences
- Logout functionality

### Movie Details

- Full-screen movie poster
- Comprehensive movie information
- Image gallery with zoom functionality
- Favorite toggle with optimistic updates

## 🤝 Contributing

1. **Fork the repository**
2. **Create a feature branch**: `git checkout -b feature/amazing-feature`
3. **Commit changes**: `git commit -m 'Add amazing feature'`
4. **Push to branch**: `git push origin feature/amazing-feature`
5. **Open a Pull Request**

### Development Guidelines

- Follow the existing code style
- Write tests for new features
- Update documentation as needed
- Ensure all lints pass before submitting

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Berkay Acar**

- 📧 Email: acar.berkai@gmail.com
- 🐙 GitHub: [@Berkawaii](https://github.com/Berkawaii)
- 💼 LinkedIn: [Berkay Acar](https://linkedin.com/in/berkayacar)

## 🙏 Acknowledgments

- **NodeLabs**: For providing this excellent case study opportunity
- **Flutter Team**: For the amazing cross-platform framework
- **Open Source Community**: For the incredible packages and tools
- **Design Inspiration**: Modern movie streaming applications

## 📚 Additional Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [BLoC Library Documentation](https://bloclibrary.dev/)
- [Clean Architecture Guide](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter Best Practices](https://docs.flutter.dev/development/data-and-backend/state-mgmt/intro)

---

**Made with ❤️ and Flutter**
