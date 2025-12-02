import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:KGlam/View/owner_side/UpdatePortfolio.dart';
import 'package:KGlam/View/owner_side/Upload_portfolio.dart';

class portfolio extends StatefulWidget {
  const portfolio({super.key});

  @override
  State<portfolio> createState() => _portfolioState();
}

class _portfolioState extends State<portfolio> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 90.h),
                  SizedBox(height: 20),
                  Text(
                    'Portfolio',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Creative visions crafted into meaningful\n designs.',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: 'Search ',
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
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Upload_portfolio(),
                            ),
                          );
                        },
                        child: Container(
                          height: 49,
                          width: 54,
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFF717680),
                              width: 0.7,
                            ),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Image.asset('assets/images/Add.png'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
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
                                    //  395,
                                  ),
                                  SizedBox(height: 3.h),
                                  _buildSaloonCard(
                                    'Shine & Smooth Hair Polish',
                                    'assets/images/wash.jpg',
                                    'Experience radiant shine and silky smooth hair with every touch.',
                                    150,
                                    //  257,
                                  ),
                                  SizedBox(height: 3.h),
                                  _buildSaloonCard(
                                    'Scalp and HairSpa',
                                    'assets/images/wet.jpg',
                                    'Revitalize your scalp and nourish hair with deep spa care.',
                                    246,
                                    //  395,
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildSaloonCard(
                                      'Elegant Beard Styling',
                                      'assets/images/RRRR.jpg',
                                      'Style your beard with our specialized that transform look.',
                                      150,
                                      //  257,
                                    ),
                                    SizedBox(height: 3.h),
                                    _buildSaloonCard(
                                      'Radiant Glow Face Massage',
                                      'assets/images/face.jpg',
                                      'Experience radiant glow with our soothing, rejuvenating face massage therapy.',
                                      300,
                                      //  395,
                                    ),
                                    SizedBox(height: 3.h),
                                    _buildSaloonCard(
                                      'Elegant Nail Art Dsign',
                                      'assets/images/polish.jpg',
                                      'Stylish nail art that defines beauty, creativity, and confident self-expression.',
                                      150,
                                      // 257,
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
      ),
    );
  }

  Widget _buildSaloonCard(
    String serviceName,
    String imagePath,
    String description,
    double imageHeight,
  ) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 176.w,
        padding: EdgeInsets.all(5.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: imageHeight.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 8.h,
                  left: 8.w,
                  child: Row(
                    children: [
                      Container(
                        height: 30.h,
                        width: 30.h,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              Icons.edit,
                              size: 16.sp,
                              color: Color(0xFF01ABAB),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Updateportfolio(),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),

                      Container(
                        height: 30.h,
                        width: 30.h,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              Icons.delete,
                              size: 16.sp,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (bottomSheetContext) {
                                  return Container(
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(25),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 90,
                                          height: 90,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: AssetImage(
                                                "assets/images/confirmation.png",
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 15),

                                        Text(
                                          "Delete Portfolio",
                                          style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: 8),

                                        Text(
                                          "Are you sure you want to delete the portfolio.",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        SizedBox(height: 25),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(
                                                    bottomSheetContext,
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 14,
                                                  ),
                                                  backgroundColor: Colors.red,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                ),
                                                child: Text(
                                                  "Yes",
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10),

                                            Expanded(
                                              child: OutlinedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                style: OutlinedButton.styleFrom(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 14,
                                                  ),
                                                  side: BorderSide(
                                                    color: Colors.black26,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                ),
                                                child: Text(
                                                  "No",
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.black87,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              serviceName,
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
              children: List.generate(5, (_) {
                return Padding(
                  padding: EdgeInsets.only(right: 2.w),
                  child: CircleAvatar(
                    backgroundColor: Color(0xFFDC6803),
                    radius: 8.r,
                    child: Icon(Icons.star, color: Colors.white, size: 9),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
