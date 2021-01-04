import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';
import 'appBloc.dart';
/// A function that creates an object of type [T].
///
/// See also:
///
///  * [Dispose], to free the resources associated to the value created.
typedef Create<T> = T Function(BuildContext context);
///
class AppBlocProvider<T extends AppBloc > extends BlocProvider<T>{
  AppBlocProvider({
    Key key,
    @required Create<T> create,
    Widget child,
    bool lazy,
  }) :super(
          key: key,
          create: create,
          child: child,
          lazy: lazy,
        );
  AppBlocProvider.value({
    Key key,
    @required T value,
    Widget child,
  }) : super.value(
          key: key,
          value: value,
          child: child,
        );
  static T of<T extends AppBloc>(BuildContext context) {
    return BlocProvider.of<T>(context);
  }
}