import 'package:equatable/equatable.dart';
import 'package:stock_market/data/models/news_model.dart';

abstract class NewsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<CompanyNews> companyNews;

  NewsLoaded(this.companyNews);

  @override
  List<Object?> get props => [companyNews];
}

class NewsError extends NewsState {
  final String message;

  NewsError(this.message);

  @override
  List<Object?> get props => [message];
}
