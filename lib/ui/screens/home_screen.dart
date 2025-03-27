import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_market/core/config/route_names.dart';
import 'package:stock_market/core/constants/app_constants.dart';
import 'package:stock_market/core/error_handling/app_error_widget.dart';
import 'package:stock_market/ui/blocs/stocks/stock_bloc.dart';
import 'package:stock_market/ui/blocs/stocks/stock_event.dart';
import 'package:stock_market/ui/blocs/stocks/stock_state.dart';

import 'package:stock_market/ui/widgets/stock_tile.dart';
import 'package:stock_market/ui/widgets/websocket_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AdaptiveThemeMode themeMode;

  @override
  void initState() {
    super.initState();
    context.read<StockBloc>().add(LoadStocks());
    context.read<StockBloc>().add(ConnectToWebSocket());

    AdaptiveTheme.getThemeMode().then((mode) {
      setState(() {
        themeMode = mode ?? AdaptiveThemeMode.light;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<StockBloc, StockState>(
        builder: (context, state) {
          if (state is StockLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is StockDataLoaded) {
            return SafeArea(
              child: Column(
                children: [
                  _buildHeader(context),
                  _buildMarketDataRow(state),
                  _buildStockList(state),
                ],
              ),
            );
          } else if (state is StockError) {
            return AppErrorWidget(message: state.message);
          } else {
            return AppErrorWidget(message: AppConstants.failedToLoad);
          }
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppConstants.portfolioTitle,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              Text(
                AppConstants.portfolioSubtitle,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),

          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.searchScreen);
                },
              ),

              IconButton(
                icon: const Icon(Icons.person_2_outlined),
                color: Theme.of(context).iconTheme.color,
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.news);
                },
              ),

              IconButton(
                icon: Icon(
                  isDarkMode ? Icons.dark_mode : Icons.light_mode,
                  color: Theme.of(context).iconTheme.color,
                ),
                onPressed: () => _toggleTheme(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _toggleTheme() {
    if (themeMode == AdaptiveThemeMode.light) {
      AdaptiveTheme.of(context).setDark();
      context.read<StockBloc>().add(ToggleTheme(isDarkMode: true));
      setState(() => themeMode = AdaptiveThemeMode.dark);
    } else {
      AdaptiveTheme.of(context).setLight();
      context.read<StockBloc>().add(ToggleTheme(isDarkMode: false));
      setState(() => themeMode = AdaptiveThemeMode.light);
    }
  }

  Widget _buildMarketDataRow(StockDataLoaded state) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          WebSocketStockTile(
            title: AppConstants.nifty50,
            data: state.niftyData ?? "Loading...",
          ),
          WebSocketStockTile(
            title: AppConstants.sensex,
            data: state.sensexData ?? 'Loading...',
          ),
        ],
      ),
    );
  }

  Widget _buildStockList(StockDataLoaded state) {
    return Expanded(
      child: ListView.builder(
        itemCount: state.stocks.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap:
                () => Navigator.pushNamed(
                  context,
                  RouteNames.stockDetail,
                  arguments: state.stocks,
                ),
            child: StockTile(stock: state.stocks[index]),
          );
        },
      ),
    );
  }
}
