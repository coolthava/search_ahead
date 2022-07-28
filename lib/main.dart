import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_ahead/core/common/utils/blocutils/base_bloc_observer.dart';
import 'package:search_ahead/core/common/utils/localstorage/i_local_storage.dart';
import 'package:search_ahead/core/di/service_locator.dart';
import 'package:search_ahead/core/router/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureServiceLocator(Platform.isIOS);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AutoRouterDelegate? _routerDelegate;

  @override
  void didChangeDependencies() async {
    // await configureServiceLocator(Platform.isIOS);
    _routerDelegate = AutoRouterDelegate(
      sl.get<MyRouter>(),
    );
    BlocOverrides.runZoned(
      () {},
      blocObserver: sl.get<BaseAppBlocObserver>(),
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: sl.get<ILocalStorage>().initState(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MaterialApp.router(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              routerDelegate: _routerDelegate!,
              routeInformationParser: sl.get<MyRouter>().defaultRouteParser(),
              routeInformationProvider: sl.get<MyRouter>().routeInfoProvider(),
              debugShowCheckedModeBanner: false,
            );
          }
          return const SizedBox.shrink();
        });
  }
}
