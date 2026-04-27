import 'package:fix_city/core/utils/theme/theme.dart';
import 'package:fix_city/providers/auth_providers.dart';
import 'package:fix_city/providers/create_report_provider.dart';
import 'package:fix_city/providers/profile_provider.dart';
import 'package:fix_city/providers/report_provider.dart';
import 'package:fix_city/providers/submit_providers.dart';
import 'package:fix_city/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ReportProvider()),
        ChangeNotifierProvider(create: (_) => CreateReportProvider()),
        ChangeNotifierProvider(create: (_) => SubmitProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Fix City',
            theme: UAppTheme.lightTheme,
            darkTheme: UAppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            initialRoute: '/',
            routes: AppRoutes.routes,
          );
        },
      ),
    );
  }
}