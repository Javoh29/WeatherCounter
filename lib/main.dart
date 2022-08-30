import 'package:counter_weather/core/di/scopes/bloc_scope.dart';
import 'package:counter_weather/core/di/scopes/theme_scope.dart';
import 'package:counter_weather/presentation/pages/counter/bloc/theme/theme_cubit.dart';
import 'package:counter_weather/presentation/pages/counter/presentation/counter_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocScope(
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            double height = MediaQuery.of(context).size.height;
            return ThemeScope(
              childBuilder: (context, index) => const CounterPage(),
              isDark: state.isDark,
              offset: Offset(50, height - 50),
            );
          },
        ),
      ),
    );
  }
}
