import 'package:KGlam/Services/salon_Api_provider.dart';
import 'package:KGlam/View/CustomWidgets/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:KGlam/View/owner_side/editProfileInformation.dart';
import 'package:KGlam/View/owner_side/editProfileServices.dart';
import 'package:http/http.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map<String, dynamic>? profiles;
  List services = [];
  bool isPageLoading = true;



  @override
  void initState() {
    super.initState();
    loadPageData();
  }

  Future<void> fetchProfiles() async {
    final response = await SalonApiProvider().getspecificSalon();

    if (response != null) {
      setState(() {
        profiles = response;
        
      });
    }
  }

  Future<List<dynamic>?> fetchServices() async {
    final response = await SalonApiProvider().viewservicesofspecificSalon();

    if (response != null) {
      setState(() {
        services = response;
      });
    }
  }

  
Future<void> loadPageData() async {
  await Future.wait([
    fetchProfiles(),
    fetchServices(),
  ]);

  setState(() {
    isPageLoading = false;
  });
}

  @override
  Widget build(BuildContext context) {
    Utils.instance.initToast(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: isPageLoading ? Center(
        child: LoadingAnimationWidget.hexagonDots(color: Color(0xFF01ABAB), size: 50),
      ) :
      SingleChildScrollView(
        child: Stack(
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
                    "Profile",
                    style: GoogleFonts.poppins(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(height: 6.h),

                  Text(
                    "Discover your salon’s beautiful story\n inside profile.",
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF717680),
                    ),
                  ),

                  SizedBox(height: 20.h),
                   _Salooninformation(
                          profiles!['salon_profile_image'] ?? '',
                          '${profiles!['salon_name'] ?? ''} :',
                          profiles!['salon_desc'] ?? '',
                          profiles!['salon_address'] ?? '',
                          profiles!['salon_contact'] ?? '',
                          profiles!['hours_of_operation'] ?? '',
                        ),

                  SizedBox(height: 20),

                   _serviceCard(),

                  SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _Salooninformation(
    path,
    saloonName,
    description,
    location,
    contact,
    time,
  ) {
    return Container(
      width: 350.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(path, height: 215, width: 350.w, fit: BoxFit.cover),
            SizedBox(height: 5.h),
            Text(
              saloonName,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.h),

            Text(
              description,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Color(0xFF717680),
              ),
            ),

            SizedBox(height: 5.h),

            Row(
              children: [
                Icon(
                  Icons.location_on_rounded,
                  size: 21,
                  color: Color(0xFF717680),
                ),
                SizedBox(width: 5.w),
                Flexible(
                  child: Text(
                    location,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10.h),

            Row(
              children: [
                Icon(Icons.call_sharp, size: 21, color: Color(0xFF717680)),
                SizedBox(width: 5.w),
                Text(
                  contact,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),

            SizedBox(height: 10.h),

            Row(
              children: [
                Icon(Icons.alarm, size: 21, color: Color(0xFF717680)),
                SizedBox(width: 5.w),
                Text(
                  time,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () async {
                final updated = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Editprofileinformation(),
                  ),
                );
                if (updated == true) {
                  fetchProfiles();
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 48),
                backgroundColor: Color(0xFF01ABAB),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Edit Changes',
                style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _serviceCard() {
    final salonApi = Provider.of<SalonApiProvider>(context);
    return Container(
      width: 350.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Services :',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            ListView.builder(
              itemCount: services.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final service = services[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          service['service_name'],
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          height: 30.h,
                          width: 30.h,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              Icons.edit,
                              size: 16.sp,
                              color: Color(0xFF01ABAB),
                            ),
                            onPressed: () async{
                             bool updated = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Editprofileservices(service : service),
                                ),
                              );
                              if (updated == true) {
                                fetchServices();
                              }
                            },
                          ),
                        ),
                      ],
                    ),

                    Text(
                      service['service_desc'],
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Color(0xFF717680),
                      ),
                    ),

                    SizedBox(height: 10),

                    Row(
                      children: [
                        Icon(
                          Icons.monetization_on_sharp,
                          size: 21,
                          color: Color(0xFF717680),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          service['service_price'],
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(width: 8.w),

                        Icon(Icons.alarm, size: 21, color: Color(0xFF717680)),
                        SizedBox(width: 10.w),
                        Text(
                          service['service_duration'],
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10.h),

                    Divider(),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
