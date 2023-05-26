import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'beat_board_event.dart';
part 'beat_board_state.dart';

class BeatBoardBloc extends Bloc<BeatBoardEvent, BeatBoardState> {
  BeatBoardBloc() : super(BeatBoardInitial()) {
    on<BeatBoardEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
