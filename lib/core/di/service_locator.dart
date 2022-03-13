import 'package:base_flutter_mvvm_bloc/core/common/utils/blocutils/base_bloc_observer.dart';
import 'package:base_flutter_mvvm_bloc/core/common/utils/logger/base_logger.dart';
import 'package:base_flutter_mvvm_bloc/core/common/utils/logger/i_logger.dart';
import 'package:base_flutter_mvvm_bloc/core/router/router.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

var sl = GetIt.instance;

Future<void> configureServiceLocator(bool isIos) async {
  sl.registerSingleton<MyRouter>(MyRouter());

  sl.registerSingleton<ILogger>(BaseLogger(Logger(
    level: Level.debug,
    printer: PrefixPrinter(
      PrettyPrinter(
        methodCount: 2,
        // number of method calls to be displayed
        errorMethodCount: 8,
        // number of method calls if stacktrace is provided
        lineLength: 90,
        // width of the output
        colors: true,
        // Colorful log messages
        printEmojis: true,
        // Print an emoji for each log message
        printTime: false,
      ),
    ),
  )));

  sl.registerSingleton(BaseAppBlocObserver(sl.get<ILogger>()));
}
