// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventListResponse _$EventListResponseFromJson(Map<String, dynamic> json) =>
    EventListResponse(
      (json['events'] as List<dynamic>)
          .map((e) => EventResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EventListResponseToJson(EventListResponse instance) =>
    <String, dynamic>{
      'events': instance.events,
    };

EventResponse _$EventResponseFromJson(Map<String, dynamic> json) =>
    EventResponse(
      json['id'] as int,
      VenueResponse.fromJson(json['venue'] as Map<String, dynamic>),
      (json['performers'] as List<dynamic>)
          .map((e) => PerformerResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['short_title'] as String,
      json['title'] as String,
      json['datetime_utc'] as String,
    );

Map<String, dynamic> _$EventResponseToJson(EventResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'performers': instance.performers,
      'venue': instance.venue,
      'short_title': instance.shortTitle,
      'title': instance.title,
      'datetime_utc': instance.dateTime,
    };

VenueResponse _$VenueResponseFromJson(Map<String, dynamic> json) =>
    VenueResponse(
      json['display_location'] as String,
    );

Map<String, dynamic> _$VenueResponseToJson(VenueResponse instance) =>
    <String, dynamic>{
      'display_location': instance.location,
    };

PerformerResponse _$PerformerResponseFromJson(Map<String, dynamic> json) =>
    PerformerResponse(
      json['id'] as int,
      json['name'] as String,
      json['image'] as String?,
    );

Map<String, dynamic> _$PerformerResponseToJson(PerformerResponse instance) =>
    <String, dynamic>{
      'id': instance.performerId,
      'name': instance.name,
      'image': instance.image,
    };
