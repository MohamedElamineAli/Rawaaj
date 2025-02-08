part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final String username;
  final String email;
  final String password;

  ProfileLoaded({
    required this.username,
    required this.email,
    required this.password,
  });
}

final class ProfileUpdated extends ProfileState {
  final String username;
  final String email;
  final String password;

  ProfileUpdated({
    required this.username,
    required this.email,
    required this.password,
  });
}
