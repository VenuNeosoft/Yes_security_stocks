import 'package:stock_market/data/models/stock_model.dart';
import 'package:stock_market/data/local_data/dummy_data.dart';

class StockRepository {
  Future<List<StockModel>> getStocks() async {
    await Future.delayed(const Duration(seconds: 1));
    return dummyStocks.map((json) => StockModel.fromJson(json)).toList();
  }
}
