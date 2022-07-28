import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search_ahead/core/api/seatgeek/model/event_response.dart';
import 'package:search_ahead/core/model/home/event.dart';
import 'package:search_ahead/core/repository/search/search_repository.dart';

import '../../../shared_mocks.mocks.dart';

void main() {
  group('SearchRepositoryTest', () {
    late SearchRepository searchRepository;
    var mockProvider = MockISeatGeekProvider();
    var performers = PerformerResponse(12, 'name', 'image');
    var venue = VenueResponse('location');
    var eventResponse = EventResponse(
        123, venue, [performers], 'shortTitle', 'title', 'dateTime');
    var translatedEvent = Event(123, [Performer(12, 'name', 'image')],
        Venue('location'), 'shortTitle', 'title', 'dateTime');
    var eventListReponse = EventListResponse([eventResponse]);

    setUp(() {
      searchRepository = SearchRepository(mockProvider);
    });

    test(
      'Success getEventList returns Right with List',
      () async {
        when(mockProvider.getEventList('keyword'))
            .thenAnswer((_) async => eventListReponse);
        var eventEither = await searchRepository.getEventList('keyword');
        var event = eventEither.fold((l) => null, (r) => r[0]);

        verify(mockProvider.getEventList('keyword')).called(1);
        expect(event, isInstanceOf<Event>());
        expect(event?.id, translatedEvent.id);
      },
    );

    var exception = Exception();
    test(
      'failed getEventList returns Left with exception',
      () async {
        when(mockProvider.getEventList('keyword')).thenThrow(exception);

        expect(await searchRepository.getEventList('keyword'),
            Left<Exception, List<Event>>(exception));

        verify(mockProvider.getEventList('keyword')).called(1);
      },
    );
  });
}
