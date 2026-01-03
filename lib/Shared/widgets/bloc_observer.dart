import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print(' onCreate — ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print(
      ' onChange — ${bloc.runtimeType}\n'
      '   currentState: ${change.currentState}\n'
      '   nextState: ${change.nextState}',
    );
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(
      ' onTransition — ${bloc.runtimeType}\n'
      '   event: ${transition.event}\n'
      '   from: ${transition.currentState}\n'
      '   to: ${transition.nextState}',
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print(
      ' onError — ${bloc.runtimeType}\n'
      '   error: $error',
    );
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print(' onClose — ${bloc.runtimeType}');
  }
}
