import 'package:dio/dio.dart';
import 'package:movie_app/data/model/Anime/getAnimeCharacterById/GetAnimeCharacterById.dart';

import '../../di/di.dart';
import '../../utils/api_exeption.dart';
import '../model/Anime/getAnimeEpisodes/GetAnimeEpisodes.dart';

abstract class IgetAnimeDetailsDatasource {
  Future<GetAnimeCharacterById> getAnimeCharacterById(int mal_id);
  Future<GetAnimeEpisodes> getAnimeEpisodesById(int mal_id, int episodes);
}

class GetAnimeDetailsDatasource extends IgetAnimeDetailsDatasource {
  @override
  final Dio _dio = locator.get();
  Future<GetAnimeCharacterById> getAnimeCharacterById(int mal_id) async {
    final response = await _dio.get('anime/$mal_id/characters');
    try {
      return GetAnimeCharacterById.fromJson(response.data);
    } on DioError catch (ex) {
      throw ApiExeption(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw ApiExeption('unknown error happend', 0);
    }
  }

  @override
  Future<GetAnimeEpisodes> getAnimeEpisodesById(
      int mal_id, int episodes) async {
    final response = await _dio.get('anime/$mal_id/episodes/$episodes');

    try {
      return GetAnimeEpisodes.fromJson(response.data);
    } on DioError catch (ex) {
      throw ApiExeption(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw ApiExeption('unknown error happend', 0);
    }
  }
}