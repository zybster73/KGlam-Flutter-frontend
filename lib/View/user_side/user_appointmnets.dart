import 'package:KGlam/Services/clientApi.dart';
import 'package:KGlam/Services/salon_Api_provider.dart';

import 'package:KGlam/View/CustomWidgets/fluttertoast.dart';

import 'package:KGlam/View/user_side/specific_feedback.dart';
import 'package:KGlam/models/customerBooking.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';

class UserAppointmnets extends StatefulWidget {
  final VoidCallback? onBack;
  const UserAppointmnets({super.key, this.onBack});

  @override
  State<UserAppointmnets> createState() => _UserAppointmnetsState();
}

class _UserAppointmnetsState extends State<UserAppointmnets> {
  TextEditingController searchController = TextEditingController();
  int value = 0;
  bool isloading = true;
  List<CustomerBooking> getallBookings = [];

  String? name;

  @override
  void initState() {
    super.initState();
    getBookingsCustomer();
    nameEmail();
  }

  Future<void> nameEmail() async {
    final data = await SalonApiProvider().getUserDetails();

    if (data != null) {
      setState(() {
        name = data['username'];
      });
    }
  }

  Future<void> getBookingsCustomer() async {
    final data = await client_Api().customerGetAllBookings();

    if (data != null) {
      getallBookings = data.map((e) => CustomerBooking.fromJson(e)).toList();
      setState(() {
        isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Utils.instance.initToast(context);
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
                  "Explore your completed services and revisit your submitted feedback.",
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
                  child: isloading
                      ? Center(
                          child: LoadingAnimationWidget.hexagonDots(
                            color: Color(0xFF01ABAB),
                            size: 50,
                          ),
                        )
                      : ListView.builder(
                          itemCount: getallBookings.length,
                          padding: EdgeInsets.only(bottom: 70.h, top: 0),
                          itemBuilder: (_, index) {
                            final bookings = getallBookings[index];
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
                                    child:
                                        bookings.image != null &&
                                            bookings.image!.isNotEmpty
                                        ? Image.network(
                                            bookings.image!,
                                            height: 214.h,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            'assets/images/unsplash.jpg',
                                            height: 214.h,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                  SizedBox(height: 12.h),
                                  Text(
                                    "${bookings.serviceName} :",
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
                                        "Booked By : ${name}",
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
                                        Icons.access_time_filled_sharp,
                                        size: 18,
                                        color: Color(0xFF717680),
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(
                                        "Timing : ${bookings.bookingTime}",
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
                                        "Location : ${bookings.salonAddress}",
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
                                      if (bookings.status == 'pending')
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () async {},
                                            child: Container(
                                              width: screenWidth * 0.96,
                                              height: 48.h,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF01ABAB),
                                                border: Border.all(
                                                  color: const Color(
                                                    0xFF01ABAB,
                                                  ),
                                                  width: 1.2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12.r),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Pending.....",
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.white,

                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16.sp,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                      SizedBox(width: 12.w),
                                      if (bookings.status == 'reject')
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () async {},
                                            child: Container(
                                              width: screenWidth * 0.96,
                                              height: 48.h,
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                border: Border.all(
                                                  color: Colors.red,
                                                  width: 1.2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12.r),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Rejected",
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.white,

                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16.sp,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                      if (bookings.status == 'accept')
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () async {},
                                            style: ElevatedButton.styleFrom(
                                              minimumSize: Size(
                                                screenWidth * 0.96,
                                                45,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              backgroundColor: Color(
                                                0xFF01ABAB,
                                              ),
                                            ),
                                            child: Text(
                                              "Booking Accepted",
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,

                                                fontWeight: FontWeight.w600,
                                                fontSize: 16.sp,
                                              ),
                                            ),
                                          ),
                                        ),

                                      if (bookings.status == 'completed')
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      SpecificFeedback(
                                                        bookingss: bookings.id,
                                                      ),
                                                ),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              minimumSize: Size(
                                                screenWidth * 0.96,
                                                45,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              backgroundColor: Color(
                                                0xFF01ABAB,
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "See your given feedback",
                                                style: GoogleFonts.poppins(
                                                  color: Colors.white,

                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
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
