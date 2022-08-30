import 'package:counter_weather/presentation/pages/counter/bloc/counter/counter_cubit.dart';
import 'package:counter_weather/presentation/pages/counter/bloc/theme/theme_cubit.dart';
import 'package:counter_weather/presentation/pages/counter/bloc/weather/weather_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  double scale = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Counter'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<WeatherCubit, WeatherState>(builder: (context, state) {
            if (state is WeatherStateInProgress) {
              return const CircularProgressIndicator();
            } else if (state is WeatherStateCompleted) {
              return Text(state.weatherData);
            } else {
              if (state is WeatherStateFailed) {
                Future.delayed(
                    Duration.zero,
                    () => Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            backgroundColor: Colors.red,
                          ),
                        ));
              }
              return const Text('Press the icon to get your location');
            }
          }),
          const SizedBox(
            height: 50,
            width: double.infinity,
          ),
          const Text('You have pushed the button this many times'),
          BlocBuilder<CounterCubit, CounterState>(
            builder: ((context, state) {
              return Text(
                state.count.toString(),
                style: Theme.of(context).textTheme.headline4,
              );
            }),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            OtherSettingButtons(),
            CounterFloatButtons(),
          ],
        ),
      ),
    );
  }
}

class OtherSettingButtons extends StatelessWidget {
  const OtherSettingButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          onPressed: () {
            context.read<WeatherCubit>().loadCurrentWeather();
          },
          child: const Icon(Icons.cloud),
        ),
        const SizedBox(
          height: 20,
        ),
        FloatingActionButton(
          onPressed: () {
            context.read<ThemeCubit>().changeTheme();
          },
          child: const Icon(Icons.color_lens),
        )
      ],
    );
  }
}

class CounterFloatButtons extends StatelessWidget {
  const CounterFloatButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = context.watch<ThemeCubit>().state.isDark;
    return BlocBuilder<CounterCubit, CounterState>(builder: (context, state) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedScale(
            duration: const Duration(milliseconds: 200),
            scale: state.count == 10 ? 0 : 1,
            child: FloatingActionButton(
              onPressed: () {
                context.read<CounterCubit>().increment(isDark: isDark);
              },
              child: const Icon(Icons.add),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          AnimatedScale(
            duration: const Duration(milliseconds: 200),
            scale: state.count == 0 ? 0 : 1,
            child: FloatingActionButton(
              onPressed: () {
                context.read<CounterCubit>().decrement(isDark: isDark);
              },
              child: const Icon(Icons.remove),
            ),
          )
        ],
      );
    });
  }
}
