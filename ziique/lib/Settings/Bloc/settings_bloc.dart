import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../FireService/Fire_UserService.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {

    on<DeleteUser>((event, emit) async {
      try{
        emit(UserDeleting());
        await UserService().DeleteUser();
        emit(UserDeleted());
      }catch(e){
        throw Exception(e.toString());
      }
    });
  }
}
