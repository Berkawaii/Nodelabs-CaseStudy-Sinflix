# Firebase App Distribution Deployment Scripts

Bu klasörde Firebase App Distribution ile iOS ve Android uygulamalarınızı otomatik olarak deploy edebileceğiniz script'ler bulunmaktadır.

## 📋 Gereksinimler

### Genel Gereksinimler

- [Firebase CLI](https://firebase.google.com/docs/cli) kurulu olmalı
- Flutter SDK kurulu olmalı
- Firebase projesi ve App Distribution yapılandırılmış olmalı
- Firebase CLI ile giriş yapılmış olmalı (`firebase login`)

### Platform Özel Gereksinimler

- **iOS**: macOS gereklidir
- **Android**: Tüm platformlarda çalışır

## 🚀 Script'ler

### 1. `deploy.sh` - Tam Özellikli Deployment (macOS/Linux)

En kapsamlı deployment script'i. Birçok seçenek ve özelleştirme sunar.

```bash
# Temel kullanım
./scripts/deploy.sh -p android                           # Android debug
./scripts/deploy.sh -p ios -t release                   # iOS release
./scripts/deploy.sh -p both -t release                  # Her iki platform

# Gelişmiş kullanım
./scripts/deploy.sh -p android -t release -g "testers,qa-team" -n "Login bug fixed"
```

**Parametreler:**

- `-p, --platform`: Platform (android|ios|both) [Zorunlu]
- `-t, --type`: Build tipi (debug|release) [Varsayılan: debug]
- `-g, --groups`: Test grupları [Varsayılan: testers]
- `-n, --notes`: Release notları [Varsayılan: otomatik]
- `-v, --version`: Versiyon override [Varsayılan: pubspec.yaml'dan]

### 2. `quick-deploy.sh` - Hızlı Deployment (macOS/Linux)

Basit ve hızlı deployment için interaktif script.

```bash
./scripts/quick-deploy.sh
```

Menüden seçim yapın:

1. Android Debug (Hızlı Test)
2. Android Release (Production)
3. iOS Release (Production)

### 3. `deploy.ps1` - PowerShell Deployment (Windows)

Windows kullanıcıları için PowerShell script'i.

```powershell
# Temel kullanım
.\scripts\deploy.ps1 -Platform android                    # Android debug
.\scripts\deploy.ps1 -Platform android -BuildType release # Android release

# Gelişmiş kullanım
.\scripts\deploy.ps1 -Platform android -BuildType release -Groups "testers,qa-team" -ReleaseNotes "Bug fixes"
```

**Not:** iOS build'leri Windows'ta desteklenmez.

## 🔧 Kurulum

### 1. Firebase CLI Kurulumu

```bash
# npm ile
npm install -g firebase-tools

# Homebrew ile (macOS)
brew install firebase-cli
```

### 2. Firebase Login

```bash
firebase login
```

### 3. Proje Yapılandırması

Firebase Console'da App Distribution'ı etkinleştirin:

1. [Firebase Console](https://console.firebase.google.com/) → Proje seçin
2. App Distribution → Başlayın
3. Test grupları oluşturun
4. Uygulamalarınızı kaydedin

## 📱 Kullanım Örnekleri

### Hızlı Test Deployment'ı

```bash
# Android debug hızlı test
./scripts/quick-deploy.sh
# Menüden "1" seçin
```

### Production Deployment'ı

```bash
# Android production
./scripts/deploy.sh -p android -t release -g "internal-team,beta-testers"

# iOS production
./scripts/deploy.sh -p ios -t release -g "ios-testers"

# Her iki platform
./scripts/deploy.sh -p both -t release -g "all-testers"
```

### Özel Release Notları

```bash
./scripts/deploy.sh -p android -t release \
  -n "🐛 Fixed critical login bug
📱 Improved movie discovery
🎨 Updated UI design
✨ Performance optimizations"
```

## 📧 Test Grupları

Firebase Console'da aşağıdaki test gruplarını oluşturmanız önerilir:

- `testers` - Genel test kullanıcıları
- `internal-team` - İç ekip üyeleri
- `qa-team` - QA test ekibi
- `beta-testers` - Beta test kullanıcıları
- `ios-testers` - iOS özel test kullanıcıları
- `android-testers` - Android özel test kullanıcıları

## 🔍 Troubleshooting

### Firebase CLI Sorunları

```bash
# Firebase CLI versiyonunu kontrol edin
firebase --version

# Tekrar giriş yapın
firebase logout
firebase login

# Proje listesini kontrol edin
firebase projects:list
```

### Build Sorunları

```bash
# Flutter temizliği
flutter clean
flutter pub get

# Gradle temizliği (Android)
cd android && ./gradlew clean && cd ..

# Pod temizliği (iOS)
cd ios && pod deintegrate && pod install && cd ..
```

### iOS Deployment Sorunları

- Xcode'da signing ayarlarını kontrol edin
- Provisioning profile'ların güncel olduğundan emin olun
- Archive işlemini manuel olarak test edin

## 📊 Firebase Console

Deployment sonrası aşağıdaki linkten durumu kontrol edebilirsiniz:

[Firebase App Distribution Console](https://console.firebase.google.com/project/sinflixberkay/appdistribution)

## 🎯 Best Practices

1. **Test Grupları**: Farklı kullanıcı grupları için ayrı gruplar oluşturun
2. **Release Notes**: Her deployment için anlamlı notlar ekleyin
3. **Versioning**: Semantic versioning kullanın (1.0.0+1)
4. **Build Types**: Test için debug, production için release kullanın
5. **Automation**: CI/CD pipeline'larınızda bu script'leri kullanın

## 🚦 CI/CD Entegrasyonu

### GitHub Actions Örneği

```yaml
name: Deploy to Firebase App Distribution

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: subosito/flutter-action@v2
      - name: Deploy Android
        run: ./scripts/deploy.sh -p android -t release -g "beta-testers"
        env:
          FIREBASE_TOKEN: ${{ secrets.FIREBASE_TOKEN }}
```

### GitLab CI Örneği

```yaml
deploy_android:
  script:
    - ./scripts/deploy.sh -p android -t release -g "testers"
  only:
    - main
```

## 🔐 Güvenlik

- Firebase service account anahtarlarını güvenli tutun
- Script'lerde hassas bilgileri hardcode etmeyin
- Environment variable'ları kullanın
- .gitignore'da service account dosyalarını exclude edin

## 💡 İpuçları

1. **Parallel Builds**: Büyük projeler için parallel build seçeneklerini kullanın
2. **Caching**: Build cache'lerini etkinleştirin
3. **Notifications**: Slack/Teams entegrasyonu ekleyin
4. **Analytics**: Firebase Analytics ile deployment metriklerini takip edin
5. **Rollback**: Sorunlu build'ler için hızlı geri alma planınız olsun

---

**Geliştirici:** Berkay Acar  
**Proje:** Sinflix Movie App  
**Firebase Project:** sinflixberkay
