import 'package:equatable/equatable.dart';
import 'package:search_ahead/core/model/home/event.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialHomeState extends HomeState {
  final int length;

  InitialHomeState(this.length);

  @override
  List<Object?> get props => [length];
}

class ShowTextFieldClearIcon extends HomeState {
  final bool shouldShowIcon;

  ShowTextFieldClearIcon({required this.shouldShowIcon});

  @override
  List<Object?> get props => [shouldShowIcon];
}

class EmptyHomeState extends HomeState {}

class ErrorHomeState extends HomeState {}

class DoneLoadResultsState extends HomeState {
  final List<Event> eventList;

  DoneLoadResultsState(this.eventList);

  @override
  List<Object?> get props => [eventList];
}

class LoadingHomeState extends HomeState {}
