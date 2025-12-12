import 'package:KGlam/View/CustomWidgets/Appointment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Specificfeedback extends StatefulWidget {
  final String image;
  final String whoBook;
  final String time;
  final String loc;
  final String tit;

  const Specificfeedback({
    required this.image,
    required this.whoBook,
    required this.time,
    required this.loc,
    required this.tit,
    super.key,
  });

  @override
  State<Specificfeedback> createState() => _SpecificfeedbackState();
}

class _SpecificfeedbackState extends State<Specificfeedback> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: -0.05 * screenHeight,
            left: -10,
            child: Image.asset(
              'assets/images/Eclipse2.png',
              fit: BoxFit.contain,
              height: screenHeight * 0.35,
              width: screenWidth * 0.9,
            ),
          ),
          Positioned(
            top: 50.h,
            left: 20.w,
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Color(0xFF01ABAB),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  iconSize: 18,
                  padding: EdgeInsets.zero,
                  color: Colors.white,
                  icon: Icon(Icons.arrow_back_ios_sharp),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 115.h),
                Text(
                  "Your Feedback's",
                  style: GoogleFonts.poppins(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  "Review the feedback you have shared on your completed bookings.",
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF717680),
                  ),
                ),
                SizedBox(height: 20.h),

                SizedBox(height: 25.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        appointmentCard(
                          imagePath: widget.image,
                          title: widget.tit,
                          bookedBy: widget.whoBook,
                          timing: widget.time,
                          location: widget.loc,
                          feedback:
                              'I got my hairstyle done at Canvas Saloon — the result was amazing! The staff is very professional and the atmosphere is relaxing. I’ll definitely come back again. ⭐⭐⭐⭐⭐',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget appointmentCard({
    required String imagePath,
    required String title,
    required String bookedBy,
    required String timing,
    required String location,
    required String feedback,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Colors.white,
        border: Border.all(color: Colors.black.withOpacity(0.1), width: 0.4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.asset(
              imagePath,
              height: 214.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              const Icon(Icons.badge, size: 18, color: Color(0xFF717680)),
              SizedBox(width: 8.w),
              Text(
                "Booked By : $bookedBy",
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: const Color(0xFF717680),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              const Icon(Icons.access_time, size: 18, color: Color(0xFF717680)),
              SizedBox(width: 8.w),
              Text(
                "Timing : $timing",
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: const Color(0xFF717680),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              const Icon(
                Icons.location_on_rounded,
                size: 18,
                color: Color(0xFF717680),
              ),
              SizedBox(width: 8.w),
              Text(
                "Location: $location",
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: const Color(0xFF717680),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            'Your Feedback: ',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          Text(
            feedback,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              color: const Color(0xFF717680),
            ),
          ),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
