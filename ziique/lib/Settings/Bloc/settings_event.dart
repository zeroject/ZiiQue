part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {
}

class SceneSelected extends SettingsEvent{
  String scene;

  SceneSelected({required this.scene});
}

class DeleteUser extends SettingsEvent{
  DeleteUser();
}
