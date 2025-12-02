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
    //ScreenUtil.init(context);

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
                  "View your upcoming, in progress and\ncompleted bookings.",
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
                  child: ListView.builder(
                    itemCount: 3,
                    padding: EdgeInsets.only(bottom: 20.h),
                    itemBuilder: (_, index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 20.h),
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black.withOpacity(0.1),
                            width: 0.4,
                          ),
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
                                index % 2 == 0
                                    ? 'assets/images/Haircut.jpg'
                                    : 'assets/images/beard.jpg',
                                height: 214.h,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              index % 2 == 0
                                  ? "Fresh Hair Cut Make Over :"
                                  : "Elegant Beard Styling :",
                              style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 8.h),

                            Row(
                              children: [
                                const Icon(
                                  Icons.badge,
                                  size: 18,
                                  color: Color(0xFF717680),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  index % 2 == 0
                                      ? "Booked By : Samaan Ashraf"
                                      : "Booked By : Ubada Zubair",
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
                                  Icons.access_time,
                                  size: 18,
                                  color: Color(0xFF717680),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  index % 2 == 0
                                      ? "Timing : 10 : 10 : 09 AM"
                                      : "Timing : 12 : 20 : 20 AM",
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
                                  index % 2 == 0
                                      ? "Location: Crown and Canvas"
                                      : "Location: Crown and Canvas",
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
                                    builder: (context) => WriteFeedback(),
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
                            SizedBox(width: 12.w),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
