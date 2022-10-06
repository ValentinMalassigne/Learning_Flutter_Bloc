import 'package:cubit_version/cubits/counter/counter_cubit.dart';
import 'package:cubit_version/other_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

//adding a listener to the state
//this is not the right solution in our case because we are nesting BlocBuilder and BlocListener see the BlocConsumer example
class BlocListenerExample extends StatelessWidget {
  const BlocListenerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CounterCubit, CounterState>(
        listener: (context, state) {
          if (state.counter == 3) {
            showDialog(
              context: context,
              builder: ((context) {
                return AlertDialog(
                  content: Text("counter is ${state.counter}"),
                );
              }),
            );
          } else if (state.counter == -1) {
            Navigator.push(context, MaterialPageRoute(
              builder: ((context) {
                return OtherPage();
              }),
            ));
          }
        },
        child: BlocBuilder<CounterCubit, CounterState>(
          builder: (context, state) {
            return Center(
              child: Text(
                '${state.counter}',
                style: TextStyle(fontSize: 52.0),
              ),
            );
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
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
