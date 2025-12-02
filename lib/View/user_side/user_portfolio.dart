import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:KGlam/View/user_side/Selected_Service.dart';

class UserPortfolio extends StatefulWidget {
  const UserPortfolio({super.key});

  @override
  State<UserPortfolio> createState() => _UserPortfolioState();
}

class _UserPortfolioState extends State<UserPortfolio> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
                    top: -0.05 * screenHeight,
                    left: -10,
                    child: Image.asset(
                      'assets/images/Eclipse2.png',
                      height: screenHeight * 0.35,
                      width: screenWidth * 0.9,
                      fit: BoxFit.contain,
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
                    padding: EdgeInsets.only(
                      top: 95.h,
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
                                'Portfolio',
                                style: GoogleFonts.poppins(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'View our portfolio so you can get the better idea of their services.',
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
                    top: 180.h,
                    left: 20.w,
                    right: 20.w,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: 'Search',
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
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    _buildSaloonCard(
                      'Hair Styling MakeOver',
                      'assets/images/whitebitch.jpg',
                      'Transform your look with expert styling that defines confidence.',
                      246,
                      395,
                    ),
                    SizedBox(height: 3.h),
                    _buildSaloonCard(
                      'Shine & Smooth Hair Polish',
                      'assets/images/wash.jpg',
                      'Experience radiant shine and silky smooth hair with every touch.',
                     246,
                      395,
                    ),
                    SizedBox(height: 3.h),
                    _buildSaloonCard(
                      'Scalp and HairSpa',
                      'assets/images/wet.jpg',
                      'Revitalize your scalp and nourish hair with deep spa care.',
                      246,
                      395,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSaloonCard(
                      'Elegant Beard Styling',
                      'assets/images/RRR.jpg',
                      'Style your beard with our specialized that transform look.',
                      246,
                      395,
                    ),
                    SizedBox(height: 3.h),
                    _buildSaloonCard(
                      'Radiant Glow Face Massage',
                      'assets/images/face.jpg',
                      'Experience radiant glow with our soothing, rejuvenating face massage therapy.',
                      246,
                      395,
                    ),
                    SizedBox(height: 3.h),
                    _buildSaloonCard(
                      'Elegant Nail Art Dsign',
                      'assets/images/polish.jpg',
                      'Stylish nail art that defines beauty, creativity, and confident self-expression.',
                      246,
                      395,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaloonCard(
    String Servicename,
    String imagePath,
    String description,
    int height,
    int mainheight,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Selected_Service(
              imagePath: imagePath,
              Servicename: Servicename,
              description: description,
              imageheight: height * 2,
            ),
          ),
        );
      },
      child: Container(
        height: mainheight.h,
        width: 176.w,
        padding: EdgeInsets.all(5.r),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    height: height.h,
                    width: 176.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      image: DecorationImage(
                        image: AssetImage(imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              Servicename,
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              description,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Color(0xFFDC6803),
                  radius: 8.r,
                  child: Icon(Icons.star, color: Colors.white, size: 9),
                ),
                SizedBox(width: 2.w),
                CircleAvatar(
                  backgroundColor: Color(0xFFDC6803),
                  radius: 8.r,
                  child: Icon(Icons.star, color: Colors.white, size: 9),
                ),
                SizedBox(width: 2.w),
                CircleAvatar(
                  backgroundColor: Color(0xFFDC6803),
                  radius: 8.r,
                  child: Icon(Icons.star, color: Colors.white, size: 9),
                ),
                SizedBox(width: 2.w),
                CircleAvatar(
                  backgroundColor: Color(0xFFDC6803),
                  radius: 8.r,
                  child: Icon(Icons.star, color: Colors.white, size: 9),
                ),
                SizedBox(width: 2.w),
                CircleAvatar(
                  backgroundColor: Color(0xFFDC6803),
                  radius: 8.r,
                  child: Icon(Icons.star, color: Colors.white, size: 9),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
