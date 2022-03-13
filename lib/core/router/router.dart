import 'package:auto_route/auto_route.dart';
import 'package:base_flutter_mvvm_bloc/presentation/widget/home/home_page.dart';
import 'package:flutter/cupertino.dart';

part 'router.gr.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute<void>(
      initial: true,
      page: MyHomePage,
    ),
  ],
)
class MyRouter extends _$MyRouter {}
