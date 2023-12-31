import 'package:dartz/dartz.dart';
import 'package:movie_app/di/di.dart';
import '../../utils/api_exeption.dart';
import '../datasource/TopDatasources/getSeason_datasource.dart';
import '../model/getTop/Anime/Anime.dart';

abstract class IgetSeasonRepository {
  Future<Either<String, Anime>> getSeasonNow();
}

class GetSeasonRemote extends IgetSeasonRepository {
  final IgetSeasonsDatasource _datasource = locator.get();
  @override
  Future<Either<String, Anime>> getSeasonNow() async {
    try {
      var response = await _datasource.getSeasonNow();
      return right(response);
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
