import 'package:KGlam/Services/salon_Api_provider.dart';
import 'package:KGlam/View/CustomWidgets/fluttertoast.dart';
import 'package:KGlam/View/owner_side/uploadService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:KGlam/View/owner_side/manage_saloon_services.dart';
import 'package:http/http.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class viewServices extends StatefulWidget {
  const viewServices({super.key});

  @override
  State<viewServices> createState() => _viewServicesState();
}

class _viewServicesState extends State<viewServices> {
  List<dynamic> services = [];

  TextEditingController searchController = TextEditingController();
  //int value = 0;

  @override
  void initState() {
    super.initState();

    fetchServices();
  }

  Future<void> fetchServices() async {
    final response = await SalonApiProvider().viewservicesofspecificSalon();

    if (response != null) {
      setState(() {
        services = response;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final salonApi = Provider.of<SalonApiProvider>(context);
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
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 115.h),

                Text(
                  "Services",
                  style: GoogleFonts.poppins(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 6.h),

                Text(
                  "The detail of your services that you\n been uploaded.",
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
                          hintText: 'Search Services',
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
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => uploadService(),
                          ),
                        );
                      },
                      child: Container(
                        height: 49,
                        width: 54,
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: Color(0xFF01ABAB) ,
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

                SizedBox(height: 25.h),
                Expanded(
                  child: services.isEmpty
                      ? Center(
                          child: LoadingAnimationWidget.threeArchedCircle(
                            size: 50,
                            color: Color(0xFF01ABAB),
                          ),
                        )
                      : ListView.builder(
                          itemCount: services.length,
                          padding: EdgeInsets.only(bottom: 20.h),
                          itemBuilder: (_, index) {
                            final service = services[index];
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
                                    child: Image.network(
                                      service['service_image'] ??
                                          'assets/images/Haircut.jpg',

                                      height: 214.h,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(height: 12.h),
                                  Text(
                                    service['service_name'] ?? '',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),

                                  SizedBox(width: 8.w),
                                  Text(
                                    service['service_desc'] ?? '',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.sp,
                                      color: const Color(0xFF717680),
                                    ),
                                  ),
                                  SizedBox(height: 8.h),

                                  Row(
                                    children: [
                                      Icon(
                                        Icons.price_change_sharp,
                                        size: 18,
                                        color: Color(0xFF01ABAB),
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(
                                        service['service_price'] ?? '',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14.sp,
                                          color: const Color(0xFF717680),
                                        ),
                                      ),
                                      SizedBox(width: 18.w),
                                      Icon(
                                        Icons.access_time_filled,
                                        size: 18,
                                        color: Color(0xFF01ABAB),
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(
                                        service['service_duration'] ?? '',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14.sp,
                                          color: const Color(0xFF717680),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 14.h),

                                  Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              backgroundColor:
                                                  Colors.transparent,
                                              builder: (bottomSheetContext) {
                                                return Container(
                                                  padding: EdgeInsets.all(20),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                          top: Radius.circular(
                                                            25,
                                                          ),
                                                        ),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                        width: 90,
                                                        height: 90,
                                                        decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
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
                                                        "Delete Service",
                                                        style:
                                                            GoogleFonts.poppins(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                      ),
                                                      SizedBox(height: 8),

                                                      Text(
                                                        "Are you sure you want to delete the Service.",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            GoogleFonts.poppins(
                                                              fontSize: 15,
                                                              color: Colors
                                                                  .black54,
                                                            ),
                                                      ),
                                                      SizedBox(height: 25),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: ElevatedButton(
                                                              onPressed: () async {
                                                                final result =
                                                                    await salonApi
                                                                        .deleteService(
                                                                          service['id'],
                                                                        );
                                                                if (result['success']) {
                                                                  setState(() {
                                                                    services
                                                                        .removeAt(
                                                                          index,
                                                                        );
                                                                  });
                                                                }
                                                              },
                                                              style: ElevatedButton.styleFrom(
                                                                padding:
                                                                    EdgeInsets.symmetric(
                                                                      vertical:
                                                                          14,
                                                                    ),
                                                                backgroundColor:
                                                                    Colors.red,
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
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(width: 10),

                                                          Expanded(
                                                            child: OutlinedButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                  context,
                                                                );
                                                              },
                                                              style: OutlinedButton.styleFrom(
                                                                padding:
                                                                    EdgeInsets.symmetric(
                                                                      vertical:
                                                                          14,
                                                                    ),
                                                                side: BorderSide(
                                                                  color: Colors
                                                                      .black26,
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
                                                                  color: Colors
                                                                      .black87,
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
                                          child: Container(
                                            height: 48.h,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(12.r),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Delete",
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

                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () async {
                                            bool updated = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ManageSaloonServices(
                                                      service: service,
                                                    ),
                                              ),
                                            );

                                            if (updated == true) {
                                              fetchServices();
                                            }
                                          },
                                          child: Container(
                                            height: 48.h,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                color: const Color(0xFF01ABAB),
                                                width: 1.2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12.r),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Edit",
                                                style: GoogleFonts.poppins(
                                                  color: const Color(
                                                    0xFF01ABAB,
                                                  ),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16.sp,
                                                ),
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
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
