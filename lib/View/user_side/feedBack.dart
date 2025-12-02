import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:KGlam/View/user_side/Saloon_Details.dart';
import 'package:KGlam/View/user_side/UserNavigationBar.dart';
import 'package:KGlam/View/user_side/customerHomescreen.dart';

class Feedbackscreen extends StatefulWidget {
  const Feedbackscreen({super.key});

  @override
  State<Feedbackscreen> createState() => _FeedbackscreenState();
}

class _FeedbackscreenState extends State<Feedbackscreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return PopScope(
      canPop: false, 
      onPopInvoked: (didPop) {
        
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => Usernavigationbar()),
          (route) => false,
        );
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 250.h,
                child: Stack(
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
                      top: 40,
                      left: 16,
                      child: CircleAvatar(
                        radius: 16.r,
                        backgroundColor: Color(0xFF01ABAB),
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                            size: 14,
                          ),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Usernavigationbar(),
                              ),
                              ModalRoute.withName('/'),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 90.h,
                        left: 15.w,
                        right: 20.w,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Feedback',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'View your feedback and completed appointments.',
                                  style: GoogleFonts.poppins(
                                    fontSize: 13.sp,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
      
                    Positioned(
                      top: 170.h,
                      left: 20.w,
                      right: 20.w,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                             // controller: searchController,
                              decoration: InputDecoration(
                                hintText: 'Search Saloon and Services',
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
      
                          //SizedBox(width: 12.w),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      
              /// APPOINTMENTS LIST
              Column(
                children: [
                  _buildappointmantCard(
                    'Fresh Hair Cut Make Over :',
                    'assets/images/Ahair.jpg',
                    '05:00 PM, Monday',
                    'Abdullah Khan',
                    'Crown and Canvas',
                    'I got my hairstyle done at Canvas Salon — the result was amazing! The staff is very professional and the atmosphere is relaxing. I’ll definitely come back again. ⭐⭐⭐⭐⭐',
                  ),
      
                  SizedBox(height: 10.h),
      
                  _buildappointmantCard(
                    'Fresh Hair Cut Make Over :',
                    'assets/images/Ahair.jpg',
                    '05:00 PM, Monday',
                    'Abdullah Khan',
                    'Crown and Canvas',
                    'I got my hairstyle done at Canvas Salon — the result was amazing! The staff is very professional and the atmosphere is relaxing. I’ll definitely come back again. ⭐⭐⭐⭐⭐',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildappointmantCard(
    String title,
    String image,
    String timing,
    String bookedby,
    String locationsaloon,
    String feedback,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            //height: 400,
            width: 350.w,
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(color: Colors.grey.shade400),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 6.r,
                  spreadRadius: 3.r,
                ),
              ],
            ),
    
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 215.h,
                  width: 322.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
    
                SizedBox(height: 10.h),
    
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
    
                SizedBox(height: 8.h),
    
                Row(
                  children: [
                    Image(image: AssetImage('assets/images/book.png')),
                    SizedBox(width: 5.w),
                    Text(
                      'Booked by:',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Expanded(
                      child: Text(
                        bookedby,
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
    
                SizedBox(height: 8.h),
    
                /// TIME
                Row(
                  children: [
                    Image(image: AssetImage('assets/images/greyclock.png')),
                    SizedBox(width: 5.w),
                    Text(
                      'Timing:',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Expanded(
                      child: Text(
                        timing,
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
    
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Image(
                      image: AssetImage('assets/images/greylocation.png'),
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      'Location:',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Expanded(
                      child: Text(
                        locationsaloon,
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
    
                SizedBox(height: 10.h),
    
                Row(
                  children: [
                    Text(
                      "Your Feedback:",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
    
                SizedBox(height: 5.h),
    
                Text(
                  feedback,
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
