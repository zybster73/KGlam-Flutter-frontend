import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saloon_app/View/owner_side/editProfileInformation.dart';
import 'package:saloon_app/View/owner_side/editProfileServices.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        // 👈 MAIN FIX
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
                    'assets/images/interior.jpg',
                    'Crown and Canvas Saloon :',
                    'Every visit is more than just a beauty appointment — it’s a creative experience designed to bring out your true style. Our expert stylists treat every strand like a stroke on a canvas, blending precision, color, and care to craft your perfect look.',
                    'Downtown Lahore, at 25-G Main Boulevard, Gulberg II',
                    '+92-311-87651231',
                    '09:00 AM to 12:00 PM',
                  ),

                  SizedBox(height: 20),

                  _serviceCard(
                    'Fresh Hair Cut Make Over :',
                    "Whether you’re redefining your vibe or simply refreshing your appearance, we blend creativity with precision to give you a haircut that enhances your personality and turns heads effortlessly",
                    "&18.00",
                    "2 Hours",
                  ),

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
            Image.asset(path, height: 215, width: 322, fit: BoxFit.cover),
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Editprofileinformation(),
                  ),
                );
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

  Widget _serviceCard(servicename, servicedescription, price, time) {
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

            SizedBox(height: 10.h),

            ListView.builder(
              itemCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      servicename,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      servicedescription,
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
                          price,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(width: 8.w),

                        Icon(Icons.alarm, size: 21, color: Color(0xFF717680)),
                        SizedBox(width: 10.w),
                        Text(
                          time,
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
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Editprofileservices(),
                  ),
                );
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
}
