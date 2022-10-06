import 'package:cubit_version/cubits/counter/counter_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'examples_with_cubit/bloc_provider_example.dart';
import 'examples_with_cubit/bloc_builder_example.dart';
import 'examples_with_cubit/bloc_listener_example.dart';
import 'examples_with_cubit/bloc_consumer_example.dart';
import 'examples_with_cubit/buildcontext_extension_example.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        title: 'MyCounter Cubit',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const BuildContextExtensionExample(),
      ),
    );
  }
}
