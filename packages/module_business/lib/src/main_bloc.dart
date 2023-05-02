import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:module_data/module_data.dart';
import 'package:module_model/module_model.dart';

part 'main_bloc.freezed.dart';

@injectable
class MainBlock {
  final UserService userService;
  final StreamController<MainBlocEvent> _eventController = StreamController();
  final StreamController<MainBlocState> _stateController = StreamController();

  Stream<MainBlocState> get state => _stateController.stream;

  MainBlock({required this.userService}) {
    _eventController.stream.listen((event) {
      event.map<void>(
          init: (_) async {
            _stateController.add(MainBlocState.loading());
            _stateController.add(MainBlocState.loaded(
                userData: await userService.getDefaultUser()));
          },
          setUser: (event) async => _stateController.add(MainBlocState.loaded(
              userData: await userService.getUserBuId(event.userId))));
    });
  }

  void add(MainBlocEvent event) {
    if (_eventController.isClosed) return;
    _eventController.add(event);
  }

  void dispose() {
    _eventController.close();
  }
}

@freezed
class MainBlocState with _$MainBlocState {
  factory MainBlocState.loading() = MainLoadingState;

  factory MainBlocState.loaded({required UserData userData}) = MainLoadedState;
}

@freezed
class MainBlocEvent with _$MainBlocEvent {
  factory MainBlocEvent.init() = MainInitEvent;

  factory MainBlocEvent.setUser({required int userId}) = MainSetEvent;
}
