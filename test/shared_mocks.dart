import 'package:mockito/annotations.dart';
import 'package:search_ahead/core/api/seatgeek/i_seatgeek_provider.dart';
import 'package:search_ahead/core/common/utils/localstorage/i_local_storage.dart';
import 'package:search_ahead/core/model/home/event.dart';
import 'package:search_ahead/core/repository/favourite/i_favourite_repository.dart';
import 'package:search_ahead/core/repository/search/i_search_repository.dart';

@GenerateMocks([
  IFavouriteRepository,
  ILocalStorage,
  ISearchRepository,
  ISeatGeekProvider,
  Event,
  Venue,
  Performer,
])
void main() {}
