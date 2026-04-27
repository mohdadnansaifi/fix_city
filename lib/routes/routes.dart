import 'package:flutter/cupertino.dart';

import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/wrapper_screen.dart';
import '../features/bottom_navigation_bar.dart';
import '../features/complaints/screens/create_report_screen.dart';
import '../features/complaints/screens/submit_screen.dart';
import '../features/notifications/notification_screen.dart';
import '../features/onboarding/screens/get_started.dart';
import '../features/profile/screens/ProfilePage.dart';
import '../features/profile/screens/edit_profile.dart';
import '../features/reports/screens/My_Reports.dart';

class AppRoutes {
  // 🔹 Route names
  static const String login = '/login';
  static const String home = '/';
  static const String createReport = '/createReport';
  static const String profile = '/profile';
  static const String myReports = '/myReports';
  static const String bottomNav = '/bottomNavigation';
  static const String getStarted = '/getStarted';
  static const String submit = '/submit'; // ✅ add this (you use it)
  static const String editProfile = '/editProfile';
  static const notification =
      '/notification';
  // static const String settings = '/settings';
  // static const String helpFeedback = '/helpFeedback';



  // 🔹 Route map
  static final routes = {
    home: (context) => const WrapperScreen(),
    login: (context) => const LoginScreen(),
    createReport: (context) => const CreateReportScreen(),
    profile: (context) => ProfileScreen(),
    myReports: (context) => const UserReportsScreen(),
    bottomNav: (context) => const BottomNavigationPage(),
    getStarted: (context) => const GetStartedScreen(),
    editProfile: (context) => const EditProfileScreen(),
    notification: (context) =>
    const NotificationScreen(),


    /// ✅ FIX: Submit screen needs arguments
    submit: (context) {
      final args =
      ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      return SubmitScreen(
        address: args['address'],
        photoPath: args['photoPath'],
        latitude: args['latitude'],
        longitude: args['longitude'],
      );
    },
  };
}