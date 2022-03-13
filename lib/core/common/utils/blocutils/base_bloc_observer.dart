import 'package:base_flutter_mvvm_bloc/core/common/utils/logger/i_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseAppBlocObserver extends BlocObserver {
  final ILogger logger;

  ///Bloc list that need to block to print out in log
  final List<Type> filterBlocLog = [];

  BaseAppBlocObserver(this.logger);

  ///Block some cubit to show in the log
  bool _blockBlocLog(BlocBase b) =>
      filterBlocLog.any((element) => element == b.runtimeType);

  @override
  // ignore: avoid_renaming_method_parameters
  void onChange(BlocBase cubit, Change change) {
    if (_blockBlocLog(cubit)) {
      return;
    }
    var logMsg = 'OnChange ${cubit.runtimeType.toString()} $change';
    logger.i(logMsg);
    super.onChange(cubit, change);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    var logMsg = 'Event Delegate --> $bloc, event: $event ';
    logger.i(logMsg);
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    var logMsg = 'Transition Delegate --->: $bloc, transition: $transition ';
    logger.i(logMsg);
    super.onTransition(bloc, transition);
  }

  @override
  // ignore: avoid_renaming_method_parameters
  void onError(BlocBase cubit, Object error, StackTrace stacktrace) {
    var logMsg = 'Error Delegate --->: $cubit, transition: $error';
    logger.i(logMsg);
    super.onError(cubit, error, stacktrace);
  }

  @override
  // ignore: avoid_renaming_method_parameters
  void onClose(BlocBase cubit) {
    if (_blockBlocLog(cubit)) {
      return;
    }
    var logMsg = 'Close Delegate ---> : $cubit';
    logger.i(logMsg);
    super.onClose(cubit);
  }
}
