import 'package:KGlam/Services/clientApi.dart';
import 'package:KGlam/View/CustomWidgets/fluttertoast.dart';
import 'package:KGlam/View/CustomWidgets/shimmerEffect.dart';
import 'package:KGlam/View/user_side/Saloon_Details.dart';
import 'package:KGlam/models/viewSalons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class seeAllSalons extends StatefulWidget {
  @override
  State<seeAllSalons> createState() => _seeAllSalonsState();
}

class _seeAllSalonsState extends State<seeAllSalons> {
  TextEditingController searchController = TextEditingController();
  List<viewSalon> salons = [];
  bool isLoading = true;
  ScrollController scrollController = ScrollController();

  void scrollListner() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      //   loadmore//
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSalons();
  }

  Future<void> fetchSalons() async {
    final data = await client_Api().viewSalons();
    if (data != null) {
      salons = data.map((e) => viewSalon.fromJson(e)).toList();
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    Utils.instance.initToast(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(
              child: LoadingAnimationWidget.hexagonDots(
                color: Color(0xFF01ABAB),
                size: 50,
              ),
            )
          : Container(
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 250.h,
                      child: Stack(
                        children: [
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
                            top: 90.h,
                            left: 20,
                            child: Text(
                              'Here you can see all\n the salons',
                              style: GoogleFonts.poppins(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
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
                                      hintText: 'Search Salon',
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
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: const Color(0xFF01ABAB),
                                          width: 1.4,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.w,
                        vertical: 10.h,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Salons For You',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    isLoading
                        ? shimmerEffect(itemCount: 5, height: 100)
                        : ListView.builder(
                            shrinkWrap: true,
                            controller: scrollController,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: salons.length,
                            itemBuilder: (context, index) {
                              final salon = salons[index];

                              return Padding(
                                padding: EdgeInsets.only(bottom: 10.h),
                                child: _buildSaloonCard(
                                  salon.id,
                                  salon.name,
                                  salon.coverImage != null
                                      ? salon.coverImage!
                                      : 'assets/images/unsplash.jpg',
                                  salon.address,
                                  salon.description,
                                  // salon.hours,
                                ),
                              );
                            },
                          ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildSaloonCard(
    int salonId,
    String title,
    String image,
    String locationsaloon,
    String descriptionsaloon,
    // String distance,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SalonDetailScreen(salonId: salonId),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: Container(
          height: 336.h,
          width: 340.w,
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
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        image: DecorationImage(
                          image: image.startsWith('http')
                              ? NetworkImage(image)
                              : AssetImage(image) as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Positioned(
                    //   bottom: 8.h,
                    //   left: 8.w,
                    //   child: Container(
                    //     padding: EdgeInsets.symmetric(
                    //       horizontal: 8.w,
                    //       vertical: 4.h,
                    //     ),
                    //     decoration: BoxDecoration(
                    //       color: Colors.black.withOpacity(0.6),
                    //       borderRadius: BorderRadius.circular(8.r),
                    //     ),
                    //     child: Text(
                    //       distance,
                    //       style: GoogleFonts.poppins(
                    //         fontSize: 14.sp,
                    //         fontWeight: FontWeight.w500,
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              // SizedBox(height: 12.h),
              Text(
                "$title :",
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
      ),
    );
  }
}
