import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:zp_calendar/data/boxes.dart';
import 'package:zp_calendar/data/calendar_model.dart';
import 'package:zp_calendar/ui/create_calendar_event.dart';
import 'package:zp_calendar/ui/menu_page.dart';
import 'package:zp_calendar/navigation/navigation.dart';
import 'package:zp_calendar/ui/onboarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CalendarModelAdapter());
  Hive.registerAdapter(DayIsAdapter());
  await Hive.openBox<CalendarModel>(HiveBoxes.calendar);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(400, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            onGenerateRoute: NavigationApp.generateRoute,
            theme: ThemeData(
                scaffoldBackgroundColor: Color(0xFFDD6565),
                appBarTheme: AppBarTheme(backgroundColor: Colors.transparent)),
            home: Hive.box<CalendarModel>(HiveBoxes.calendar).isEmpty
                ? OnboardingScreen()
                : MenuPage(),
          );
        });
  }
}
