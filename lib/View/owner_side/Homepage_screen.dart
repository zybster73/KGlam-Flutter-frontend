import 'package:KGlam/Services/salon_Api_provider.dart';
import 'package:KGlam/Services/storeToken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:KGlam/View/CustomWidgets/MySidebar.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String image = '';
  String username = '';


  @override
  void initState() {
    super.initState();
    fetchUserData();
  }


  Future<void> fetchUserData() async {
    String? token = await Storetoken.getToken();
    print("Fetched token: $token");

    if (token == null) {
      print("No token found, user not logged in");
      return;
    }

    var data = await SalonApiProvider().getUserDetails();

    if (data != null) {
      setState(() {
        image = data['profile_image'];
        username = data['username'];
      });
    }
  }

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
              height: screenHeight * 0.32,
              child: Stack(
                alignment: Alignment.center,
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
                    padding: const EdgeInsets.only(left: 10.0, bottom: 20),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(image),
                          radius: 30.r,
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              username,
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Text(
                              'Welcome, Service Provider',
                              style: GoogleFonts.poppins(
                                color: Color(0xFF717680),
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                              icon: Icon(
                                Icons.menu,
                                color: Colors.black,
                                size: 26,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    top: screenHeight * 0.196,
                    left: screenWidth * 0.05,
                    child: Text(
                      'DashBoard',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),

                  Positioned(
                    top: screenHeight * 0.25,
                    left: screenWidth * 0.05,
                    child: Text(
                      'In this KPI you can view the analytics\n of your bookings.',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        color: Color(0xFF717680),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),

            Column(
              children: [
                CustomContainer(
                  'assets/images/Bookings.png',
                  "Upcoming Bookings",
                  '12 booking are coming in this week.',
                  '12/11/2025',
                ),

                CustomContainer(
                  'assets/images/Appointments.png',
                  'Ongoing Appointments',
                  '4 Appointments are ongoing today',
                  '12/11/2025',
                ),

                CustomContainer(
                  'assets/images/elli.png',
                  'Past Appointments',
                  '400 Appointments are done till now',
                  '12/11/2025',
                ),
                SizedBox(height: 70.h),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget CustomContainer(icon, text, text2, date) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 0.7, color: Color(0xFF717680)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: Image.asset(icon, fit: BoxFit.contain),
              ),
              SizedBox(height: 10),
              Text(
                text,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                text2,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: Color(0xFF717680),
                ),
              ),
              SizedBox(height: 15),
              Text(
                date,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w800,
                  fontSize: 14.sp,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
