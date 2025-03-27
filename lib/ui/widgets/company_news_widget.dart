import 'package:flutter/material.dart';
import 'package:stock_market/data/models/news_model.dart';
import 'package:stock_market/ui/widgets/news_tile.dart';

class CompanyNewsWidget extends StatelessWidget {
  final CompanyNews company;

  const CompanyNewsWidget({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            company.company,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children:
                  company.newsList.map((news) => NewsTile(news: news)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
