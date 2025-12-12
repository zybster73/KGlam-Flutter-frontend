import 'package:KGlam/View/user_side/Selected_Date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Booktopservice extends StatefulWidget {
  final String Btitle;
  final String Bimage;
  final String? saloonName;
  final String? sName;
  const Booktopservice({
    super.key,
    required this.Btitle,
    required this.Bimage,
    this.saloonName,
    this.sName,
  });

  @override
  State<Booktopservice> createState() => _BooktopserviceState();
}

class _BooktopserviceState extends State<Booktopservice> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Selected_Date(
                  imagePath: widget.Bimage,
                  Servicename: widget.Btitle,
                  imageheight: 400,
                  description: '',
                  saloonName: widget.saloonName ?? '',
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            backgroundColor: const Color(0xFF01ABAB),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            "Book Service",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: 400,
            width: double.infinity,
            child: Image.asset(widget.Bimage, fit: BoxFit.cover),
          ),

          Positioned(
            top: 50,
            left: 16,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white.withOpacity(0.8),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                  size: 14,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),

          // Positioned(
          //   top: 430,
          //   left: 5,
          //   right: 0,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: List.generate(
          //       mediaList.length,
          //       (index) => AnimatedContainer(
          //         duration: const Duration(milliseconds: 300),
          //         margin: const EdgeInsets.symmetric(horizontal: 4),
          //         width: _currentIndex == index ? 12 : 8,
          //         height: _currentIndex == index ? 12 : 8,
          //         decoration: BoxDecoration(
          //           shape: BoxShape.circle,
          //           color: _currentIndex == index
          //               ? Colors.white
          //               : Colors.white.withOpacity(0.5),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          Container(
            margin: EdgeInsets.only(top: 400 - 30),
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),

            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.Btitle,
                    style: GoogleFonts.poppins(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Text(
                    'Hairstyling service is designed to transform your look with precision and creativity. Our expert stylists craft styles that perfectly suit your face shape, personality, and lifestyle — whether it’s a sleek modern cut, soft curls, or a bold new trend.',
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "Client rating:",
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),

                  Row(
                    children: List.generate(
                      5,
                      (i) => const Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: Color(0xFFDC6803),
                          child: Icon(
                            Icons.star,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 15.h),

                  Text(
                    "£15.30",
                    style: GoogleFonts.poppins(
                      color: Color(0xFF01ABAB),
                      fontSize: 24.sp,
                    ),
                  ),

                  // SizedBox(
                  //   width: double.infinity,
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (_) => Selected_Date(
                  //             imagePath: widget.imagePath,
                  //             Servicename: widget.Servicename,
                  //             description: widget.description,
                  //             imageheight: widget.imageheight,
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //     style: ElevatedButton.styleFrom(
                  //       padding: const EdgeInsets.symmetric(vertical: 14),
                  //       backgroundColor: const Color(0xFF01ABAB),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(10),
                  //       ),
                  //     ),
                  //     child: Text(
                  //       "Book Services",
                  //       style: GoogleFonts.poppins(
                  //         color: Colors.white,
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 16.sp,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
