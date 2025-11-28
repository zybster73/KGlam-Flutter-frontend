import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saloon_app/View/CustomWidgets/User_sidebar.dart';
import 'package:saloon_app/View/user_customWidgets/Service_Row.dart';
import 'package:saloon_app/View/user_side/Saloon_Details.dart';

class Customerhomescreen extends StatefulWidget {
  const Customerhomescreen({super.key});

  @override
  State<Customerhomescreen> createState() => _CustomerhomescreenState();
}

class _CustomerhomescreenState extends State<Customerhomescreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
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
                      height: screenHeight * 0.35,
                      width: screenWidth * 0.9,
                      fit: BoxFit.contain,
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                      top: 80.h,
                      left: 20.w,
                      right: 20.w,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 30.r,
                          child: Icon(
                            Icons.person,
                            size: 35.sp,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hi, Abdullah Khan',
                                style: GoogleFonts.poppins(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'Welcome, Customer',
                                style: GoogleFonts.poppins(
                                  fontSize: 13.sp,
                                  color: Colors.black54,
                                ),
                              ),
                              Text(
                                'Lahore, Pakistan',
                                style: GoogleFonts.poppins(
                                  fontSize: 13.sp,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Builder(
                          builder: (context) {
                            return InkWell(
                              onTap: () {
                                Scaffold.of(context).openDrawer();
                              },
                              child: Image(
                                image: AssetImage('assets/images/MENU.png'),
                                height: 24.h,
                                width: 24.w,
                              ),
                            );
                          },
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
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: 'Search Saloon or Service',
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
                        SizedBox(width: 12.w),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              child: Row(
                children: [
                  Text(
                    'Top Services For You',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Service_Row(),
            SizedBox(height: 10.h),

            // Top Saloons For You
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              child: Row(
                children: [
                  Text(
                    'Top Saloons For You',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSaloonCard(
                  'Crown and Canvas Saloon :',
                  'assets/images/unsplash.jpg',
                  'Downtown Lahore, at 25-G Main Boulevard, Gulberg II',
                  'Every visit is more than just a beauty appointment — its a creative experience designed to bring out your true style. Our expert stylists treat every strand like a stroke on a canvas, blending precision, color, and care to craft your perfect look.',
                  '5 KM away from your location',
                ),
                SizedBox(height: 10.h),
                _buildSaloonCard(
                  'Neil Brothers Hair Saloon :',
                  'assets/images/STRAIGHT.jpg',
                  'Uptown Lahore, at 47-B Liberty Avenue, Gulberg III',
                  'Each visit is more than just a salon session — its a personalized journey crafted to reveal your unique charm. Our skilled artists shape every detail with passion and finesse, blending texture, tone, and technique to design your signature style.',
                  '6 KM away from your location',
                ),
              ],
            ),
          //  SafeArea(child:Text('')),
            SizedBox(height: 60.h,)
          ],
          
        ),
      ),
    );
  }

  Widget _buildSaloonCard(
    String title,
    String image,
    String locationsaloon,
    String descriptionsaloon,
    String distance,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SalonDetailScreen(
              imagePath: image,
              salonName: title,
              location: locationsaloon,
              description: descriptionsaloon,
            ),
          ),
        );
      },
      child: Container(
        height: 436.h,
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
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
                  Positioned(
                    bottom: 8.h,
                    left: 8.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        distance,
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              descriptionsaloon,
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Image(image: AssetImage('assets/images/xx.png')),
                SizedBox(width: 5.w),
                Expanded(
                  child: Text(
                    locationsaloon,
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

