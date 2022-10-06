import 'package:cubit_version/cubits/counter/counter_cubit.dart';
import 'package:cubit_version/other_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

//using BuildContext extension method instead of calling a static Bloc method
//see the change in the button's onPressed callback
/*
context.watch<T>() makes the widget listen to changes on T
context.read<T>() returns T without listening to it
context.select<T,R>(R cb(T value)) allows a widget to listen to only a defined part of T
*/

class BuildContextExtensionExample extends StatelessWidget {
  const BuildContextExtensionExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CounterCubit, CounterState>(
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
        builder: (context, state) {
          return Center(
            child: Text(
              '${state.counter}',
              style: TextStyle(fontSize: 52.0),
            ),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<CounterCubit>().decrement();
            },
            child: Icon(Icons.add),
            heroTag: 'increment',
          ),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterCubit>().decrement();
            },
            child: Icon(Icons.remove),
            heroTag: 'decrement',
          ),
        ],
      ),
    );
  }
}
