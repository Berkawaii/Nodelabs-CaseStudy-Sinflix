import 'app_localizations.dart';

class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get welcome => 'Merhaba';

  @override
  String get welcomeSubtitle =>
      'Tempus varius a vitae interdum id tortor elementum tristique eleifend at.';

  @override
  String get email => 'E-Posta';

  @override
  String get password => 'Şifre';

  @override
  String get forgotPassword => 'Şifremi unuttum';

  @override
  String get login => 'Giriş Yap';

  @override
  String get dontHaveAccount => 'Bir hesabın yok mu?';

  @override
  String get signUp => 'Kayıt Ol';

  @override
  String get orContinueWith => 'Veya şununla devam et';

  @override
  String get emailRequired => 'E-posta gereklidir';

  @override
  String get emailInvalid => 'Lütfen geçerli bir e-posta girin';

  @override
  String get passwordRequired => 'Şifre gereklidir';

  @override
  String get passwordTooShort => 'Şifre en az 6 karakter olmalıdır';

  @override
  String get loginError =>
      'Giriş başarısız. Lütfen bilgilerinizi kontrol edin.';

  @override
  String get networkError => 'Ağ hatası. Lütfen bağlantınızı kontrol edin.';

  @override
  String get unknownError => 'Beklenmeyen bir hata oluştu';

  @override
  String get ok => 'Tamam';

  @override
  String get cancel => 'İptal';

  @override
  String get retry => 'Tekrar Dene';

  @override
  String get loading => 'Yükleniyor...';
}
