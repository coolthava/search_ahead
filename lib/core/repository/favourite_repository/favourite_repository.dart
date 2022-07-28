import 'package:search_ahead/core/common/utils/localstorage/i_local_storage.dart';
import 'package:search_ahead/core/repository/favourite_repository/i_favourite_repository.dart';

class FavouriteRepository extends IFavouriteRepository {
  final ILocalStorage _localStorage;

  FavouriteRepository(this._localStorage);

  final String idKey = 'id_list';
  List<String>? idCache;

  @override
  bool checkIfFavourite(String id) {
    return getFavouriteIds().contains(id);
  }

  @override
  List<String> getFavouriteIds() {
    idCache ??= _localStorage.getStringList(idKey);
    return idCache!;
  }

  @override
  void addIdToList(String id) {
    getFavouriteIds().add(id);
    _localStorage.putStringList(idKey, idCache!);
  }

  @override
  void removeIdFromList(String id) {
    getFavouriteIds().remove(id);
    _localStorage.putStringList(idKey, idCache!);
  }
}
