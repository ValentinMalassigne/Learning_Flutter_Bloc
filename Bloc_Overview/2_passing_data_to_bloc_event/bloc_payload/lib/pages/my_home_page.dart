import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../theme/theme_bloc.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Theme"),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text(
            "Change Theme",
            style: TextStyle(fontSize: 24.0),
          ),
          onPressed: () {
            final int randInt = Random().nextInt(10);
            print("randInt: $randInt");

            context.read<ThemeBloc>().add(ChangeThemeEvent(randInt));
          },
        ),
      ),
    );
  }
}
