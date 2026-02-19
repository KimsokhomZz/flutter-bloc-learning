import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  // INCREMENT COUNTER
  void increment() => emit(state + 1);

  // DECREMENT COUNTER
  void decrement() => emit(state - 1);
}
