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

### 🔥 Firebase Integration

- **Firebase Analytics**: Comprehensive user behavior tracking and analytics
- **Firebase Crashlytics**: Real-time crash reporting and error monitoring
- **Screen Tracking**: Automatic page view tracking for user journey analysis
- **Custom Events**: Movie-specific events for detailed insights
- **Error Logging**: Detailed error reporting with user context

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
│   ├── firebase/           # Firebase services (Analytics & Crashlytics)
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

### Firebase & Analytics

- **firebase_core 3.8.1**: Firebase SDK core functionality
- **firebase_analytics 11.3.8**: User behavior tracking and analytics
- **firebase_crashlytics 4.1.8**: Real-time crash reporting and monitoring

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

4. **Firebase Setup**

The app is already configured with Firebase. Make sure you have:

- Firebase project with Analytics and Crashlytics enabled
- iOS deployment target set to 13.0+
- Valid Firebase configuration files

5. **Run the application**

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

### Firebase Configuration

The application includes comprehensive Firebase integration:

- **Analytics**: User behavior tracking, screen views, custom events
- **Crashlytics**: Automatic crash reporting, error logging, user context
- **Event Tracking**: Movie interactions, authentication events, user actions
- **Error Monitoring**: Network errors, authentication failures, unexpected crashes

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

### Firebase Analytics Events

The app tracks various user interactions:

#### Authentication Events

- `login` - User login success
- `sign_up` - User registration success
- `login_failed` - Authentication failures
- `register_failed` - Registration failures
- `logout` - User logout

#### Movie Events

- `movies_loaded` - Movie list loaded
- `more_movies_loaded` - Pagination events
- `movies_refreshed` - Pull-to-refresh actions
- `movie_view` - Movie detail views
- `movie_add_to_favorites` - Favorite additions
- `movie_remove_from_favorites` - Favorite removals

#### Screen Tracking

- Automatic screen view tracking for all pages
- User journey analysis
- Time spent on screens

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

// Firebase Integration
- Analytics tracking for all auth events
- Crashlytics error logging for failures
- User identification for analytics
- Detailed error context for debugging
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

// Firebase Integration
- Movie interaction analytics
- Pagination and refresh tracking
- Favorite action analytics
- Error monitoring and reporting
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

## 🚀 Firebase App Distribution

The project includes comprehensive deployment scripts for Firebase App Distribution, enabling easy distribution of beta builds to testers.

### 📋 Prerequisites

1. **Firebase CLI Setup**

   ```bash
   # Install Firebase CLI
   npm install -g firebase-tools

   # Login to Firebase
   firebase login

   # Verify your project
   firebase projects:list
   ```

2. **Project Configuration**
   - Ensure Firebase App Distribution is enabled in your Firebase project
   - Configure test groups in Firebase Console
   - Add testers to your groups

### 🛠️ Available Scripts

#### 1. Full-Featured Deployment Script (`deploy.sh`)

The main deployment script with comprehensive options:

```bash
# Make script executable (first time only)
chmod +x deploy.sh

# Interactive deployment
./deploy.sh

# Quick iOS debug deployment
./deploy.sh --platform ios --build-type debug --test-group "beta-testers"

# Android release with custom notes
./deploy.sh --platform android --build-type release --test-group "internal-team" --release-notes "New authentication system"
```

**Features:**

- Interactive platform selection (iOS/Android)
- Build type selection (debug/release)
- Test group management
- Custom release notes
- Automatic build and deployment
- Comprehensive error handling
- Build cleanup options

#### 2. Quick Deployment Script (`quick-deploy.sh`)

Simplified script for rapid deployments:

```bash
# Make script executable
chmod +x quick-deploy.sh

# Interactive quick deployment
./quick-deploy.sh
```

**Features:**

- Streamlined interface
- Essential options only
- Faster deployment process
- Perfect for regular testing

#### 3. Windows PowerShell Script (`deploy.ps1`)

For Windows development environments:

```powershell
# Set execution policy (if needed)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Run deployment
.\deploy.ps1 -Platform "ios" -BuildType "debug" -TestGroup "beta-testers"

# Interactive mode
.\deploy.ps1
```

### 📱 Platform-Specific Setup

#### iOS Configuration

1. **Certificates and Provisioning Profiles**

   ```bash
   # Ensure you have valid certificates
   security find-identity -v -p codesigning

   # Check provisioning profiles
   ls ~/Library/MobileDevice/Provisioning\ Profiles/
   ```

2. **Xcode Configuration**
   - Set appropriate bundle identifier
   - Configure signing certificates
   - Ensure iOS deployment target is 13.0+

#### Android Configuration

1. **Keystore Setup**

   ```bash
   # Generate keystore (if not exists)
   keytool -genkey -v -keystore android/app/sinflix-release-key.keystore -alias sinflix -keyalg RSA -keysize 2048 -validity 10000
   ```

2. **Build Configuration**
   - Configure `android/key.properties`
   - Update `android/app/build.gradle` with signing config

### 🎯 Test Groups Management

#### Creating Test Groups

1. **Via Firebase Console:**

   - Go to App Distribution in Firebase Console
   - Navigate to "Testers & Groups"
   - Create groups: `beta-testers`, `internal-team`, `qa-team`

2. **Via Scripts:**
   ```bash
   # Scripts automatically use your configured groups
   # Just specify the group name when prompted
   ```

#### Common Test Groups

- **`beta-testers`**: External beta users
- **`internal-team`**: Internal development team
- **`qa-team`**: Quality assurance team
- **`stakeholders`**: Project stakeholders and managers

