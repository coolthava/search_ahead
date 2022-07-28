import 'package:dartz/dartz.dart';
import 'package:search_ahead/core/api/seatgeek/i_seatgeek_provider.dart';
import 'package:search_ahead/core/model/home/event.dart';
import 'package:search_ahead/core/repository/search/i_search_repository.dart';

class SearchRepository implements ISearchRepository {
  final ISeatGeekProvider _seatGeekProvider;

  SearchRepository(this._seatGeekProvider);

  @override
  Future<Either<Exception, List<Event>>> getEventList(String keyword) async {
    try {
      var res = await _seatGeekProvider.getEventList(keyword);
      return Right(res.toModel().events);
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
