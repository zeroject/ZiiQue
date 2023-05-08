part of 'settings_bloc.dart';

@immutable
abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class UserDeleting extends SettingsState{
  @override
  List<Object?> get props => [];
}

class UserDeleted extends SettingsState{
  @override
  List<Object?> get props => [];
}
