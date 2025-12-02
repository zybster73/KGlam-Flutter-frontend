import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:KGlam/View/selectRole.dart';

class Onboardingscreen extends StatefulWidget {
  @override
  State<Onboardingscreen> createState() => _OnboardingscreenState();
}

class _OnboardingscreenState extends State<Onboardingscreen> {
  int currentPage = 0;
  PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        onPageChanged: ((index) {
          setState(() {
            currentPage = index;
          });
        }),
        children: [
          Column(
            children: [
              Expanded(
                flex: 6,
                child: Container(
                  // width: MediaQuery.sizeOf(context).width * 0.9,
                  // height: MediaQuery.sizeOf(context).height * 0.70,
                  child: Image.asset(
                    'assets/images/OnBoarding1.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              // Spacer(flex: 1),
              Expanded(
                flex: 2,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '“Beauty ',
                                style: GoogleFonts.poppins(
                                  color: Color(0xFF1E1E1E),
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w800,
                                  height: 1.4,
                                ),
                              ),
                              TextSpan(
                                text: 'Made ',
                                style: GoogleFonts.poppins(
                                  color: Color(0xFF00C2A8),
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w800,
                                  height: 1.4,
                                ),
                              ),
                              TextSpan(
                                text: 'Simple\n',
                                style: GoogleFonts.poppins(
                                  color: Color(0xFF1E1E1E),
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w800,
                                  height: 1.4,
                                ),
                              ),
                              TextSpan(
                                text: 'Wellness Made ',
                                style: GoogleFonts.poppins(
                                  color: Color(0xFF1E1E1E),
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w800,
                                  height: 1.4,
                                ),
                              ),
                              TextSpan(
                                text: 'Essential”',
                                style: GoogleFonts.poppins(
                                  color: Color(0xFF00C2A8),
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w800,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

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
                ),
              ),
              row(),
              Flexible(
                child: ElevatedButton(
                  onPressed: () {
                    if (currentPage < 2) {
                      _controller.nextPage(
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Color(0xFF00C2A8),
                    minimumSize: Size(
                      MediaQuery.sizeOf(context).width * 0.9,
                      48,
                    ),
                  ),
                  child: Text(
                    'Next',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 6,
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  height: MediaQuery.sizeOf(context).height * 0.70,
                  child: Image.asset(
                    'assets/images/OnBoarding2.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                flex: 2,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '“Style That ',
                                style: GoogleFonts.poppins(
                                  color: Color(0xFF1E1E1E),
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w800,
                                  height: 1.4,
                                ),
                              ),
                              TextSpan(
                                text: 'Speaks\n ',
                                style: GoogleFonts.poppins(
                                  color: Color(0xFF00C2A8),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                  height: 1.4,
                                ),
                              ),
                              TextSpan(
                                text: 'Care ',
                                style: GoogleFonts.poppins(
                                  color: Color(0xFF00C2A8),
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w800,
                                  height: 1.4,
                                ),
                              ),
                              TextSpan(
                                text: 'That Comforts” ',
                                style: GoogleFonts.poppins(
                                  color: Color(0xFF1E1E1E),
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w800,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

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
                ),
              ),
              row(),
              Flexible(
                child: ElevatedButton(
                  onPressed: () {
                    if (currentPage < 2) {
                      _controller.nextPage(
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Color(0xFF00C2A8),
                    minimumSize: Size(
                      MediaQuery.sizeOf(context).width * 0.9,
                      48,
                    ),
                  ),
                  child: Text(
                    'Next',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 6,
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  height: MediaQuery.sizeOf(context).height * 0.70,
                  child: Image.asset(
                    'assets/images/OnBoarding3.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                flex: 2,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '“Designed ',
                                style: GoogleFonts.poppins(
                                  color: Color(0xFF00C2A8),
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w800,
                                  height: 1.4,
                                ),
                              ),
                              TextSpan(
                                text: 'To Beautify\n ',
                                style: GoogleFonts.poppins(
                                  color: Color(0xFF1E1E1E),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                  height: 1.4,
                                ),
                              ),
                              TextSpan(
                                text: 'Devoted To ',
                                style: GoogleFonts.poppins(
                                  color: Color(0xFF1E1E1E),
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w800,
                                  height: 1.4,
                                ),
                              ),
                              TextSpan(
                                text: 'Nourish” ',
                                style: GoogleFonts.poppins(
                                  color: Color(0xFF00C2A8),
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w800,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

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
                ),
              ),
              row(),

              // SizedBox(
              //   height: 20,
              // ),
              Flexible(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SelectRole()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Color(0xFF00C2A8),
                    minimumSize: Size(
                      MediaQuery.sizeOf(context).width * 0.9,
                      48,
                    ),
                  ),
                  child: Text(
                    'Get Started',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget row() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 60),
        currentPage == 0
            ? Icon(
                Icons.circle,
                size: 12,
                color: Color(0xFF00C2A8),
              )
            : Icon(Icons.circle_outlined, size: 12, color: Color(0xFF4F4F4F)),
         SizedBox(width: 8),
        currentPage == 1
            ? Icon(
                Icons.circle,
                size: 12,
                color: Color(0xFF00C2A8),
              )
            : Icon(Icons.circle_outlined, size: 12, color: Color(0xFF4F4F4F)),
         SizedBox(width: 8),
        currentPage == 2
            ? Icon(
                Icons.circle,
                size: 12,
                color: Color(0xFF00C2A8),
              )
            : Icon(Icons.circle_outlined, size: 12, color: Color(0xFF4F4F4F)),
      ],
    );
  }
}
