import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:movie_app/bloc/search/search_event.dart';
import 'package:movie_app/bloc/search/search_state.dart';
import 'package:movie_app/data/repository/getRecommendation_repository.dart';
import 'package:movie_app/data/repository/getTopAnime_repository.dart';
import 'package:movie_app/data/repository/search_repository.dart';
import 'package:movie_app/di/di.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final IgetRecomRepository _igetRecomRepository = locator.get();
  final IgetTopAnimeRepository _animeRepository = locator.get();
  final IsearchRepository _isearchRepository = locator.get();
  SearchBloc() : super(SearchInitState()) {
    on<SearchInitEvent>(
      (event, emit) async {
        emit(SearchLoadingState());
        var getRecom = await _igetRecomRepository.getRecome();
        var getUpcommingSeasons = await _animeRepository.getUpcommingSeasons();

        emit(SearchSuccessResponse(getRecom, getUpcommingSeasons));
      },
    );
    on<SearchResult>(
      (event, emit) async {
        var searchByWord = await _isearchRepository.searchAnime(event.word);
        emit(SearchResultState(searchByWord));
      },
    );
  }
}
