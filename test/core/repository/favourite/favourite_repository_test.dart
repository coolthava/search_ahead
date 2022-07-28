import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search_ahead/core/repository/favourite/favourite_repository.dart';

import '../../../shared_mocks.mocks.dart';

void main() {
  group('FavouriteRepositoryTest', () {
    late FavouriteRepository _favouriteRepository;
    var _localStorage = MockILocalStorage();

    setUp(() {
      _favouriteRepository = FavouriteRepository(_localStorage);
    });

    test(
      'getFavouriteIds returns idList',
      () {
        when(_localStorage.getStringList(_favouriteRepository.idKey))
            .thenReturn(['1', '2', '3']);

        expect(_favouriteRepository.getFavouriteIds(), ['1', '2', '3']);

        verify(_localStorage.getStringList(_favouriteRepository.idKey))
            .called(1);
      },
    );

    test(
      'checkIfFavourite with correctId returns true',
      () {
        when(_localStorage.getStringList(_favouriteRepository.idKey))
            .thenReturn(['1', '2', '3']);
        expect(_favouriteRepository.checkIfFavourite('1'), true);

        verify(_localStorage.getStringList(_favouriteRepository.idKey))
            .called(1);
      },
    );

    test(
      'checkIfFavourite with incorrectId returns false',
      () {
        when(_localStorage.getStringList(_favouriteRepository.idKey))
            .thenReturn(['1', '2', '3']);
        expect(_favouriteRepository.checkIfFavourite('4'), false);

        verify(_localStorage.getStringList(_favouriteRepository.idKey))
            .called(1);
      },
    );

    test(
      'addIdToList ',
      () {
        when(_localStorage.getStringList(_favouriteRepository.idKey))
            .thenReturn(['1', '2', '3']);
        _favouriteRepository.addIdToList('4');

        verify(_localStorage.getStringList(_favouriteRepository.idKey))
            .called(1);

        verify(_localStorage.putStringList(
            _favouriteRepository.idKey, ['1', '2', '3', '4'])).called(1);
      },
    );

    test(
      'addIdToList ',
      () {
        when(_localStorage.getStringList(_favouriteRepository.idKey))
            .thenReturn(['1', '2', '3']);
        _favouriteRepository.removeIdFromList('2');

        verify(_localStorage.getStringList(_favouriteRepository.idKey))
            .called(1);

        verify(_localStorage
            .putStringList(_favouriteRepository.idKey, ['1', '3'])).called(1);
      },
    );
  });
}
