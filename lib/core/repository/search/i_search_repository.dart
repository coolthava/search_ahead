import 'package:dartz/dartz.dart';
import 'package:search_ahead/core/model/home/event.dart';

abstract class ISearchRepository {
  Future<Either<Exception, List<Event>>> getEventList(String keyword);
}
