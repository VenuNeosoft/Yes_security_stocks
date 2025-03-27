import 'package:flutter/material.dart';
import 'package:stock_market/core/constants/color_manager.dart';

class AppErrorWidget extends StatelessWidget {
  final String message;

  const AppErrorWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ColorManager.error,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
