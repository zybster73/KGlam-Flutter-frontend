import 'package:KGlam/Services/clientApi.dart';
import 'package:KGlam/Services/salon_Api_provider.dart';
import 'package:KGlam/View/CustomWidgets/fluttertoast.dart';
import 'package:KGlam/View/CustomWidgets/shimmerEffect.dart';
import 'package:KGlam/View/CustomWidgets/shimmerEffectlist.dart';
import 'package:KGlam/View/user_side/seeAllSalons.dart';
import 'package:KGlam/models/viewSalons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:KGlam/View/CustomWidgets/User_sidebar.dart';
import 'package:KGlam/View/user_customWidgets/Service_Row.dart';
import 'package:KGlam/View/user_side/Saloon_Details.dart';

class Customerhomescreen extends StatefulWidget {
  const Customerhomescreen({super.key});

  @override
  State<Customerhomescreen> createState() => _CustomerhomescreenState();
}

class _CustomerhomescreenState extends State<Customerhomescreen> {
  TextEditingController searchController = TextEditingController();
  List<dynamic> salons = [];
  bool isLoading = true;
  ScrollController scrollController = ScrollController();

  String image = '';
  String username = '';

  @override
  void initState() {
    super.initState();
    fetchSalons();
    scrollController.addListener(scrollListner);
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    var data = await SalonApiProvider().getUserDetails();

    if (data != null) {
      setState(() {
        image = data['profile_image'];
        username = data['username'];
      });
    }
  }

  void scrollListner() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      //   loadmore//
    }
  }

  Future<void> fetchSalons() async {
    final data = await client_Api().getTopSalons();
    if (data != null) {
      salons = data;
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
    return Container(
      height: double.infinity,
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
                          backgroundImage: (image.isNotEmpty)
                              ? NetworkImage(image)
                              : null,
                          child: (image.isEmpty)
                              ? Icon(
                                  Icons.person,
                                  size: 30.r,
                                  color: Colors.grey,
                                )
                              : null,
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hi, ${username}',
                                style: GoogleFonts.poppins(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'Welcome, Client',
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
                              hintText: 'Search Salon or Service',
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

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              child: Row(
                children: [
                  Text(
                    'Top Salons For You',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => seeAllSalons()),
                      );
                    },
                    child: Text(
                      'See All',
                      style: GoogleFonts.poppins(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            isLoading
                ? ShimmerEffectlist(itemCount: 3, height: 200)
                : salons.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cut,
                          size: 60,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 12),
                        Text(
                          "Top salons will be shown here",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.grey.shade500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
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
                          salon['id'],
                          salon['salon_name'],
                          salon['salon_cover_image'],

                          salon['salon_address'],
                          salon['salon_desc'],
                          // salon.hours,
                        ),
                      );
                    },
                  ),
          ],
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
                          image: (image.isNotEmpty && image.startsWith('http'))
                              ? NetworkImage(image)
                              : const AssetImage('assets/images/unsplash.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

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
