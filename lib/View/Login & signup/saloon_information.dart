import 'dart:io';

import 'package:KGlam/Services/salon_Api_provider.dart';
import 'package:KGlam/View/CustomWidgets/CustomImagePicker.dart';
import 'package:KGlam/View/CustomWidgets/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:KGlam/View/CustomWidgets/CustomTextField.dart';
import 'package:KGlam/View/Login%20&%20signup/service_inforamtion.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaloonInformation extends StatefulWidget {
  @override
  State<SaloonInformation> createState() => _SaloonInformationState();
}

class _SaloonInformationState extends State<SaloonInformation> {
  File? selectedImage;
  File? SecondImage;

  TextEditingController saloonName = TextEditingController();
  TextEditingController saloonAddress = TextEditingController();
  TextEditingController saloonContact = TextEditingController();
  TextEditingController saloonHours = TextEditingController();
  TextEditingController saloonDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Utils.instance.initToast(context);
    final salonApi = Provider.of<SalonApiProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFF01ABAB),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: screenHeight * 0.3,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: -0.05 * screenHeight,
                  left: -10,
                  child: Image.asset(
                    'assets/images/Eclipse.png',
                    height: screenHeight * 0.35,
                    width: screenWidth * 0.9,
                    fit: BoxFit.contain,
                  ),
                ),

                Positioned(
                  top: screenHeight * 0.05 + 20,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/Logo.png',
                        width: 140,
                        height: 140,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Salon Information',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: screenWidth * 0.065,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.008),
                Text(
                  'Enter your salon information. ',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.04),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 15.0,
                        left: 8,
                        right: 8,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: saloonName,
                              hintText: "Enter Salon Name",
                              labelText: 'Salon Name',
                            ),
                            SizedBox(height: 10),
                            CustomTextField(
                              controller: saloonAddress,
                              labelText: 'Salon Address',
                              hintText: 'Enter Address',
                            ),
                            SizedBox(height: 10),
                            CustomTextField(
                              controller: saloonContact,
                              labelText: "Salon Contact",
                              hintText: "Salon Contact",
                            ),
                            SizedBox(height: 10),
                            CustomTextField(
                              controller: saloonHours,
                              labelText: "Business Hours",
                              hintText: "Enter Hours",
                            ),
                            SizedBox(height: 10),
                            CustomTextField(
                              controller: saloonDescription,
                              labelText: 'Salon Description',
                              hintText: 'Enter Description...',
                              length: 4,
                            ),
                            SizedBox(height: 10),
                            UploadImageCard(
                              
                              title: 'Upload Profile Image',
                              onImageSelected: (image) {
                                selectedImage = image;
                              },
                            ),
                            SizedBox(height: 10),
                            UploadImageCard(
                              title: 'Upload Profile Image',
                              onImageSelected: (image) {
                                SecondImage = image;
                              },
                            ),
                            SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: () async {
                                final result = await salonApi.salonInformation(
                                  saloonName.text,
                                  saloonAddress.text,
                                  saloonContact.text,
                                  saloonHours.text,
                                  saloonDescription.text,
                                  selectedImage,
                                  SecondImage,
                                );
                                Future.microtask(() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ServiceInforamtion(),
                                    ),
                                  );
                                });
                                // if (result['success']){
                                //     Future.microtask(() {
                                //     Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //         builder: (context) =>
                                //             ServiceInforamtion(),
                                //       ),
                                //     );
                                //   });
                                // }
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                backgroundColor: Color(0xFF01ABAB),
                                minimumSize: Size(
                                  MediaQuery.sizeOf(context).width * 0.96,
                                  48,
                                ),
                              ),
                              child: salonApi.isLoading
                                  ? CircularProgressIndicator()
                                  : Text(
                                      'Next',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
