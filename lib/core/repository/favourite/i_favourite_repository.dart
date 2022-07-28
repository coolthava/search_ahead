abstract class IFavouriteRepository {
  bool checkIfFavourite(String id);
  List<String> getFavouriteIds();
  void addIdToList(String id);
  void removeIdFromList(String id);
}
