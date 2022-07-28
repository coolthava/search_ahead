import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:search_ahead/core/repository/favourite/i_favourite_repository.dart';
import 'package:search_ahead/core/repository/search/i_search_repository.dart';
import 'package:search_ahead/presentation/bloc/home/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ISearchRepository _searchRepository;
  final IFavouriteRepository _favouriteRepository;

  HomeCubit(this._searchRepository, this._favouriteRepository)
      : super(InitialHomeState(0));

  String _currentWord = '';

  void shouldShowClearIcon(String text) {
    emit(ShowTextFieldClearIcon(shouldShowIcon: text.isNotEmpty));
  }

  Future<void> performSearch(String keyword, {bool isRefresh = false}) async {
    if (keyword.isNotEmpty &&
        keyword.length >= 3 &&
        (keyword != _currentWord || isRefresh)) {
      emit(LoadingHomeState());
      var either = await _searchRepository.getEventList(keyword);
      either.fold((l) => emit(ErrorHomeState()), (eventList) {
        if (eventList.isNotEmpty) {
          for (var event in eventList) {
            event.dateTime = DateFormat('EEE, dd/MM/yyyy hh:mm a')
                .format(DateTime.parse(event.dateTime));
            var idList = _favouriteRepository.getFavouriteIds();
            if (idList.contains(event.id.toString())) {
              event.isFavourite = true;
            }
          }
          emit(DoneLoadResultsState(eventList));
        } else {
          emit(EmptyHomeState());
        }
        _currentWord = keyword;
      });
    } else if (keyword == _currentWord) {
      return;
    } else {
      emit(InitialHomeState(keyword.length));
      _currentWord = keyword;
    }
  }
}
