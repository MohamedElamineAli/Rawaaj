import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitial());

  final List<String> languages = ['English', 'Français', 'العربية'];

  void loadInitialLanguage() {
    emit(LanguageLoaded(selectedLanguage: 'English'));
  }

  void updateLanguage(String language) {
    emit(LanguageUpdated(selectedLanguage: language));
  }
}
