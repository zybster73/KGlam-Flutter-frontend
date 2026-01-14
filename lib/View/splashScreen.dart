import 'package:KGlam/Services/notificationServices.dart';
import 'package:KGlam/View/CustomWidgets/CustomNavigationBar.dart';
import 'package:KGlam/View/CustomWidgets/helperClass.dart';
import 'package:KGlam/View/Login%20&%20signup/Login_screen.dart';
import 'package:KGlam/View/selectRole.dart';
import 'package:KGlam/View/user_side/UserNavigationBar.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:KGlam/View/onboardingScreen.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({super.key});

  @override
  State<splash_screen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<splash_screen>
    with SingleTickerProviderStateMixin {
  Notificationservices notificationservices = Notificationservices();
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    notificationservices.requestNotificationPermissions();
    _navigateNext();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();
  }

  void _navigateNext() async {
    await Future.delayed(Duration(seconds: 3));
    bool hasSeenOnboarding = await Prefs.getBool(Prefs.onboarding);
   
    String? role = await Prefs.getRole();
    
    bool isLoggedIn = await Prefs.getBool(Prefs.loggedIn);
    

    Widget nextScreen;

    if (!hasSeenOnboarding) {
      print(hasSeenOnboarding);
      nextScreen = Onboardingscreen();
    } else if (role == null) {
      print(role);
      nextScreen = SelectRole();
    } else if (!isLoggedIn) {
      print(isLoggedIn);
      nextScreen = LoginScreen(index: role);
    } else {
      nextScreen = role == 'owner'
          ? CustomNavigationBar()
          : Usernavigationbar();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => nextScreen),
    );
     print(hasSeenOnboarding);
     print(role);
     print(isLoggedIn);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.5,
              height: MediaQuery.sizeOf(context).height * 0.5,
              child: Image.asset(
                'assets/images/Saloon_logo.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
