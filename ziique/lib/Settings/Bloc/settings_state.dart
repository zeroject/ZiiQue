part of 'settings_bloc.dart';

@immutable
abstract class SettingsState {
 String scene;

 SettingsState({required this.scene});
}

class SettingsInitial extends SettingsState {
  SettingsInitial(): super(scene: 'Account');
}

class SettingsSelected extends SettingsState{
  SettingsSelected({required super.scene});
}
