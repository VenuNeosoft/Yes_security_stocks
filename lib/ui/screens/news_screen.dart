import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_market/core/constants/app_constants.dart';
import 'package:stock_market/core/error_handling/app_error_widget.dart';
import 'package:stock_market/ui/blocs/news/news_bloc.dart';
import 'package:stock_market/ui/blocs/news/news_event.dart';
import 'package:stock_market/ui/blocs/news/news_state.dart';
import 'package:stock_market/ui/widgets/common_header.dart';
import 'package:stock_market/ui/widgets/company_news_widget.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NewsBloc>().add(LoadNews());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NewsLoaded) {
            return SafeArea(
              child: Column(
                children: [
                  CommonHeader(
                    title: AppConstants.latestNewsTitle,
                    subtitle: AppConstants.portfolioRelated,
                    leadingIcon: Icons.arrow_back_ios,
                  ),

                  Expanded(
                    child: ListView.builder(
                      itemCount: state.companyNews.length,
                      itemBuilder: (context, index) {
                        final company = state.companyNews[index];
                        return CompanyNewsWidget(company: company);
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is NewsError) {
            return AppErrorWidget(message: state.message);
          } else {
            return const Center(child: Text(AppConstants.noNewsAvailable));
          }
        },
      ),
    );
  }
}
