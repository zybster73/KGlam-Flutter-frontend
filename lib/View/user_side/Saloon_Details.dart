import 'package:KGlam/Services/clientApi.dart';
import 'package:KGlam/Services/salon_Api_provider.dart';
import 'package:KGlam/View/CustomWidgets/fluttertoast.dart';
import 'package:KGlam/View/user_customWidgets/salon_row.dart';
import 'package:KGlam/View/user_side/UserNavigationBar.dart';
import 'package:KGlam/View/user_side/customerHomescreen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:KGlam/View/user_customWidgets/Service_Row.dart';
import 'package:KGlam/View/user_side/user_portfolio.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SalonDetailScreen extends StatefulWidget {
  final int salonId;
  // final String? imagePath;
  // final String? saloonNametitle;
  // final String? location;
  // final String? description;

  const SalonDetailScreen({super.key, required this.salonId});

  @override
  State<SalonDetailScreen> createState() => _SalonDetailScreenState();
}

class _SalonDetailScreenState extends State<SalonDetailScreen> {
  late int id;
  Map<String, dynamic>? SpecificSalon;

  bool isServicesLoading = true;

  @override
  void initState() {
    super.initState();
    id = widget.salonId;
    fetchSalons();
  }

  Future<void> fetchSalons() async {
    final response = await client_Api().getspecificSalonClient(id);

    if (response != null) {
      setState(() {
        SpecificSalon = response;
        isServicesLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Utils.instance.initToast(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Usernavigationbar()),
        );
      },
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: 
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserPortfolio(id: widget.salonId),
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
        ),
        backgroundColor: Colors.white,
        body: isServicesLoading
            ? Center(
                child: LoadingAnimationWidget.hexagonDots(
                  color: Color(0xFF01ABAB),
                  size: 50,
                ),
              )
            : Stack(
                children: [
                  Image(
                    image:
                        (SpecificSalon?['salon_cover_image'] != null &&
                            SpecificSalon!['salon_cover_image']
                                .toString()
                                .isNotEmpty)
                        ? NetworkImage(SpecificSalon!['salon_cover_image'])
                        : const AssetImage('assets/images/unsplash.jpg')
                              as ImageProvider,
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),

                  Container(
                    height: MediaQuery.sizeOf(context).height,
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
                          SpecificSalon!['salon_name'] ??
                              'Crown and Canvas Saloon:',
                          style: GoogleFonts.poppins(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                  
                        Text(
                          SpecificSalon!['salon_desc'],
                          style: GoogleFonts.poppins(
                            fontSize: 15.sp,
                            color: Colors.black87,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 20),
                  
                        // Text(
                        //   "Client rating on this service:",
                        //   style: GoogleFonts.poppins(
                        //     fontWeight: FontWeight.bold,
                        //     fontSize: 14.sp,
                        //   ),
                        // ),
                        // const SizedBox(height: 8),
                  
                        // Row(
                        //   children: List.generate(
                        //     5,
                        //     (index) => Padding(
                        //       padding: const EdgeInsets.only(right: 5),
                        //       child: CircleAvatar(
                        //         radius: 10,
                        //         backgroundColor: const Color(0xFFDC6803),
                        //         child: const Icon(
                        //           Icons.star,
                        //           color: Colors.white,
                        //           size: 15,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Image(
                              image: AssetImage('assets/images/xx.png'),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                SpecificSalon!['salon_address'] ?? '',
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
                              SpecificSalon!['hours_of_operation'],
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
                  
                        salonRow(salonId: widget.salonId),
                        const SizedBox(height: 35),
                      ],
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
                              builder: (context) => Usernavigationbar(),
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
