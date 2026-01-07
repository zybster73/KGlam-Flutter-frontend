import 'package:KGlam/Services/clientApi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:KGlam/View/user_side/UserNavigationBar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:provider/provider.dart';

class SpecificFeedback extends StatefulWidget {
  final int bookingss;

  final int? backuplogic;
  const SpecificFeedback({
    super.key,
    this.backuplogic,
    required this.bookingss,
  });

  @override
  State<SpecificFeedback> createState() => _SpecificFeedbackscreenState();
}

class _SpecificFeedbackscreenState extends State<SpecificFeedback> {
  Map<String, dynamic>? feedbackData;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchFeedback();
  }

  Future<void> fetchFeedback() async {
    final result = await client_Api().customerSeefeedback(widget.bookingss);

    if (result['success'] == true && result['data'] != null) {
      setState(() {
        feedbackData = result['data'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cleintApi = Provider.of<client_Api>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          if (widget.backuplogic == 1) {
            Navigator.pop(context);
          } else {
            Navigator.pop(context);
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: isLoading
            ? Center(
                child: LoadingAnimationWidget.hexagonDots(
                  color: Color(0xFF01ABAB),
                  size: 50,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 200.h,
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
                                    if (widget.backuplogic == 1) {
                                      Navigator.pop(context);
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Feedback',
                                        style: GoogleFonts.poppins(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // SizedBox(height: 10),
                                      Text(
                                        'View your feedback and completed appointments.',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        _buildappointmantCard(
                          "${feedbackData?['service_name']} : ",
                          feedbackData?['service_image'] ?? '',
                          "${feedbackData?['booking_date']} , ${feedbackData?['booking_time']}",
                          'You',
                          feedbackData?['salon_name'] ?? '',
                          feedbackData?['feedback_text'] ?? '',
                        ),

                        // SizedBox(height: 10.h),

                        // _buildappointmantCard(
                        //   'Fresh Hair Cut Make Over :',
                        //   'assets/images/Ahair.jpg',
                        //   '05:00 PM, Monday',
                        //   'Abdullah Khan',
                        //   'Crown and Canvas',
                        //   'I got my hairstyle done at Canvas Salon — the result was amazing! The staff is very professional and the atmosphere is relaxing. I’ll definitely come back again. ⭐⭐⭐⭐⭐',
                        // ),
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
                      image: image.isNotEmpty
                          ? NetworkImage(image)
                          : const AssetImage('assets/images/unsplash.jpg')
                                as ImageProvider,

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
                      'Booked by: ',
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
                    Image(image: AssetImage('assets/images/greylocation.png')),
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
