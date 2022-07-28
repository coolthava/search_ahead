import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mockito/mockito.dart';
import 'package:search_ahead/core/model/home/event.dart';
import 'package:search_ahead/presentation/bloc/home/home_cubit.dart';
import 'package:search_ahead/presentation/bloc/home/home_state.dart';

import '../../../shared_mocks.mocks.dart';

void main() {
  group('HomeCubitTest', () {
    late HomeCubit _homeCubit;
    var _searchRepository = MockISearchRepository();
    var _favouriteRepository = MockIFavouriteRepository();
    var performers = MockPerformer();
    var venue = MockVenue();
    var favId = 123;
    var nonFavId = 1;
    var dateTime = '2022-07-27T23:30:00';
    var mockEvent = Event(nonFavId, [performers], venue, 'shortTitle', 'title',
        '2022-07-27T23:30:00');
    var mockEventFav = Event(favId, [performers], venue, 'shortTitle', 'title',
        '2022-07-27T23:30:00');
    var formattedDateString =
        DateFormat('EEE, dd/MM/yyyy hh:mm a').format(DateTime.parse(dateTime));

    setUp(() {
      _homeCubit = HomeCubit(_searchRepository, _favouriteRepository);
    });

    void resetEvent() {
      mockEventFav.dateTime = dateTime;
      mockEvent.dateTime = dateTime;
    }

    test('Initial State', () {
      expect(_homeCubit.state, InitialHomeState(0));
    });

    blocTest<HomeCubit, HomeState>(
      'shouldShowClear Icon emit true when text not empty',
      build: () {
        return _homeCubit;
      },
      act: (cubit) => cubit.shouldShowClearIcon('text'),
      expect: () => <HomeState>[ShowTextFieldClearIcon(shouldShowIcon: true)],
    );

    blocTest<HomeCubit, HomeState>(
      'shouldShowClear Icon emit false when text empty',
      build: () {
        return _homeCubit;
      },
      act: (cubit) => cubit.shouldShowClearIcon(''),
      expect: () => <HomeState>[ShowTextFieldClearIcon(shouldShowIcon: false)],
    );

    blocTest<HomeCubit, HomeState>(
      'performSearch with empty emits Initial with 0',
      build: () {
        return _homeCubit;
      },
      act: (cubit) async {
        await cubit.performSearch('ab');
        cubit.performSearch('');
      },
      expect: () => <HomeState>[InitialHomeState(2), InitialHomeState(0)],
      verify: (cubit) {
        verifyNever(_searchRepository.getEventList('abc'));
        verifyNever(_favouriteRepository.getFavouriteIds());
      },
    );

    blocTest<HomeCubit, HomeState>(
      'performSearch with length 2 emits Initial with 2',
      build: () {
        return _homeCubit;
      },
      act: (cubit) => cubit.performSearch('ab'),
      expect: () => <HomeState>[InitialHomeState(2)],
      verify: (cubit) {
        verifyNever(_searchRepository.getEventList('abc'));
        verifyNever(_favouriteRepository.getFavouriteIds());
      },
    );

    blocTest<HomeCubit, HomeState>(
      'performSearch with length 3 with success emits DoneLoad with mockList',
      build: () {
        when(_searchRepository.getEventList('abc'))
            .thenAnswer((_) async => Right([mockEventFav]));
        when(_favouriteRepository.getFavouriteIds())
            .thenReturn([favId.toString()]);
        return _homeCubit;
      },
      act: (cubit) => cubit.performSearch('abc'),
      expect: () => <HomeState>[
        LoadingHomeState(),
        DoneLoadResultsState([mockEventFav])
      ],
      verify: (cubit) {
        verify(_searchRepository.getEventList('abc')).called(1);
        verify(_favouriteRepository.getFavouriteIds()).called(1);
        expect(mockEventFav.isFavourite, true);
        expect(mockEventFav.dateTime, formattedDateString);
      },
    );

    blocTest<HomeCubit, HomeState>(
      'performSearch with length 3 with success twice(same word) only emits DoneLoad with mockList once',
      build: () {
        resetEvent();
        when(_searchRepository.getEventList('abc'))
            .thenAnswer((_) async => Right([mockEventFav]));
        when(_favouriteRepository.getFavouriteIds())
            .thenReturn([favId.toString()]);
        return _homeCubit;
      },
      act: (cubit) async {
        await cubit.performSearch('abc');
        cubit.performSearch('abc');
      },
      expect: () => <HomeState>[
        LoadingHomeState(),
        DoneLoadResultsState([mockEventFav])
      ],
      verify: (cubit) {
        verify(_searchRepository.getEventList('abc')).called(1);
        verify(_favouriteRepository.getFavouriteIds()).called(1);
        expect(mockEventFav.isFavourite, true);
        expect(mockEventFav.dateTime, formattedDateString);
      },
    );

    blocTest<HomeCubit, HomeState>(
      'performSearch with length 3 with success twice(same word)  emits DoneLoad with mockList twice if isRefresh true',
      build: () {
        resetEvent();
        when(_searchRepository.getEventList('abc'))
            .thenAnswer((_) async => Right([mockEventFav]));
        when(_favouriteRepository.getFavouriteIds())
            .thenReturn([favId.toString()]);
        return _homeCubit;
      },
      act: (cubit) async {
        await cubit.performSearch('abc');
        mockEventFav.dateTime = dateTime;
        cubit.performSearch('abc', isRefresh: true);
      },
      expect: () => <HomeState>[
        LoadingHomeState(),
        DoneLoadResultsState([mockEventFav]),
        LoadingHomeState(),
        DoneLoadResultsState([mockEventFav]),
      ],
      verify: (cubit) {
        verify(_searchRepository.getEventList('abc')).called(2);
        verify(_favouriteRepository.getFavouriteIds()).called(2);
        expect(mockEventFav.isFavourite, true);
        expect(mockEventFav.dateTime, formattedDateString);
      },
    );

    blocTest<HomeCubit, HomeState>(
      'performSearch with length 3 with success emits Empty with empty mockList',
      build: () {
        resetEvent();
        when(_searchRepository.getEventList('abc'))
            .thenAnswer((_) async => const Right([]));
        when(_favouriteRepository.getFavouriteIds())
            .thenReturn([favId.toString()]);
        return _homeCubit;
      },
      act: (cubit) => cubit.performSearch('abc'),
      expect: () => <HomeState>[
        LoadingHomeState(),
        EmptyHomeState(),
      ],
      verify: (cubit) {
        verify(_searchRepository.getEventList('abc')).called(1);
        verifyNever(_favouriteRepository.getFavouriteIds());
      },
    );
  });
}
