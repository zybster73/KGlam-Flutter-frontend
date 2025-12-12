import 'package:KGlam/View/CustomWidgets/Appointment.dart';
import 'package:KGlam/View/user_side/feedback.dart';
import 'package:KGlam/View/user_side/specificFeedback.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:KGlam/View/user_side/write_Feedback.dart';

class UserAppointmnets extends StatefulWidget {
  final VoidCallback? onBack;
  const UserAppointmnets({super.key, this.onBack});

  @override
  State<UserAppointmnets> createState() => _UserAppointmnetsState();
}

class _UserAppointmnetsState extends State<UserAppointmnets> {
  TextEditingController searchController = TextEditingController();
  int value = 0;

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
                    if (widget.onBack != null) {
                      widget.onBack!();
                    } else {
                      Navigator.pop(context);
                    }
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
                  "Appointment's",
                  style: GoogleFonts.poppins(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  "Explore your completed services and revisit your submitted feedback.",
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF717680),
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: 'Search Appointment',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            color: const Color(0xFF717680),
                          ),
                          prefixIcon: const Icon(
                            Icons.search_outlined,
                            color: Color(0xFF717680),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color(0xFF717680),
                              width: 0.7,
                            ),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color(0xFF01ABAB),
                              width: 1.4,
                            ),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 10.h,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      
                      children: [
                        appointmentCard(
                          imagePath: 'assets/images/Ahair.jpg',
                           title: 'Fresh Hair Cut Make Over :',
                            bookedBy: 'Ubada Zubair',
                             timing: '02 : 10 : 09 AM', 
                             location: "Crown and Canvas"
                             ),
                        appointmentCard(
                          imagePath: 'assets/images/Haircut.jpg',
                          title: "Fresh Hair Cut Make Over :",
                          bookedBy: "Ubada Zubair",
                          timing: "10 : 10 : 09 AM",
                          location: "Crown and Canvas",
                        ),
                        appointmentCard(
                          imagePath: 'assets/images/beard.jpg',
                          title: "Elegant Beard Styling:",
                          bookedBy: "Ubada Zubair",
                          timing: "9 : 30 : 09 PM",
                          location: "Crown and Canvas",
                        ),
                        
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40,)
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
          SizedBox(height: 20.h),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Specificfeedback(
                    image: imagePath,
                    whoBook: bookedBy,
                    time: timing,
                    loc: location,
                    tit: title,
                  ),
                ),
              );
            },
            child: Container(
              height: 48.h,
              decoration: BoxDecoration(
                color: const Color(0xFF01ABAB),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Text(
                  "Your feedback",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
