import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_market/core/config/route_names.dart';
import 'package:stock_market/ui/screens/home_screen.dart';
import 'package:stock_market/ui/screens/news_screen.dart';
import 'package:stock_market/ui/screens/search_screen.dart';
import 'package:stock_market/ui/screens/stock_detail_screen.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.home:
        return CupertinoPageRoute(builder: (_) => const HomeScreen());
      case RouteNames.news:
        return CupertinoPageRoute(builder: (_) => const NewsScreen());
      case RouteNames.searchScreen:
        return CupertinoPageRoute(builder: (_) => SearchScreen());
      case RouteNames.stockDetail:
        final args = settings.arguments as dynamic;
        return CupertinoPageRoute(
          builder: (_) => StockDetailScreen(stock: args),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return CupertinoPageRoute(
      builder:
          (_) => const Scaffold(body: Center(child: Text('Route not found!'))),
    );
  }
}
