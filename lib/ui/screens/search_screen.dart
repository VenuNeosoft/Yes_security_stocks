import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_market/core/config/route_names.dart';
import 'package:stock_market/ui/blocs/stocks/stock_bloc.dart';
import 'package:stock_market/ui/blocs/stocks/stock_state.dart';
import 'package:stock_market/ui/widgets/common_header.dart';
import 'package:stock_market/ui/widgets/stock_tile.dart';
import 'package:stock_market/data/models/stock_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<StockModel> _filteredStocks = [];
  late List<StockModel> _allStocks;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final state = context.read<StockBloc>().state;
    if (state is StockDataLoaded) {
      _allStocks = state.stocks;
      _filteredStocks = _allStocks;
    }
    searchController.addListener(_filterStocks);
  }

  void _filterStocks() {
    final query = searchController.text.toLowerCase();
    setState(() {
      _filteredStocks =
          _allStocks.where((stock) {
            return stock.exchange.toLowerCase().contains(query) ||
                stock.type.toLowerCase().contains(query);
          }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CommonHeader(
              title: 'Search',
              subtitle: 'Search Companies',
              leadingIcon: Icons.arrow_back_ios,
            ),
            _buildSearchBar(),
            Expanded(child: _buildStockList()),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Search Companies...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _buildStockList() {
    return _filteredStocks.isEmpty
        ? const Center(child: Text('No stocks found.'))
        : ListView.builder(
          itemCount: _filteredStocks.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap:
                  () => Navigator.pushNamed(
                    context,
                    RouteNames.searchScreen,
                    arguments: _filteredStocks,
                  ),
              child: StockTile(stock: _filteredStocks[index]),
            );
          },
        );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
