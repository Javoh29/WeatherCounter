import 'package:counter_weather/data/repositories/weather_repository_impl.dart';
import 'package:counter_weather/presentation/pages/counter/bloc/counter/counter_cubit.dart';
import 'package:counter_weather/presentation/pages/counter/bloc/theme/theme_cubit.dart';
import 'package:counter_weather/presentation/pages/counter/bloc/weather/weather_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocScope extends StatelessWidget {
  const BlocScope({required this.child, Key? key}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<ThemeCubit>(
        create: (_) => ThemeCubit(),
      ),
      BlocProvider<CounterCubit>(
        create: (_) => CounterCubit(),
      ),
      BlocProvider<WeatherCubit>(
        create: (_) => WeatherCubit(
          WeatherRepositoryImpl(),
        ),
      )
    ], child: child);
  }
}
