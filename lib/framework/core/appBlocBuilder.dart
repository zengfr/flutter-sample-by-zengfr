import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'appBloc.dart';
/// Signature for the `builder` function which takes the `BuildContext` and
/// [state] and is responsible for returning a widget which is to be rendered.
/// This is analogous to the `builder` function in [StreamBuilder].
typedef BlocWidgetBuilder<S> = Widget Function(BuildContext context, S state);
///BlocBuilder
///
 class AppBlocBuilder<C extends AppBloc<S>,S> extends BlocBuilder<C,S> {
AppBlocBuilder({
    Key key,
    @required BlocWidgetBuilder<S> builder,
    C cubit,
    BlocBuilderCondition<S> buildWhen,
  })  : 
        super(key: key,builder:builder, cubit: cubit, buildWhen: buildWhen);
}