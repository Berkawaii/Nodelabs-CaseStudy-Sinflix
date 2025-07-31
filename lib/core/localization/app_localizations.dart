import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  static const List<Locale> supportedLocales = <Locale>[Locale('en'), Locale('tr')];

  // Login Screen
  String get welcome;
  String get welcomeSubtitle;
  String get email;
  String get password;
  String get forgotPassword;
  String get login;
  String get dontHaveAccount;
  String get signUp;
  String get orContinueWith;

  // Validation Messages
  String get emailRequired;
  String get emailInvalid;
  String get passwordRequired;
  String get passwordTooShort;

  // Error Messages
  String get loginError;
  String get networkError;
  String get unknownError;
  String get errorOccurred;

  // General
  String get ok;
  String get cancel;
  String get retry;
  String get loading;

  // Register Screen
  String get createAccount;
  String get createAccountSubtitle;
  String get fullName;
  String get confirmPassword;
  String get alreadyHaveAccount;
  String get register;
  String get nameRequired;
  String get confirmPasswordRequired;
  String get passwordsDoNotMatch;
  String get registerError;
  String get termsAndConditions;

  // Movie Detail Screen
  String get plot;
  String get genre;
  String get director;
  String get cast;
  String get writer;
  String get additionalInformation;
  String get gallery;
  String get released;
  String get language;
  String get country;
  String get awards;
  String get metascore;
  String get votes;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(_lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations _lookupAppLocalizations(Locale locale) {
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue on GitHub with '
    'a reproducible sample app and the gen-l10n configuration that was used.',
  );
}
