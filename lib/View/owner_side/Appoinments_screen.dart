import 'package:KGlam/Services/clientApi.dart';
import 'package:KGlam/models/getBookings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:KGlam/View/CustomWidgets/CustomNavigationBar.dart';
import 'package:KGlam/View/CustomWidgets/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class AppointmentScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const AppointmentScreen({super.key, this.onBack});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  bool isloading = true;
  List<getBookings> getallBookings = [];

  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  bool pageLoading = false;
  int pageNumber = 1;
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    getBookingsOwner();
    scrollController.addListener(scrollListner);
  }

  void scrollListner() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200 &&
        !pageLoading &&
        !isloading) {
      getBookingsOwner(isLoadMore: true);
    }
  }

  Future<void> getBookingsOwner({bool isLoadMore = false}) async {
    if (isLoadMore) {
      setState(() {
        pageLoading = true;
      });
    } else {
      setState(() {
        isloading = true;
        pageNumber = 1;
      });
    }

    final data = await client_Api().ownerGetAllBookings(pageNumber);

    if (data != null && data.isNotEmpty) {
      setState(() {
        if (isLoadMore) {
          getallBookings.addAll(
            data.map((e) => getBookings.fromJson(e)).toList(),
          );
        } else {
          getallBookings = data.map((e) => getBookings.fromJson(e)).toList();
        }

        pageNumber++;
      });
    }

    setState(() {
      isloading = false;
      pageLoading = false;
    });
  }

  // Future<void> getBookingsOwner() async {
  //   final data = await client_Api().ownerGetAllBookings();

  //   if (data != null) {
  //     getallBookings = data.map((e) => getBookings.fromJson(e)).toList();
  //     setState(() {
  //       isloading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final clientApi = Provider.of<client_Api>(context);
    Utils.instance.initToast(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    //ScreenUtil.init(context);

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
                  "View your upcoming, in progress and\ncompleted bookings.",
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
                        onChanged: (value) async {
                          if (value.isNotEmpty) {
                            isSearching = true;

                            final data = await clientApi.ownerBookingSearch(
                              value,
                            );

                            if (data != null) {
                              setState(() {
                                getallBookings = data
                                    .map((e) => getBookings.fromJson(e))
                                    .toList();
                              });
                            }
                          } else {
                           isSearching = false;
                            getBookingsOwner();
                          }
                        },

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
                      : getallBookings.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                isSearching == true ?
                                '':
                                "No bookings yet",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                isSearching
                                    ? "No matching bookings found."
                                    : "Your booked appointments will appear here.",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount:
                              getallBookings.length + (pageLoading ? 1 : 0),
                          controller: scrollController,
                          padding: EdgeInsets.only(bottom: 70.h, top: 0),
                          itemBuilder: (_, index) {
                            if (index == getallBookings.length) {
                              return Padding(
                                padding: const EdgeInsets.all(16),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
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
                                        "Booked By : ${bookings.customerName}",
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
                                      if (bookings.Status == 'pending')
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () async {
                                              final result = await client_Api()
                                                  .ownerAcceptOrReject(
                                                    "accept",
                                                    bookings.id,
                                                  );
                                              if (result != null) {
                                                setState(() {
                                                  getallBookings[index].Status =
                                                      'accept';
                                                });
                                              }
                                            },
                                            child: Container(
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
                                                child: client_Api().isLoading
                                                    ? Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                      )
                                                    : Text(
                                                        "Accept",
                                                        style:
                                                            GoogleFonts.poppins(
                                                              color:
                                                                  Colors.white,

                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 16.sp,
                                                            ),
                                                      ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      SizedBox(width: 12.w),
                                      if (bookings.Status == 'pending')
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () async {
                                              final result = await client_Api()
                                                  .ownerAcceptOrReject(
                                                    "reject",
                                                    bookings.id,
                                                  );
                                              if (result != null) {
                                                setState(() {
                                                  getallBookings[index].Status =
                                                      'reject';
                                                });
                                              }
                                            },
                                            child: Container(
                                              height: 48.h,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
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
                                                child: clientApi.isLoading
                                                    ? Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                              color:
                                                                  const Color(
                                                                    0xFF01ABAB,
                                                                  ),
                                                            ),
                                                      )
                                                    : Text(
                                                        "Reject",
                                                        style:
                                                            GoogleFonts.poppins(
                                                              color:
                                                                  const Color(
                                                                    0xFF01ABAB,
                                                                  ),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 16.sp,
                                                            ),
                                                      ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      if (bookings.Status == 'accept')
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              final result = await client_Api()
                                                  .ownerCompleteBooking(
                                                    bookings.id,
                                                    "completed",
                                                  );
                                              if (result != null) {
                                                setState(() {
                                                  getallBookings[index].Status =
                                                      'completed';
                                                });
                                              }
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
                                              child: clientApi.isLoading
                                                  ? CircularProgressIndicator()
                                                  : Text(
                                                      "Mark as completed",
                                                      style:
                                                          GoogleFonts.poppins(
                                                            color: Colors.white,

                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 16.sp,
                                                          ),
                                                    ),
                                            ),
                                          ),
                                        ),
                                      if (bookings.Status == 'completed')
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              setState(() {});
                                              // final result = await client_Api()
                                              //     .ownerCompleteBooking(
                                              //       bookings.id,
                                              //       "success",
                                              //     );
                                              // if (result.success) {
                                              //   setState(() {
                                              //     bookings.Status = 'completed';
                                              //   });
                                              // }
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
                                                "Completed",
                                                style: GoogleFonts.poppins(
                                                  color: Colors.white,

                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      if (bookings.Status == 'reject')
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              // final result = await client_Api()
                                              //     .ownerCompleteBooking(
                                              //       bookings.id,
                                              //       "success",
                                              //     );
                                              // if (result.success) {
                                              //   setState(() {
                                              //     bookings.Status = 'completed';
                                              //   });
                                              // }
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
                                              backgroundColor: Colors.red,
                                            ),
                                            child: Center(
                                              child: Text(
                                                "You rejected this service",
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
