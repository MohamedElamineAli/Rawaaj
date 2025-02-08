import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial()) {
    _loadProfile();
  }

  void _loadProfile() {
    emit(ProfileLoaded(
        username: 'Mohamed',
        email: 'Mohamed@example.com',
        password: '**********'
    ));
  }

  void updateUsername(String newUsername) {
    if (state is ProfileUpdated || state is ProfileLoaded) {
      final email = (state is ProfileUpdated) ? (state as ProfileUpdated).email : (state as ProfileLoaded).email;
      final password = (state is ProfileUpdated) ? (state as ProfileUpdated).password : (state as ProfileLoaded).password;
      emit(ProfileUpdated(
        username: newUsername,
        email: email,
        password: password,
      ));
    }
  }

  void updateEmail(String newEmail) {
    if (state is ProfileUpdated || state is ProfileLoaded) {
      final username = (state is ProfileUpdated) ? (state as ProfileUpdated).username : (state as ProfileLoaded).username;
      final password = (state is ProfileUpdated) ? (state as ProfileUpdated).password : (state as ProfileLoaded).password;
      emit(ProfileUpdated(
        username: username,
        email: newEmail,
        password: password,
      ));
    }
  }

  void updatePassword(String newPassword) {
    if (state is ProfileUpdated || state is ProfileLoaded) {
      final username = (state is ProfileUpdated) ? (state as ProfileUpdated).username : (state as ProfileLoaded).username;
      final email = (state is ProfileUpdated) ? (state as ProfileUpdated).email : (state as ProfileLoaded).email;
      emit(ProfileUpdated(
        username: username,
        email: email,
        password: newPassword,
      ));
    }
  }

  void saveProfile() {
    if (state is ProfileUpdated) {
      final updatedState = state as ProfileUpdated;
      emit(ProfileLoaded(
        username: updatedState.username,
        email: updatedState.email,
        password: updatedState.password,
      ));
    }
  }
}
