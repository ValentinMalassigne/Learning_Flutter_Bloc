import 'package:bloc_anonymous/counter/counter_cubit.dart';
import 'package:bloc_anonymous/show_me_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anonymous Route',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<CounterCubit>(
        create: (context) => CounterCubit(),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) {
                      //we need to wrap the next page with a BlocProvider to allow the page to access the CounterCubit
                      //it is important to change the name of the context of the MaterialPageRoute builder, it would replace the previous context
                      return BlocProvider.value(
                        value: context.read<CounterCubit>(),
                        child: ShowMeCounter(),
                      );
                    },
                  ),
                );
              },
              child: Text(
                "Show Me Counter",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<CounterCubit>(context).increment();
              },
              child: Text(
                "Increment Counter",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
