part of 'language_cubit.dart';

@immutable
abstract class LanguageState {}

class LanguageInitial extends LanguageState {}

class LanguageLoaded extends LanguageState {
  final String selectedLanguage;

  LanguageLoaded({required this.selectedLanguage});
}

class LanguageUpdated extends LanguageState {
  final String selectedLanguage;

  LanguageUpdated({required this.selectedLanguage});
}
