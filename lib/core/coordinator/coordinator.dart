import 'package:flutter/cupertino.dart';
import 'package:search_ahead/core/model/home/event.dart';

abstract class Coordinator {
  bool canPop(BuildContext context);
  Future<bool?> navigateToDetails(BuildContext context, Event event);
  void pop<T extends Object?>(BuildContext context, [T? result]);
}
