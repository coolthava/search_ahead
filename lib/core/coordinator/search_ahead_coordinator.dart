import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:search_ahead/core/coordinator/coordinator.dart';
import 'package:search_ahead/core/model/home/event.dart';
import 'package:search_ahead/core/router/router.dart';

class SearchAheadCoordinator extends Coordinator {
  @override
  bool canPop(BuildContext context) {
    // TODO: implement canPop
    return false;
  }

  @override
  Future<bool?> navigateToDetails(BuildContext context, Event event) async {
    return await AutoRouter.of(context).push<bool?>(EventDetailPageRoute(
      imgUrl: event.performers[0].image ?? '',
      title: event.title ?? '',
      dateTime: event.dateTime,
      location: event.venue.location,
      isFavourite: event.isFavourite,
      id: event.id.toString(),
    ));
  }

  @override
  void pop<T extends Object?>(BuildContext context, [T? result]) {
    AutoRouter.of(context).pop(result);
  }
}
