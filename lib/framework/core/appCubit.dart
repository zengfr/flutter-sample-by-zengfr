import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AppCubit<State> extends Cubit<State>  {
  AppCubit(State state) : super(state);
}