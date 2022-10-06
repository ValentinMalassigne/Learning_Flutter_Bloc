import 'package:cubit_version/cubits/counter/counter_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

//This is the first and easiest way to listen to a StateUpdate
class BlocProviderExample extends StatelessWidget {
  const BlocProviderExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          //setting listen to true is necessary for the Text to be updated when the state changes
          '${BlocProvider.of<CounterCubit>(
            context,
            listen: true,
          ).state.counter}',
          style: TextStyle(fontSize: 52.0),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              //since the Button does not need to listen to state changes, setting listen to true would make the app crash
              BlocProvider.of<CounterCubit>(context).increment();
            },
            child: Icon(Icons.add),
            heroTag: 'increment',
          ),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              //since the Button does not need to listen to state changes, setting listen to true would make the app crash
              BlocProvider.of<CounterCubit>(context).decrement();
            },
            child: Icon(Icons.remove),
            heroTag: 'decrement',
          ),
        ],
      ),
    );
  }
}
