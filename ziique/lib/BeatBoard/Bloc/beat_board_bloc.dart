import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

part 'beat_board_event.dart';
part 'beat_board_state.dart';

class BeatBoardBloc extends Bloc<BeatBoardEvent, BeatBoardState> {
  BeatBoardBloc() : super(BeatBoardInitial()) {
    on<BeatBoardEvent>((event, emit) {

    });
  }
}
