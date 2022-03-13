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
    }
  };

  @override
  List<RouteConfig> get routes =>
      [RouteConfig(MyHomePageRoute.name, path: '/')];
}

/// generated route for
/// [MyHomePage]
class MyHomePageRoute extends PageRouteInfo<void> {
  const MyHomePageRoute() : super(MyHomePageRoute.name, path: '/');

  static const String name = 'MyHomePageRoute';
}
