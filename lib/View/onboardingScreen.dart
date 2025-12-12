import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:KGlam/View/selectRole.dart';

class Onboardingscreen extends StatefulWidget {
  @override
  State<Onboardingscreen> createState() => _OnboardingscreenState();
}

class _OnboardingscreenState extends State<Onboardingscreen> {
  int currentPage = 0;
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          
          Flexible(
            child: PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              children: [
                page1(),
                page2(),
                page3(),
              ],
            ),
          ),
          row(),

          SizedBox(height: 16),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: currentPage == 2
                ? buildGetStartedButton()
                : buildNextButton(),
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget page1() {
    return Column(
      children: [
        Expanded(
          flex: 7,
          child: Image.asset(
            'assets/images/OnBoarding1.png',
            fit: BoxFit.contain,
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    spanBlack('“Beauty '),
                    spanTeal('Made '),
                    spanBlack('Simple\n'),
                    spanBlack('Wellness Made '),
                    spanTeal('Essential”'),
                  ],
                ),
              ),
              // SizedBox(height: 12),
              Text(
                'Transform Your Look,Transform Your \nLife,Your Ultimate Desire Awaits Here.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Color(0xFF4F4F4F),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget page2() {
    return Column(
      children: [
        Expanded(
          flex: 7,
          child: Image.asset(
            'assets/images/OnBoarding2.png',
            fit: BoxFit.contain,
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    spanBlack('“Style That '),
                    spanTeal('Speaks\n'),
                    spanTeal('Care '),
                    spanBlack('That Comforts”'),
                  ],
                ),
              ),
              // SizedBox(height: 12),
              Text(
                'Elegance elevates touch, while\n confidence empowers every look.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Color(0xFF4F4F4F),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget page3() {
    return Column(
      children: [
        Expanded(
          flex: 7,
          child: Image.asset(
            'assets/images/OnBoarding3.png',
            fit: BoxFit.contain,
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    spanTeal('“Designed '),
                    spanBlack('To Beautify\n'),
                    spanBlack('Devoted To '),
                    spanTeal('Nourish”'),
                  ],
                ),
              ),
              // SizedBox(height: 12),
              Text(
                'Where beauty meets nourishment,\n designed to empower your glow day.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Color(0xFF4F4F4F),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget row() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        indicator(0),
        SizedBox(width: 8),
        indicator(1),
        SizedBox(width: 8),
        indicator(2),
      ],
    );
  }

  Widget indicator(int index) {
    return Icon(
      currentPage == index ? Icons.circle : Icons.circle_outlined,
      size: 12,
      color: currentPage == index
          ? Color(0xFF01ABAB)
          : Color(0xFF4F4F4F),
    );
  }

  Widget buildNextButton() {
    return ElevatedButton(
      onPressed: () {
        _controller.nextPage(
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF01ABAB),
        minimumSize: Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        'Next',
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget buildGetStartedButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => SelectRole()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF01ABAB),
        minimumSize: Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        'Get Started',
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
  TextSpan spanBlack(String text) => TextSpan(
        text: text,
        style: GoogleFonts.poppins(
          color: Color(0xFF1E1E1E),
          fontSize: 24.sp,
          fontWeight: FontWeight.w800,
          height: 1.4,
        ),
      );

  TextSpan spanTeal(String text) => TextSpan(
        text: text,
        style: GoogleFonts.poppins(
          color: Color(0xFF01ABAB),
          fontSize: 24.sp,
          fontWeight: FontWeight.w800,
          height: 1.4,
        ),
      );
}
