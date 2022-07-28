import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:search_ahead/presentation/widget/eventdetails/event_detail_page.dart';
import 'package:search_ahead/presentation/widget/home/home_page.dart';

part 'router.gr.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute<void>(
      initial: true,
      page: MyHomePage,
    ),
    AutoRoute<bool>(
      page: EventDetailPage,
    )
  ],
)
class MyRouter extends _$MyRouter {}
