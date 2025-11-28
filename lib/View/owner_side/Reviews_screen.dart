import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewsScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const ReviewsScreen({super.key, this.onBack});
  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
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
                SizedBox(height: 120.h),

                Text(
                  "Customer Insights",
                  style: GoogleFonts.poppins(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),

                SizedBox(height: 6.h),

                Text(
                  "View your customer insights and what they\nhave talked about you.",
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF717680),
                  ),
                ),

                SizedBox(height: 30.h),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 16.h),
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12, width: 0.4),
                          borderRadius: BorderRadius.circular(16.r),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 30.r,
                                  backgroundImage: AssetImage(
                                    "assets/images/xxx.jpg",
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Muhammad Samaan",
                                      style: GoogleFonts.poppins(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Samaan12@gmail.com",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14.sp,
                                        color: Color(0xFF717680),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            SizedBox(height: 18.h),

                            Text(
                              "Service Taken:",
                              style: GoogleFonts.poppins(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 6.h),

                            Text(
                              "Hair Styling Make Over",
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                color: Color(0xFF717680),
                              ),
                            ),

                            SizedBox(height: 12.h),

                            Text(
                              "Customer Response:",
                              style: GoogleFonts.poppins(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 6.h),

                            Text(
                              "My hair feels healthier, shinier, and perfectly styled with a natural finish. The service was professional, and the overall experience was relaxing and worth every visit.;[p]",
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                color: Color(0xFF717680),
                              ),
                            ),

                            SizedBox(height: 12.h),

                            Text(
                              "Customer Rating:",
                              style: GoogleFonts.poppins(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 6.h),

                            Row(
                              children: List.generate(
                                5,
                                (i) => Icon(
                                  Icons.stars_rounded,
                                  color: Color(0xFFDC6803),
                                ),
                              ),
                            ),
                          
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 40.h,)
              ],
              
            ),
            
          ),
        ],
      ),
    );
  }
}
