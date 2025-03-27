import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_market/core/constants/color_manager.dart';

class WebSocketStockTile extends StatelessWidget {
  final String title;
  final String data;

  const WebSocketStockTile({
    super.key,
    required this.title,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    List<String> values = data.split('|');
    if (kDebugMode) {
      print(values);
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          decoration: BoxDecoration(
            color:
                isDarkMode
                    ? Colors.white.withAlpha(30)
                    : Colors.black.withAlpha(30),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 10.h),
              values.length < 14
                  ? Text(
                    'Data not available',
                    style: TextStyle(fontSize: 14, color: Colors.red),
                  )
                  : Row(
                    children: [
                      Text(
                        '₹ ${values[2].isEmpty ? '0.00' : values[2].formatToThreeDecimalPlaces()}',
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        ' ${values[11].isEmpty ? '00.00' : values[11].formatToThreeDecimalPlaces()} (${values[13].isNotEmpty && values[13] == '-' || values[13] == '+' ? values[13] : '+'} ${values[7].isEmpty ? '0.00' : values[7].formatToThreeDecimalPlaces()})',
                        style: TextStyle(
                          color:
                              values[13] == '-'
                                  ? ColorManager.error
                                  : ColorManager.green,
                        ),
                      ),
                    ],
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String formatToThreeDecimalPlaces() {
    final double? value = double.tryParse(this);
    if (value != null) {
      return value.toStringAsFixed(2);
    }
    return this;
  }
}
