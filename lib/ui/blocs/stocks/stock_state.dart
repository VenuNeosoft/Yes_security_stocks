import 'package:equatable/equatable.dart';
import 'package:stock_market/data/models/stock_model.dart';

abstract class StockState extends Equatable {
  @override
  List<Object?> get props => [];
}

class StockInitial extends StockState {}

class StockLoading extends StockState {}

class StockDataLoaded extends StockState {
  final List<StockModel> stocks;
  final String? niftyData;
  final String? sensexData;
  final bool isDarkMode;

  StockDataLoaded({
    required this.stocks,
    this.niftyData,
    this.sensexData,
    required this.isDarkMode,
  });

  @override
  List<Object?> get props => [stocks, niftyData, sensexData, isDarkMode];
}

class StockError extends StockState {
  final String message;

  StockError(this.message);

  @override
  List<Object?> get props => [message];
}
