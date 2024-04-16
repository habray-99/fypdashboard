import 'package:flutter/material.dart';
import 'package:fypdashboard/routes/route.dart';
import 'package:fypdashboard/utils/colors.dart';
import 'package:fypdashboard/views/auth/log_out_page.dart';

import 'package:fypdashboard/views/splash_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'controller/core_controller.dart';
import 'views/dashboard/gymowner/gym_page.dart';
import 'views/dashboard/gymowner/home_page.dart';
import 'views/dashboard/gymowner/members.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // navigatorKey: navigatorKey,
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ne', 'NP'),
      ],
      // localizationsDelegates: const [
      //   KhaltiLocalizations.delegate,
      // ],
      debugShowCheckedModeBanner: true,
      title: 'My project',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.secondaryColor),
        useMaterial3: true,
        textTheme: GoogleFonts.sourceSans3TextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(CoreController());
      }),
      // home: SplashScreen(),
      getPages: [
        
        GetPage(
          name: AppRoutes.homePage,
          page: () => const HomePage(),
        ),
        GetPage(
          name: AppRoutes.memberTable,
          page: () => const DataTablePage(),
        ),
        GetPage(
          name: AppRoutes.logOutPage,
          page: () => const LogOutPage(),
        ),
        GetPage(
          name: AppRoutes.gymPage,
          page: () => GymPage(),
        ),
      ],
      home: SplashScreen(),
    );
  }
}
