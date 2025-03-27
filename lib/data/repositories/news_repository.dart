import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:stock_market/data/models/news_model.dart';

class NewsRepository {
  Future<List<CompanyNews>> getCompanyNews() async {
    final String response = await rootBundle.loadString(
      'assets/news_data.json',
    );
    final data = json.decode(response);
    List<dynamic> newsList = data['news'];

    return newsList.map((newsItem) => CompanyNews.fromJson(newsItem)).toList();
  }
}
