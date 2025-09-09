import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fix_city/screeens/HomeScreens/My_Reports.dart';
import 'package:fix_city/screeens/HomeScreens/ProfilePage.dart';
import 'package:fix_city/screeens/Reports/Report_screen.dart';
import 'package:fix_city/screeens/bottom/bottomNavigationBar.dart';
import 'package:fix_city/screeens/login/Logins/get_started.dart';
import 'package:fix_city/screeens/login/Logins/login_screen.dart';
import 'package:fix_city/screeens/login/Logins/wrapper_screen.dart';
import 'package:flutter/material.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Firebase App Check initialize karna
  await FirebaseAppCheck.instance.activate(
    // Android ke liye providers (SafetyNet ya PlayIntegrity)
    androidProvider: AndroidProvider.debug,

    // iOS ke liye providers (DeviceCheck ya AppAttest)
    // iosProvider: IOSProvider.deviceCheck,

    // Debug token ke liye (development ke liye)
    // debugToken: 'Yahan apna debug token daalein agar chahiye',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // Sabhi text ke liye default color
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.black), // sabhi normal text red
          bodyLarge: TextStyle(color: Colors.black),
        ),

        // ElevatedButton ke liye default style
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff01720c), // button ka color
            foregroundColor: Colors.white, // text/icon color
            minimumSize: Size(300, 40), // full width default
          ),
        ),
      ),
     routes: {
       '/':(_)=>wrapperScreen(),
       '/login':(_)=>loginScreen(),
       '/createReport':(_)=>createReportScreen(),
       '/profile':(_)=>profileScreen(),
       '/myReports':(_)=>UserReportsScreen(),
       '/bottomNavigation':(_)=>BottomNavigationPage(),
       '/getStarted':(_)=>getStartedpage()

     },
    );
  }
}
