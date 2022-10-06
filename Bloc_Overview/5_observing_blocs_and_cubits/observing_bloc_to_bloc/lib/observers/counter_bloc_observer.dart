import 'package:bloc/bloc.dart';

class CounterBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('CounterBlocObserver(event): ${bloc.runtimeType}, $event');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print(
        'CounterBlocObserver(error): ${bloc.runtimeType}, $error, $stackTrace');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('CounterBlocObserver(change): ${bloc.runtimeType}, $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('CounterBlocObserver(transition): ${bloc.runtimeType}, $transition');
  }
}
