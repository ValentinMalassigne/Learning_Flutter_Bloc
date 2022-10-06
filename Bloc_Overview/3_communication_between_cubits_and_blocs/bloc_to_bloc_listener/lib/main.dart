import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/color/color_bloc.dart';
import 'blocs/counter/counter_bloc.dart';

void main() {
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
          create: (context) => CounterBloc(),
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int incrementSize = 1;
  @override
  Widget build(BuildContext context) {
    return BlocListener<ColorBloc, ColorState>(
      listener: (context, colorState) {
        if (colorState.color == Colors.red) {
          incrementSize = 1;
        } else if (colorState.color == Colors.green) {
          incrementSize = 10;
        } else if (colorState.color == Colors.blue) {
          incrementSize = 100;
        } else if (colorState.color == Colors.black) {
          incrementSize = -100;
          context
              .read<CounterBloc>()
              .add(ChangeCounterEvent(incrementSize: incrementSize));
        }
      },
      child: Scaffold(
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
                  context
                      .read<CounterBloc>()
                      .add(ChangeCounterEvent(incrementSize: incrementSize));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
