import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:observing_bloc_to_bloc/observers/color_bloc_observer.dart';
import 'package:observing_bloc_to_bloc/observers/counter_bloc_observer.dart';

import 'blocs/color/color_bloc.dart';
import 'blocs/counter/counter_bloc.dart';

void main() {
  Bloc.observer = ColorBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ColorBloc>(
          create: (context) => ColorBloc(),
        ),
        BlocProvider<CounterBloc>(
          create: (context) => CounterBloc(
            colorBloc: context.read<ColorBloc>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<ColorBloc>().state.color,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text(
                "Change Color",
                style: TextStyle(fontSize: 24.0),
              ),
              onPressed: () {
                context.read<ColorBloc>().add(ChangeColorEvent());
              },
            ),
            const SizedBox(height: 20.0),
            Text(
              "${context.watch<CounterBloc>().state.counter}",
              style: TextStyle(
                fontSize: 52.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              child: Text(
                "Increment Counter",
                style: TextStyle(fontSize: 24.0),
              ),
              onPressed: () {
                context.read<CounterBloc>().add(ChangeCounterEvent());
              },
            )
          ],
        ),
      ),
    );
  }
}
