import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_market/core/config/app_routes.dart';
import 'package:stock_market/core/config/route_names.dart';
import 'package:stock_market/core/constants/color_manager.dart';

import 'package:stock_market/ui/blocs/news/news_bloc.dart';
import 'package:stock_market/ui/blocs/stocks/stock_bloc.dart';
import 'package:stock_market/ui/blocs/stocks/stock_event.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NewsBloc()),
        BlocProvider(create: (_) => StockBloc()..add(LoadStocks())),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        builder: (_, __) {
          return AdaptiveTheme(
            light: ThemeData.light(useMaterial3: true).copyWith(
              textTheme: const TextTheme().apply(
                fontFamily: 'Mulish-VariableFont_wght',
                bodyColor: ColorManager.black.withAlpha(200),
                displayColor: ColorManager.black.withAlpha(200),
              ),
            ),
            dark: ThemeData.dark(useMaterial3: true).copyWith(
              textTheme: const TextTheme().apply(
                fontFamily: 'PlayfairDisplay',
                bodyColor: ColorManager.white.withAlpha(200),
                displayColor: ColorManager.white.withAlpha(200),
              ),
            ),
            initial: AdaptiveThemeMode.dark,
            builder:
                (theme, darkTheme) => MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Stock Market',
                  theme: theme,
                  darkTheme: darkTheme,
                  initialRoute: RouteNames.home,
                  onGenerateRoute: AppRoutes.generateRoute,
                ),
          );
        },
      ),
    );
  }
}
