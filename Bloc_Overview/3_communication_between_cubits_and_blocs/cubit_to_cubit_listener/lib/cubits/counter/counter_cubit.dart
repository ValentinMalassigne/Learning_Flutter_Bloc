import 'package:bloc/bloc.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState.initial());

  void changeCounter(int incrementSize) {
    emit(state.copyWith(counter: state.counter + incrementSize));
  }
}
