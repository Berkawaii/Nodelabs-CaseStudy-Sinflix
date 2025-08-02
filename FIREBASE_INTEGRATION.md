# Firebase Crashlytics & Analytics Entegrasyonu

Bu dokümantasyon Sinflix uygulamasına eklenen Firebase Crashlytics ve Analytics entegrasyonunu açıklar.

## 📋 Eklenmiş Özellikler

### 🔥 Firebase Core

- Firebase projesi yapılandırması (`firebase_options.dart`)
- Uygulama başlangıcında Firebase başlatılması
- Otomatik hata yakalama sistemi

### 📊 Firebase Analytics

- Ekran görüntüleme takibi
- Kullanıcı olayları takibi (login, register, logout)
- Film ve arama olayları takibi
- Özel olay takibi

### 🚨 Firebase Crashlytics

- Otomatik crash raporlama
- Manuel hata loglama
- Kullanıcı bilgileri takibi
- Network hataları loglama
- Auth hataları loglama

## 📁 Dosya Yapısı

```
lib/core/firebase/
├── analytics_service.dart          # Firebase Analytics servis sınıfı
├── crashlytics_service.dart        # Firebase Crashlytics servis sınıfı
├── analytics_screen_mixin.dart     # Screen tracking için mixin
└── firebase_example_service.dart   # Kullanım örnekleri
```

## 🛠️ Servisler

### AnalyticsService

Firebase Analytics işlemlerini yöneten servis.

**Temel metodlar:**

- `logScreenView()` - Ekran görüntüleme takibi
- `logLogin()` - Giriş olayı takibi
- `logSignUp()` - Kayıt olayı takibi
- `logSearch()` - Arama olayı takibi
- `logCustomEvent()` - Özel olay takibi

**Film özel metodlar:**

- `logMovieView()` - Film görüntüleme takibi
- `logMovieSearch()` - Film arama takibi
- `logMovieAddToFavorites()` - Favorilere ekleme takibi

### CrashlyticsService

Firebase Crashlytics işlemlerini yöneten servis.

**Temel metodlar:**

- `recordError()` - Hata kaydetme
- `recordFlutterError()` - Flutter hata kaydetme
- `log()` - Custom log mesajı
- `setUserId()` - Kullanıcı ID belirleme
- `setCustomKey()` - Custom key-value çiftleri

**Uygulama özel metodlar:**

- `logNetworkError()` - Network hataları
- `logAuthError()` - Authentication hataları
- `logMovieError()` - Film işlem hataları

## 📱 Kullanım Örnekleri

### Screen Tracking (Mixin ile)

```dart
class _LoginPageState extends State<LoginPage> with AnalyticsScreenMixin {
  @override
  String get screenName => 'login_screen';

  @override
  String get screenClass => 'LoginPage';

  // Widget otomatik olarak screen view track eder
}
```

### Screen Tracking (Wrapper ile)

```dart
AnalyticsScreenWrapper(
  screenName: 'home_screen',
  screenClass: 'HomePage',
  child: HomePageContent(),
)
```

### Analytics Events

```dart
// Dependency injection ile service alın
final analyticsService = getIt<AnalyticsService>();

// Film görüntüleme takibi
await analyticsService.logMovieView(
  movieId: '123',
  movieTitle: 'Avatar',
);

// Arama takibi
await analyticsService.logMovieSearch(
  query: 'action movies',
  resultCount: 15,
);

// Custom event
await analyticsService.logCustomEvent(
  name: 'feature_used',
  parameters: {
    'feature_name': 'dark_mode',
    'user_type': 'premium',
  },
);
```

### Crashlytics Error Logging

```dart
// Dependency injection ile service alın
final crashlyticsService = getIt<CrashlyticsService>();

// Hata kaydetme
try {
  // Risky operation
} catch (error, stackTrace) {
  await crashlyticsService.recordError(
    exception: error,
    stackTrace: stackTrace,
    reason: 'User tried to access premium feature',
    fatal: false,
  );
}

// Kullanıcı bilgisi set etme
await crashlyticsService.setUserInformation(
  userId: 'user123',
  email: 'user@example.com',
  name: 'John Doe',
);

// Network hata loglama
await crashlyticsService.logNetworkError(
  endpoint: '/api/movies',
  statusCode: 500,
  errorMessage: 'Internal server error',
);
```

## 🔧 Entegre Edilmiş Yerler

### AuthBloc

- Login/Register/Logout olaylarında Analytics tracking
- Hata durumlarında Crashlytics logging
- Kullanıcı bilgilerini Firebase'e set etme

### Login Page

- Otomatik screen view tracking (AnalyticsScreenMixin ile)

### Main App

- Firebase Core başlatılması
- Otomatik crash detection
- Global error handling

## 📈 Analytics Events

### Otomatik Events

- `screen_view` - Her sayfa görüntülemede
- `login` - Başarılı giriş yapıldığında
- `sign_up` - Başarılı kayıt olunduğunda

### Custom Events

- `login_failed` - Giriş başarısız olduğunda
- `register_failed` - Kayıt başarısız olduğunda
- `logout` - Çıkış yapıldığında
- `movie_view` - Film görüntülendiğinde
- `movie_search` - Film arandığında
- `movie_add_to_favorites` - Favorilere eklendiğinde
- `movie_remove_from_favorites` - Favorilerden çıkarıldığında

## 🚨 Error Tracking

### Otomatik Tracking

- Flutter widget hataları
- Uncaught async errors
- Platform specific crashes

### Manuel Tracking

- Network errors
- Authentication errors
- Business logic errors
- Movie operation errors

## 🔑 User Properties

Analytics ve Crashlytics'te şu kullanıcı özellikleri takip edilir:

- User ID
- Email
- Name
- Last action
- Error context

## 🎯 Gelecek Geliştirmeler

1. **Advanced Analytics Events:**

   - Video watch duration
   - Feature usage statistics
   - Performance metrics

2. **Enhanced Error Tracking:**

   - Custom error categories
   - Error severity levels
   - Recovery actions

3. **User Behavior Analysis:**
   - User journey mapping
   - Conversion funnels
   - Retention analytics

## 📝 Notlar

- Tüm Firebase servisleri dependency injection ile yönetilmektedir
- Analytics events ve Crashlytics errors silent fail yapar (uygulamayı crash etmez)
- Debug modunda daha detaylı loglar görülebilir
- Production'da Firebase Console'dan canlı data takip edilebilir

## 🔧 Gereksinimler

- `firebase_core: ^3.8.1`
- `firebase_analytics: ^11.3.8`
- `firebase_crashlytics: ^4.1.8`
- `injectable: ^2.5.0` (DI için)

## 🏃‍♂️ Çalıştırma

1. Dependencies'leri çekin:

```bash
flutter pub get
```

2. Build runner'ı çalıştırın:

```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

3. Uygulamayı çalıştırın:

```bash
flutter run
```

Firebase Analytics ve Crashlytics entegrasyonu otomatik olarak çalışmaya başlayacaktır.
