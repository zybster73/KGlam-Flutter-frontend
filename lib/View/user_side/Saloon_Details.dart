import 'package:KGlam/View/user_customWidgets/salon_row.dart';
import 'package:KGlam/View/user_side/customerHomescreen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:KGlam/View/user_customWidgets/Service_Row.dart';
import 'package:KGlam/View/user_side/user_portfolio.dart';

class SalonDetailScreen extends StatefulWidget {
  final String? imagePath;
  final String? saloonNametitle;
  final String? location;
  final String? description;

  const SalonDetailScreen({
    super.key,
    this.imagePath,
    this.saloonNametitle,
    this.location,
    this.description,
  });

  @override
  State<SalonDetailScreen> createState() => _SalonDetailScreenState();
}

class _SalonDetailScreenState extends State<SalonDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, 
      onPopInvoked: (didPop) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Customerhomescreen()),
        );
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Image.asset(
              widget.imagePath ?? 'assets/images/unsplash.jpg',
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),

            SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(top: 270),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 6.r,
                      spreadRadius: 3.r,
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.saloonNametitle ?? 'Crown and Canvas Saloon:',
                      style: GoogleFonts.poppins(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Text(
                      'Every visit is more than just a beauty appointment — it’s a creative experience designed to bring out your true style. Our expert stylists treat every strand like a stroke on a canvas, blending precision, color, and care to craft your perfect look.',
                      style: GoogleFonts.poppins(
                        fontSize: 15.sp,
                        color: Colors.black87,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 20),

                    Text(
                      "Client rating on this service:",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Row(
                      children: List.generate(
                        5,
                        (index) => Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: const Color(0xFFDC6803),
                            child: const Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Image(image: AssetImage('assets/images/xx.png')),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            widget.location ?? '',
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              color: Colors.black87,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_filled,
                          color: Color(0xFF01ABAB),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "10:00 AM to 12:00 PM, Mon to Fri",
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            color: Colors.black87,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),

                    Text(
                      "Top Services They Provide For You:",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                      ),
                    ),
                    const SizedBox(height: 12),

                    salonRow(),
                    const SizedBox(height: 35),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UserPortfolio(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF01ABAB),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: Text(
                          "View Portfolio",
                          style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 50,
              left: 16,
              child: CircleAvatar(
                radius: 13,
                backgroundColor: Colors.white.withOpacity(0.8),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.black,
                    size: 10,
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Customerhomescreen(),
                      ),
                      (route) => false,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
