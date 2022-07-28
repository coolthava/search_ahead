import 'package:search_ahead/core/api/seatgeek/model/event_response.dart';

abstract class ISeatGeekProvider {
  Future<EventListResponse> getEventList(String keyword);
}
