import 'package:KGlam/Services/clientApi.dart' show client_Api;
import 'package:KGlam/View/user_side/UserNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:KGlam/View/user_side/user_appointmnets.dart';

class RequestSent extends StatefulWidget {
  // final String imagePath;
  // final String serviceName;
  // final String description;
  final int serviceID;
  // final String saloonName;
  const RequestSent({
    super.key,
    // required this.imagePath,
    // required this.serviceName,
    required this.serviceID,
    // required this.description,
    // required this.saloonName,
  });

  @override
  State<RequestSent> createState() => _RequestSentState();
}

class _RequestSentState extends State<RequestSent> {
  bool isloading = true;
  @override
  void initState() {
    super.initState();

    fetchService();
  }

  Map<String, dynamic>? specificService;

  Future<void> fetchService() async {
    final response = await client_Api().viewpecificerviceCleint(
      widget.serviceID,
    );

    setState(() {
      specificService = response;
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showRequestSentDialog(context);
    });

    return Scaffold(
      body: Stack(
        children: [
          Image(
            image:
                (specificService?['service_image'] != null &&
                    specificService!['service_image'].toString().isNotEmpty)
                ? NetworkImage(specificService!['service_image'])
                : const AssetImage('assets/images/unsplash.jpg')
                      as ImageProvider,
            width: double.infinity,
            height: 400.h,
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 400 - 30),
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
                    blurRadius: 6,
                    spreadRadius: 3,
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "By: ${specificService!['service_name']}",
                    style: GoogleFonts.poppins(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  SizedBox(height: 10),
                  Text(
                    '              Congratulations 🎉',
                    style: GoogleFonts.poppins(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Your service has been successfully booked.',
                    style: GoogleFonts.poppins(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15.h),
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/Request.png'),
                    radius: 60,
                  ),
                  SizedBox(height: 25.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/xx.png'),
                          Text(
                            'Destination',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Crown Canvas Saloon',
                            style: GoogleFonts.poppins(fontSize: 10),
                          ),
                        ],
                      ),
                      SizedBox(width: 20.h),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/bicon.png'),
                          Text(
                            'Service Taken:',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Hair Styling Make Over',
                            style: GoogleFonts.poppins(fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 15),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/price.png'),
                          Text(
                            'Total Price:',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '£15.30',
                            style: GoogleFonts.poppins(fontSize: 10),
                          ),
                        ],
                      ),
                      SizedBox(width: 20.h),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/total.png'),
                          Text(
                            'Grand Total:',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '£16.10 including taxes',
                            style: GoogleFonts.poppins(fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 15),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/price.png'),
                          Text(
                            'Time Slot:',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '05:00 PM',
                            style: GoogleFonts.poppins(fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 25.h),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => Usernavigationbar()),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 52),
                      backgroundColor: const Color(0xFF01ABAB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      "Continue",
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
        ],
      ),
    );
  }

  void _showRequestSentDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        Future.delayed(const Duration(seconds: 3), () {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        });

        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Request Sent",
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "The service you sent to your barber will take a little time to be accepted, so please wait.",
                  style: GoogleFonts.poppins(
                    fontSize: 13.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/Request.png'),
                  radius: 50,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
