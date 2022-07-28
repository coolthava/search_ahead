// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'router.dart';

class _$MyRouter extends RootStackRouter {
  _$MyRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    MyHomePageRoute.name: (routeData) {
      return MaterialPageX<void>(
          routeData: routeData, child: const MyHomePage());
    },
    EventDetailPageRoute.name: (routeData) {
      final args = routeData.argsAs<EventDetailPageRouteArgs>();
      return MaterialPageX<bool>(
          routeData: routeData,
          child: EventDetailPage(args.imgUrl, args.title, args.dateTime,
              args.location, args.isFavourite, args.id,
              key: args.key));
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(MyHomePageRoute.name, path: '/'),
        RouteConfig(EventDetailPageRoute.name, path: '/event-detail-page')
      ];
}

/// generated route for
/// [MyHomePage]
class MyHomePageRoute extends PageRouteInfo<void> {
  const MyHomePageRoute() : super(MyHomePageRoute.name, path: '/');

  static const String name = 'MyHomePageRoute';
}

/// generated route for
/// [EventDetailPage]
class EventDetailPageRoute extends PageRouteInfo<EventDetailPageRouteArgs> {
  EventDetailPageRoute(
      {required String imgUrl,
      required String title,
      required String dateTime,
      required String location,
      required bool isFavourite,
      required String id,
      Key? key})
      : super(EventDetailPageRoute.name,
            path: '/event-detail-page',
            args: EventDetailPageRouteArgs(
                imgUrl: imgUrl,
                title: title,
                dateTime: dateTime,
                location: location,
                isFavourite: isFavourite,
                id: id,
                key: key));

  static const String name = 'EventDetailPageRoute';
}

class EventDetailPageRouteArgs {
  const EventDetailPageRouteArgs(
      {required this.imgUrl,
      required this.title,
      required this.dateTime,
      required this.location,
      required this.isFavourite,
      required this.id,
      this.key});

  final String imgUrl;

  final String title;

  final String dateTime;

  final String location;

  final bool isFavourite;

  final String id;

  final Key? key;

  @override
  String toString() {
    return 'EventDetailPageRouteArgs{imgUrl: $imgUrl, title: $title, dateTime: $dateTime, location: $location, isFavourite: $isFavourite, id: $id, key: $key}';
  }
}
