import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saloon_app/View/user_side/Saloon_Details.dart';
import 'package:saloon_app/View/user_side/UserNavigationBar.dart';
import 'package:saloon_app/View/user_side/customerHomescreen.dart';

class CompletedAppointments extends StatefulWidget {
  const CompletedAppointments({super.key});

  @override
  State<CompletedAppointments> createState() => _CompletedAppointmentsState();
}

class _CompletedAppointmentsState extends State<CompletedAppointments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 250.h,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Image(
                      image: AssetImage('assets/images/Eclipse2.png'),
                      height: 250.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 16,
                    child: CircleAvatar(
                      radius: 16,
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
                                'Appointments',
                                style: GoogleFonts.poppins(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'View your upcoming and completed appointments.',
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
                          child: Container(
                            height: 48.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(color: Colors.grey.shade400),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                  ),
                                  child: Image(
                                    image: AssetImage(
                                      'assets/images/search.png',
                                    ),
                                    height: 22.h,
                                    width: 22.w,
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: "Search Salon and Services",
                                      hintStyle: GoogleFonts.poppins(
                                        color: Colors.grey.shade500,
                                        fontSize: 14,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Container(
                          height: 46.h,
                          width: 46.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Image.asset('assets/images/Filter.png'),
                          ),
                        ),
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
                  'I got my hairstyle done at Canvas Saloon — the result was amazing! The staff is very professional and the atmosphere is relaxing. I’ll definitely come back again. ⭐⭐⭐⭐⭐',
                ),

                SizedBox(height: 10.h),

                _buildappointmantCard(
                  'Fresh Hair Cut Make Over :',
                  'assets/images/Ahair.jpg',
                  '05:00 PM, Monday',
                  'Abdullah Khan',
                  'Crown and Canvas',
                  'I got my hairstyle done at Canvas Saloon — the result was amazing! The staff is very professional and the atmosphere is relaxing. I’ll definitely come back again. ⭐⭐⭐⭐⭐',
                ),
              ],
            ),
          ],
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SalonDetailScreen(
              imagePath: image,
              salonName: title,
              location: timing,
              description: bookedby,
            ),
          ),
        );
      },
      child: SingleChildScrollView(
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
      ),
    );
  }
}
