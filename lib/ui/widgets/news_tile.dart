import 'package:flutter/material.dart';
import 'package:stock_market/core/constants/color_manager.dart';
import 'package:stock_market/data/models/news_model.dart';

class NewsTile extends StatelessWidget {
  final NewsModel news;

  const NewsTile({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: MediaQuery.of(context).size.width / 1.6,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        color:
            isDarkMode ? ColorManager.white.withAlpha(30) : ColorManager.black,
        margin: const EdgeInsets.symmetric(vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                news.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color:
                      isDarkMode
                          ? ColorManager.white.withAlpha(150)
                          : ColorManager.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                news.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: TextStyle(
                  fontSize: 14,
                  color: isDarkMode ? ColorManager.grey : ColorManager.grey,
                ),
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  news.image,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width / 3,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image, size: 100);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
