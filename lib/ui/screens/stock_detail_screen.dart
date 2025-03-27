import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_market/core/constants/color_manager.dart';
import 'package:stock_market/data/models/stock_model.dart';

class StockDetailScreen extends StatelessWidget {
  final List<StockModel> stock;

  const StockDetailScreen({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: Text('US Markets', style: TextStyle(fontSize: 20.sp)),
              subtitle: Text(
                'Secotor Performance',
                style: TextStyle(fontSize: 15.sp),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: stock.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            isDarkMode
                                ? ColorManager.white.withAlpha(30)
                                : Colors.black.withAlpha(30),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                stock[index].type,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Container(
                                width: 80.w,
                                color:
                                    double.parse(stock[index].ltp) > 0
                                        ? Colors.green
                                        : Colors.red,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 3,
                                ),
                                child: Center(
                                  child: Text("+${stock[index].ltp}"),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
