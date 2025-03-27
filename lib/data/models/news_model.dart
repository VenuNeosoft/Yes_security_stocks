class NewsModel {
  final String title;
  final String description;
  final String image;

  NewsModel({
    required this.title,
    required this.description,
    required this.image,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'],
      description: json['description'],
      image: json['image'],
    );
  }
}

class CompanyNews {
  final String company;
  final List<NewsModel> newsList;

  CompanyNews({required this.company, required this.newsList});

  factory CompanyNews.fromJson(Map<String, dynamic> json) {
    var list = json['news_list'] as List;
    List<NewsModel> newsList =
        list.map((news) => NewsModel.fromJson(news)).toList();

    return CompanyNews(company: json['company'], newsList: newsList);
  }
}
