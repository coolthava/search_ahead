import 'package:bloc/bloc.dart';
import 'package:search_ahead/presentation/bloc/common/value_notifier_state.dart';

class ValueNotifierCubit<T> extends Cubit<ValueNotifierState<T>> {
  ValueNotifierCubit(T value) : super(InitialValueNotifierState<T>(value));

  T? currentValue;

  void updateValue(T value) {
    currentValue = value;
    emit(UpdateValueNotifierState<T>(value));
  }
}
