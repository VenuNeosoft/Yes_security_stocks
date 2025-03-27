import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_market/data/models/stock_model.dart';
import 'package:stock_market/data/repositories/stock_repository.dart';
import 'package:stock_market/data/services/web_socket_service.dart';
import 'package:stock_market/ui/blocs/stocks/stock_event.dart';
import 'package:stock_market/ui/blocs/stocks/stock_state.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  final StockRepository _stockRepository = StockRepository();
  final WebSocketService _webSocketService = WebSocketService();
  StreamSubscription? _webSocketSubscription;

  String? _niftyData;
  String? _sensexData;
  List<StockModel> _stocks = [];
  bool _isDarkMode = false;

  StockBloc() : super(StockInitial()) {
    on<LoadStocks>(_onLoadStocks);
    on<ConnectToWebSocket>(_onConnectToWebSocket);
    on<UpdateStockData>(_onUpdateStockData);
    on<ToggleTheme>(_onToggleTheme);
  }

  Future<void> _onLoadStocks(LoadStocks event, Emitter<StockState> emit) async {
    emit(StockLoading());
    try {
      _stocks = await _stockRepository.getStocks();
      emit(
        StockDataLoaded(
          stocks: _stocks,
          niftyData: _niftyData,
          sensexData: _sensexData,
          isDarkMode: _isDarkMode,
        ),
      );
    } catch (e) {
      emit(StockError("Failed to load stocks"));
    }
  }

  void _onConnectToWebSocket(
    ConnectToWebSocket event,
    Emitter<StockState> emit,
  ) {
    List<String> stocks = ["Nifty50", "BSEIDX_1"];
    _webSocketService.subscribeToStocks(stocks);

    _webSocketSubscription = _webSocketService.getStream().listen((data) {
      if (data.contains('NSEIDX')) {
        _niftyData = data;
      } else if (data.contains('BSEIDX')) {
        _sensexData = data;
      }
      add(
        UpdateStockData(
          niftyData: _niftyData ?? 'Loading...',
          sensexData: _sensexData ?? 'Loading...',
        ),
      );
    });
  }

  void _onUpdateStockData(UpdateStockData event, Emitter<StockState> emit) {
    if (state is StockDataLoaded) {
      final currentState = state as StockDataLoaded;
      emit(
        StockDataLoaded(
          stocks: currentState.stocks,
          niftyData: event.niftyData,
          sensexData: event.sensexData,
          isDarkMode: currentState.isDarkMode,
        ),
      );
    }
  }

  void _onToggleTheme(ToggleTheme event, Emitter<StockState> emit) {
    _isDarkMode = event.isDarkMode;
    if (state is StockDataLoaded) {
      final currentState = state as StockDataLoaded;
      emit(
        StockDataLoaded(
          stocks: currentState.stocks,
          niftyData: currentState.niftyData,
          sensexData: currentState.sensexData,
          isDarkMode: _isDarkMode,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _webSocketSubscription?.cancel();
    _webSocketService.closeConnection();
    return super.close();
  }
}
