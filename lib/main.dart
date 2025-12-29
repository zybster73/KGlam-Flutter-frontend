import 'package:KGlam/Services/auth_Provider.dart';
import 'package:KGlam/Services/salon_Api_provider.dart';
import 'package:KGlam/Services/validations.dart';
import 'package:KGlam/View/Login%20&%20signup/saloon_information.dart';
import 'package:KGlam/View/Login%20&%20signup/service_inforamtion.dart';
import 'package:KGlam/View/Login%20&%20signup/verifyEmail.dart';
import 'package:KGlam/View/user_side/UserNavigationBar.dart';
import 'package:KGlam/View/user_side/user_appointmnets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:KGlam/View/splashScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => SalonApiProvider()),
        ChangeNotifierProvider(create: (_) => Validations()),
        ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: .fromSeed(seedColor: Colors.deepPurple),
          ),
          home: splash_screen(),
        );
      },
    );
  }
}
