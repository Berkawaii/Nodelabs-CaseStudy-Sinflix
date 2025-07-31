# Sinflix - Movie Streaming App

A modern Flutter application for movie streaming with clean architecture, MVVM pattern, and BLoC state management.

## 🚀 Features

- **Clean Architecture**: Separation of concerns with data, domain, and presentation layers
- **MVVM Pattern**: Model-View-ViewModel architectural pattern
- **BLoC State Management**: Reactive state management with flutter_bloc
- **Dark/Light Theme**: Automatic theme switching based on system settings
- **Internationalization**: Multi-language support (English & Turkish)
- **Secure Storage**: Token management with flutter_secure_storage
- **Advanced Logging**: Comprehensive logging system for debugging and monitoring
- **Network Management**: Dio-based HTTP client with interceptors
- **Dependency Injection**: Get_it with Injectable for clean dependency management

## 🏗️ Architecture

```
lib/
├── core/                    # Core functionality
│   ├── di/                 # Dependency injection
│   ├── error/              # Error handling
│   ├── localization/       # Internationalization
│   ├── logger/             # Logging system
│   ├── network/            # Network layer
│   ├── storage/            # Secure storage
│   ├── theme/              # App themes
│   └── utils/              # Utilities
├── features/               # Feature modules
│   ├── auth/              # Authentication
│   │   ├── data/          # Data layer
│   │   ├── domain/        # Domain layer
│   │   └── presentation/  # Presentation layer
│   └── movies/            # Movies feature
└── main.dart              # App entry point
```

## 📱 Screenshots

### Login Screen
- Modern UI design with dark/light theme support
- Form validation
- Social login options (Google, Apple, Facebook)
- Loading states with animations

## 🛠️ Tech Stack

- **Flutter**: Cross-platform UI framework
- **Dart**: Programming language
- **flutter_bloc**: State management
- **get_it & injectable**: Dependency injection
- **dio**: HTTP client
- **retrofit**: Type-safe HTTP client
- **flutter_secure_storage**: Secure token storage
- **dartz**: Functional programming
- **freezed**: Code generation for immutable classes
- **go_router**: Declarative routing
- **google_fonts**: Custom typography
- **logger**: Advanced logging

## 🚦 Getting Started

### Prerequisites

- Flutter SDK (>=3.8.1)
- Dart SDK
- Android Studio / VS Code
- iOS development tools (for iOS builds)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/Berkawaii/Nodelabs-CaseStudy-Sinflix.git
cd Nodelabs-CaseStudy-Sinflix
```

2. Install dependencies:
```bash
flutter pub get
```

3. Generate code:
```bash
flutter packages pub run build_runner build
```

4. Run the app:
```bash
flutter run
```

## 🔧 Configuration

### API Configuration

The app uses the following base URL for API calls:
- Base URL: `https://caseapi.servicelabs.tech/`

### Authentication

Login endpoint: `POST /user/login`

Request body:
```json
{
  "email": "user@example.com",
  "password": "password"
}
```

Response:
```json
{
  "response": {
    "code": 200,
    "message": ""
  },
  "data": {
    "_id": "user_id",
    "id": "user_id",
    "name": "User Name",
    "email": "user@example.com",
    "photoUrl": "https://example.com/photo.jpg",
    "token": "jwt_token"
  }
}
```

## 🎨 Theming

The app supports both dark and light themes with:
- Custom color schemes
- Google Fonts (Inter family)
- Consistent design system
- Automatic theme switching

## 🌍 Localization

Supported languages:
- English (en)
- Turkish (tr)

## 📝 Logging

The app includes a comprehensive logging system:
- Network request/response logging
- Authentication event logging
- Navigation logging
- Feature event logging
- Error tracking

## 🧪 Testing

Run tests:
```bash
flutter test
```

## 📦 Build

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ipa --release
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Berkay Acar**
- GitHub: [@Berkawaii](https://github.com/Berkawaii)
- Email: acar.berkai@gmail.com

## 🙏 Acknowledgments

- [NodeLabs](https://servicelabs.tech/) for providing the case study opportunity
- Flutter team for the amazing framework
- Open source community for the excellent packages

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
