import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(const CounterState(count: 0));

  increment({bool? isDark}) {
    int addNum = isDark == true ? 2 : 1;
    int resuld = state.count + addNum;
    if (resuld <= 10) {
      emit(
        CounterState(count: resuld),
      );
    } else {
      emit(
        const CounterState(count: 10),
      );
    }
  }

  decrement({bool? isDark}) {
    int addNum = isDark == true ? 2 : 1;
    int resuld = state.count - addNum;
    if (resuld >= 0) {
      emit(
        CounterState(count: resuld),
      );
    } else {
      emit(
        const CounterState(count: 0),
      );
    }
  }
}
