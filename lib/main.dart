import 'package:KGlam/Services/auth_Provider.dart';
import 'package:KGlam/Services/clientApi.dart';
import 'package:KGlam/Services/notificationServices.dart';
import 'package:KGlam/Services/salon_Api_provider.dart';
import 'package:KGlam/Services/validations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:KGlam/View/splashScreen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDAMPUmLE9OpOSQJBxNqC5PPg6YtCQYVKg",
      appId: "1:1014210091536:android:b50ea0d11bf3e22035c895",
      messagingSenderId: "1014210091536",
      projectId: "ksmart-hub",
    ),
  );

  print(app.name + "Firebase connected");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => SalonApiProvider()),
        ChangeNotifierProvider(create: (_) => Validations()),
        ChangeNotifierProvider(create: (_) => client_Api()),
        ChangeNotifierProvider(create: (_) => Notificationservices()),
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
