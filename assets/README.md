# Asset klasörü kullanım kılavuzu

Bu klasör, Sinflix uygulamasının görsel asset'lerini içerir.

## Klasör Yapısı:

### assets/images/

- logo.png - Ana uygulama logosu
- logo_white.png - Beyaz versiyon logo
- logo_transparent.png - Şeffaf arka planlı logo
- splash_background.png - Splash ekran arka planı
- login_background.png - Login ekran arka planı
- movie_placeholder.png - Film poster placeholder'ı
- profile_placeholder.png - Profil resmi placeholder'ı

### assets/icons/

- app_icon.png - Uygulama ikonu
- google_icon.png - Google sosyal giriş ikonu
- apple_icon.png - Apple sosyal giriş ikonu
- facebook_icon.png - Facebook sosyal giriş ikonu

## Kullanım:

Asset'leri kullanmak için `AppAssets` class'ını kullanın:

```dart
import 'package:sinflix/core/constants/app_assets.dart';

// Logo kullanımı
Image.asset(AppAssets.logo)

// Icon kullanımı
Image.asset(AppAssets.appIcon)
```

## Not:

Şu anda placeholder icon'lar kullanılıyor. Gerçek asset'ler eklendikçe güncellenecek.
