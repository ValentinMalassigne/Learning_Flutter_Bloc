part of 'counter_cubit.dart';

class CounterState {
  final int counter;
  CounterState({
    required this.counter,
  });

  @override
  int get hashCode => counter.hashCode;

  @override
  String toString() => 'CounterState(counter: $counter)';

  CounterState copyWith({
    int? counter,
  }) {
    return CounterState(
      counter: counter ?? this.counter,
    );
  }
}