### 📝 Release Notes Templates

The scripts support various release note formats:

#### Automatic Release Notes

```bash
# Git-based automatic notes
git log --oneline --since="1 week ago" > release-notes.txt
```

#### Manual Release Notes

```bash
# Interactive input during deployment
# Or specify via command line
./deploy.sh --release-notes "Fixed authentication issues and improved performance"
```

#### Template Examples

```markdown
# Version 1.2.0 - Authentication Update

- ✅ Fixed login persistence issues
- 🔧 Improved error handling
- 🎨 Updated UI animations
- 🚀 Performance optimizations

# Bug Fixes

- Fixed crash on movie detail screen
- Resolved network timeout issues
- Fixed favorite toggle animation

# Known Issues

- Profile image upload pending
- Minor UI adjustments needed
```

### 🔧 Configuration Files

#### Firebase Configuration (`firebase.json`)

```json
{
  "appDistribution": {
    "groups": {
      "beta-testers": ["tester1@example.com", "tester2@example.com"],
      "internal-team": ["dev1@company.com", "dev2@company.com"]
    },
    "releaseNotesFile": "release-notes.txt"
  }
}
```

#### Script Configuration

Scripts automatically detect and use:

- Project configuration from `pubspec.yaml`
- Firebase project ID from `.firebaserc`
- iOS bundle identifier from `ios/Runner.xcodeproj`
- Android package name from `android/app/build.gradle`

### 🚨 Troubleshooting

#### Common Issues

1. **Firebase CLI Not Authenticated**

   ```bash
   firebase logout
   firebase login
   ```

2. **iOS Code Signing Issues**

   ```bash
   # Clean and rebuild
   flutter clean
   cd ios && rm -rf Pods Podfile.lock
   pod install
   cd .. && flutter build ios
   ```

3. **Android Keystore Issues**

   ```bash
   # Verify keystore
   keytool -list -v -keystore android/app/sinflix-release-key.keystore
   ```

4. **Firebase Project Access**
   ```bash
   # Verify project access
   firebase projects:list
   firebase use --add
   ```

#### Error Resolution

- **Build Failures**: Check flutter doctor and resolve dependencies
- **Upload Failures**: Verify Firebase project permissions
- **Certificate Issues**: Update Xcode certificates and provisioning profiles
- **Network Issues**: Check internet connection and Firebase status

### 🎯 CI/CD Integration

#### GitHub Actions Example

```yaml
name: Deploy to Firebase App Distribution

on:
  push:
    branches: [develop]

jobs:
  deploy:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - name: Deploy to Firebase
        run: |
          chmod +x deploy.sh
          ./deploy.sh --platform ios --build-type debug --test-group "beta-testers" --release-notes "Automated deployment from ${{ github.sha }}"
        env:
          FIREBASE_TOKEN: ${{ secrets.FIREBASE_TOKEN }}
```

#### Fastlane Integration

```ruby
# fastlane/Fastfile
lane :deploy_to_firebase do
  build_app(scheme: "Runner")
  firebase_app_distribution(
    app: "1:123456789:ios:abcd1234efgh5678",
    groups: "beta-testers",
    release_notes: "Latest build from Fastlane"
  )
end
```

### 📊 Usage Analytics

The deployment scripts provide:

- Build time tracking
- Upload progress monitoring
- Success/failure statistics
- Deployment history logging

### 🔐 Security Best Practices

1. **Environment Variables**

   ```bash
   # Store sensitive data in environment
   export FIREBASE_TOKEN="your-ci-token"
   export ANDROID_KEYSTORE_PASSWORD="your-keystore-password"
   ```

2. **Git Ignore Configuration**

   ```gitignore
   # Sensitive files
   android/key.properties
   android/app/google-services.json
   ios/Runner/GoogleService-Info.plist
   *.keystore
   release-notes.txt
   ```

3. **Keystore Management**
   - Store keystores securely
   - Use different keystores for debug/release
   - Regular backup of certificates

### 📖 Additional Resources

- [Firebase App Distribution Documentation](https://firebase.google.com/docs/app-distribution)
- [Flutter iOS Deployment Guide](https://docs.flutter.dev/deployment/ios)
- [Flutter Android Deployment Guide](https://docs.flutter.dev/deployment/android)
- [Firebase CLI Reference](https://firebase.google.com/docs/cli)

For detailed script documentation and examples, see `scripts/README.md`.

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

### Firebase Monitoring

Advanced monitoring and analytics:

- **Real-time Analytics**: Live user behavior data
- **Crash Reports**: Automatic crash detection and reporting
- **Performance Monitoring**: App performance metrics
- **User Segmentation**: Detailed user analytics
- **Custom Events**: Business-specific event tracking
- **Error Context**: Rich error information with user actions

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
- [Firebase Integration Guide](FIREBASE_INTEGRATION.md) - Detailed Firebase setup and usage

## 🔥 Firebase Features

For detailed information about Firebase Analytics and Crashlytics integration, see the [Firebase Integration Documentation](FIREBASE_INTEGRATION.md).

### Quick Firebase Overview

- **📊 Analytics**: Track user behavior, screen views, and custom events
- **🚨 Crashlytics**: Monitor crashes and errors in real-time
- **👤 User Tracking**: Identify users across sessions
- **📱 Screen Tracking**: Automatic page view analytics
- **🎬 Movie Events**: Custom events for movie interactions
- **⚡ Error Monitoring**: Comprehensive error logging and reporting

---

**Made with ❤️ and Flutter**
