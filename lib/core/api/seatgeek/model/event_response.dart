import 'package:json_annotation/json_annotation.dart';
import 'package:search_ahead/core/model/home/event.dart';

part 'event_response.g.dart';

@JsonSerializable()
class EventListResponse {
  List<EventResponse> events;

  EventListResponse(this.events);

  static EventListResponse fromJson(Map<String, dynamic> json) =>
      _$EventListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EventListResponseToJson(this);

  EventList toModel() => EventList(events.map((e) => e.toModel()).toList());
}

@JsonSerializable()
class EventResponse {
  int id;
  List<PerformerResponse> performers;
  VenueResponse venue;
  @JsonKey(name: 'short_title')
  String shortTitle;
  String title;
  @JsonKey(name: 'datetime_utc')
  String dateTime;

  EventResponse(this.id, this.venue, this.performers, this.shortTitle,
      this.title, this.dateTime);

  static EventResponse fromJson(Map<String, dynamic> json) =>
      _$EventResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EventResponseToJson(this);

  Event toModel() => Event(id, performers.map((e) => e.toModel()).toList(),
      venue.toModel(), shortTitle, title, dateTime);
}

@JsonSerializable()
class VenueResponse {
  @JsonKey(name: 'display_location')
  String location;

  VenueResponse(this.location);

  static VenueResponse fromJson(Map<String, dynamic> json) =>
      _$VenueResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VenueResponseToJson(this);

  Venue toModel() => Venue(location);
}

@JsonSerializable()
class PerformerResponse {
  @JsonKey(name: 'id')
  int performerId;
  String name;
  String? image;

  PerformerResponse(this.performerId, this.name, this.image);

  static PerformerResponse fromJson(Map<String, dynamic> json) =>
      _$PerformerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PerformerResponseToJson(this);

  Performer toModel() => Performer(performerId, name, image);
}
