import 'package:bloc/bloc.dart';
import 'package:movie_app/search/domain/use_case/get_movie_search_use_case.dart';
import 'package:movie_app/search/presentation/controller/search_events.dart';

import 'package:movie_app/search/presentation/controller/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetSearchMoviesUseCase getSearchMoviesUseCase;

  SearchBloc(this.getSearchMoviesUseCase) : super(SearchInitial()) {
    on<SearchMoviesQueryChanged>(_onSearchMoviesQueryChanged);
    on<ClearSearchResults>(_onClearSearchResults);
  }

  void _onClearSearchResults(
    ClearSearchResults event,
    Emitter<SearchState> emit,
  ) {
    emit(SearchInitial());
  }

  void _onSearchMoviesQueryChanged(
    SearchMoviesQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.isEmpty) {
      emit(SearchInitial());
      return;
    }
    emit(SearchLoading());

    final result = await getSearchMoviesUseCase(SearchMoviesParams(
      query: event.query,
    ));
    result.fold(
      (failure) => emit(
        SearchMoviesError(failure.errMessage),
      ),
      (result) => emit(SearchMoviesSuccess(result)),
    );
  }
}