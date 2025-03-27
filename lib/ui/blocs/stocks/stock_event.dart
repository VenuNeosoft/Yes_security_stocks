import 'package:equatable/equatable.dart';

abstract class StockEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadStocks extends StockEvent {}

class UpdateStockPrice extends StockEvent {
  final Map<String, dynamic> data;

  UpdateStockPrice(this.data);

  @override
  List<Object?> get props => [data];
}

class ConnectToWebSocket extends StockEvent {}

class UpdateStockData extends StockEvent {
  final String niftyData;
  final String sensexData;

  UpdateStockData({required this.niftyData, required this.sensexData});

  @override
  List<Object?> get props => [niftyData, sensexData];
}

class ToggleTheme extends StockEvent {
  final bool isDarkMode;
  ToggleTheme({required this.isDarkMode});

  @override
  List<Object?> get props => [isDarkMode];
}
