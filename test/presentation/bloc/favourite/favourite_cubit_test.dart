import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search_ahead/presentation/bloc/favourite/favourite_cubit.dart';
import 'package:search_ahead/presentation/bloc/favourite/favourite_state.dart';

import '../../../shared_mocks.mocks.dart';

void main() {
  group('FavouriteCubitTest', () {
    late FavouriteCubit _cubit;
    var _favouriteRepository = MockIFavouriteRepository();
    var id1 = '1';
    var id2 = '2';
    var id3 = '3';
    var wrongId = '4';

    setUp(() {
      _cubit = FavouriteCubit(_favouriteRepository);
    });

    test('Initial state', () {
      expect(_cubit.state, InitialFavouriteState());
    });

    blocTest<FavouriteCubit, FavouriteState>(
      'changeFavouriteStatus emits false when list contains id',
      build: () {
        when(_favouriteRepository.getFavouriteIds())
            .thenReturn([id1, id2, id3]);
        return _cubit;
      },
      act: (cubit) => cubit.changeFavouriteStatus(id1),
      expect: () => <FavouriteState>[ChangeFavouriteState(false)],
      verify: (cubit) {
        verify(_favouriteRepository.removeIdFromList(id1)).called(1);
      },
    );

    blocTest<FavouriteCubit, FavouriteState>(
      'changeFavouriteStatus emits true when list does not contain id',
      build: () {
        when(_favouriteRepository.getFavouriteIds())
            .thenReturn([id1, id2, id3]);
        return _cubit;
      },
      act: (cubit) => cubit.changeFavouriteStatus(wrongId),
      expect: () => <FavouriteState>[ChangeFavouriteState(true)],
      verify: (cubit) {
        verify(_favouriteRepository.addIdToList(wrongId)).called(1);
      },
    );
  });
}
