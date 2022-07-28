import 'package:equatable/equatable.dart';

abstract class ValueNotifierState<T> extends Equatable {
  T getValue();

  @override
  List<Object?> get props => [];
}

class InitialValueNotifierState<T> extends ValueNotifierState<T> {
  final T value;

  InitialValueNotifierState(this.value);

  @override
  T getValue() {
    return value;
  }

  @override
  List<Object?> get props => [value];
}

class UpdateValueNotifierState<T> extends ValueNotifierState<T> {
  final T value;

  UpdateValueNotifierState(this.value);

  @override
  T getValue() {
    return value;
  }

  @override
  List<Object?> get props => [value];
}
