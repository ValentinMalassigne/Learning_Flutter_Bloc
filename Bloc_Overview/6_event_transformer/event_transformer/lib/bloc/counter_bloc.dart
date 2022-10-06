import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState.initial()) {
    /*
      list of transformers :
      droppable() : any new events sent while the first one is not compledted will be droppped
      restartable() : if a new event is sent then the current one will be dropped and the new one will start to be processed
      sequential() : while the execution of the first event is not finished the second will not be executed
      concurrent() : (by default) events are executed as soon are they are recieved, the events results may not arrive in the same order
      */
    /* 
    on<IncrementCounterEvent>(
      _handleIncrementCounterEvent,
    );

    on<DecrementCounterEvent>(
      _handleDecrementCounterEvent,
      transformer: restartable(),
     
    );
    */

    //to use the sequential transformer across different events it is required to put all events under the same buckets
    on<CounterEvent>(
      (event, emit) async {
        if (event is IncrementCounterEvent) {
          await _handleIncrementCounterEvent(event, emit);
        } else if (event is DecrementCounterEvent) {
          await _handleDecrementCounterEvent(event, emit);
        }
      },
      transformer: sequential(),
    );
  }

  Future<void> _handleIncrementCounterEvent(event, emit) async {
    await Future.delayed(Duration(seconds: 4));
    emit(state.copyWith(counter: state.counter + 1));
  }

  Future<void> _handleDecrementCounterEvent(event, emit) async {
    await Future.delayed(Duration(seconds: 2));
    emit(state.copyWith(counter: state.counter - 1));
  }
}
