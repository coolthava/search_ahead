import 'package:equatable/equatable.dart';

abstract class FavouriteState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialFavouriteState extends FavouriteState {}

class ChangeFavouriteState extends FavouriteState {
  final bool isFavourite;

  ChangeFavouriteState(this.isFavourite);

  @override
  List<Object?> get props => [isFavourite];
}
