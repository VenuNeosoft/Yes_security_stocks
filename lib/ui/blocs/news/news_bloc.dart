import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_market/ui/blocs/news/news_event.dart';
import 'package:stock_market/ui/blocs/news/news_state.dart';

import 'package:stock_market/data/repositories/news_repository.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository _newsRepository = NewsRepository();

  NewsBloc() : super(NewsInitial()) {
    on<LoadNews>(_onLoadNews);
  }

  Future<void> _onLoadNews(LoadNews event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    try {
      final companyNews = await _newsRepository.getCompanyNews();
      emit(NewsLoaded(companyNews));
    } catch (e) {
      emit(NewsError("Failed to load news"));
    }
  }
}
