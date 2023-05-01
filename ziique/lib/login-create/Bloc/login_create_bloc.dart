import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_create_event.dart';
part 'login_create_state.dart';

class LoginCreateBloc extends Bloc<LoginCreateEvent, LoginCreateState> {
  LoginCreateBloc() : super(LoginCreateInitial()) {
    on<LoginCreateEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
