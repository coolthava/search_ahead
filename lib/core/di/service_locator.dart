import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:search_ahead/core/api/seatgeek/i_seatgeek_provider.dart';
import 'package:search_ahead/core/api/seatgeek/seatgeek_provider.dart';
import 'package:search_ahead/core/common/localstorage/shared_preferences_storage.dart';
import 'package:search_ahead/core/common/network/dioclient/dio_network_client.dart';
import 'package:search_ahead/core/common/network/i_network_client.dart';
import 'package:search_ahead/core/common/network/options.dart';
import 'package:search_ahead/core/common/utils/blocutils/base_bloc_observer.dart';
import 'package:search_ahead/core/common/utils/localstorage/i_local_storage.dart';
import 'package:search_ahead/core/common/utils/logger/base_logger.dart';
import 'package:search_ahead/core/common/utils/logger/i_logger.dart';
import 'package:search_ahead/core/coordinator/coordinator.dart';
import 'package:search_ahead/core/coordinator/search_ahead_coordinator.dart';
import 'package:search_ahead/core/repository/favourite_repository/favourite_repository.dart';
import 'package:search_ahead/core/repository/favourite_repository/i_favourite_repository.dart';
import 'package:search_ahead/core/repository/search/i_search_repository.dart';
import 'package:search_ahead/core/repository/search/search_repository.dart';
import 'package:search_ahead/core/router/router.dart';
import 'package:search_ahead/presentation/bloc/common/value_notifier_cubit.dart';
import 'package:search_ahead/presentation/bloc/favourite/favourite_cubit.dart';
import 'package:search_ahead/presentation/bloc/home/home_cubit.dart';

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

  sl.registerFactoryParam<ValueNotifierCubit<bool>, bool, void>(
      (bool param1, _) => ValueNotifierCubit<bool>(param1));

  sl.registerFactory<HomeCubit>(() =>
      HomeCubit(sl.get<ISearchRepository>(), sl.get<IFavouriteRepository>()));

  sl.registerSingleton<INetworkClient>(
      DioNetworkClient(BaseNetworkOptions(
        baseUrl: 'https://api.seatgeek.com/2',
      )),
      instanceName: 'SeatGeek');

  sl.registerSingleton<ILocalStorage>(SharedPreferencesStorage());

  sl.registerSingleton<ISeatGeekProvider>(
      SeatGeekProvider(sl.get<INetworkClient>(instanceName: 'SeatGeek')));

  sl.registerSingleton<ISearchRepository>(
      SearchRepository(sl.get<ISeatGeekProvider>()));

  sl.registerSingleton<IFavouriteRepository>(
    FavouriteRepository(sl.get<ILocalStorage>()),
  );

  sl.registerSingleton<Coordinator>(SearchAheadCoordinator());

  sl.registerFactory(() => FavouriteCubit(sl.get<IFavouriteRepository>()));
}
