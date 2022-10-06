import 'package:bloc_payload/pages/my_home_page.dart';
import 'package:bloc_payload/theme/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyAppWithContextWatch());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Event Payload',
            debugShowCheckedModeBanner: false,
            theme: state.appTheme == AppTheme.light
                ? ThemeData.light()
                : ThemeData.dark(),
            home: const MyHomePage(),
          );
        },
      ),
    );
  }
}

//we can see that using a BlocBuilder or a combination of Builder and context extension method is similar
//BlocBuilder can still be usefull when needing a context to find a BlocProvider
class MyAppWithContextWatch extends StatelessWidget {
  const MyAppWithContextWatch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
      create: (context) => ThemeBloc(),
      child: Builder(builder: (context) {
        return MaterialApp(
          title: 'Event Payload',
          debugShowCheckedModeBanner: false,
          theme: context.watch<ThemeBloc>().state.appTheme == AppTheme.light
              ? ThemeData.light()
              : ThemeData.dark(),
          home: const MyHomePage(),
        );
      }),
    );
  }
}
