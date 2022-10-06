import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/color/color_cubit.dart';
import 'cubits/counter/counter_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ColorCubit>(
          create: (context) => ColorCubit(),
        ),
        BlocProvider<CounterCubit>(
          create: (context) => CounterCubit(),
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
    return BlocListener<ColorCubit, ColorState>(
      listener: (context, state) {
        if (state.color == Colors.red) {
          incrementSize = 1;
        } else if (state.color == Colors.green) {
          incrementSize = 10;
        } else if (state.color == Colors.blue) {
          incrementSize = 100;
        } else if (state.color == Colors.black) {
          context.read<CounterCubit>().changeCounter(-100);
          incrementSize = -100;
        }
      },
      child: Scaffold(
        backgroundColor: context.watch<ColorCubit>().state.color,
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
                  context.read<ColorCubit>().changeColor();
                },
              ),
              const SizedBox(height: 20.0),
              Text(
                "${context.watch<CounterCubit>().state.counter}",
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
                  context.read<CounterCubit>().changeCounter(incrementSize);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
