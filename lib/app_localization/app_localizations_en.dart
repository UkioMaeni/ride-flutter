import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get greeting => 'Hello';

  @override
  String get farewell => 'Goodbye';

  @override
  String get button_label => 'Submit';
}
