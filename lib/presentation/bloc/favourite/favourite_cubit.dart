import 'package:bloc/bloc.dart';
import 'package:search_ahead/core/repository/favourite_repository/i_favourite_repository.dart';
import 'package:search_ahead/presentation/bloc/favourite/favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  final IFavouriteRepository _favouriteRepository;

  List<String>? currentIdsCache;
  FavouriteCubit(this._favouriteRepository) : super(InitialFavouriteState());

  void changeFavouriteStatus(String id) async {
    currentIdsCache ??= _favouriteRepository.getFavouriteIds();
    if (currentIdsCache!.contains(id)) {
      currentIdsCache!.remove(id);
      _favouriteRepository.removeIdFromList(id);
      emit(ChangeFavouriteState(false));
    } else {
      currentIdsCache!.add(id);
      _favouriteRepository.addIdToList(id);
      emit(ChangeFavouriteState(true));
    }
  }
}
