import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

abstract class AppBloc<S> extends Bloc<_AppEvent<S>, S> {
  AppBloc(S initialState) : super(initialState);

  void dispatch(String eventName, [S s]) {
    if (s == null) s = state;
    _AppEvent<S> event = _AppEvent<S>(eventName, s);
    super.add(event);
  }

  @override
  Stream<S> mapEventToState(_AppEvent<S> event) async* {
    switch (event) {
      default:
        yield event.state;
        break;
    }
  }
}

class _AppEvent<S> extends Equatable {
  final S state;
  final String eventName;
  _AppEvent(this.eventName, this.state);
  @override
  List<Object> get props => [eventName, state];
}
