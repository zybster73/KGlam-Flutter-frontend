import 'dart:io';

import 'package:KGlam/Services/salon_Api_provider.dart';
import 'package:KGlam/View/CustomWidgets/CustomImagePicker.dart';
import 'package:KGlam/View/CustomWidgets/fluttertoast.dart';
import 'package:KGlam/View/CustomWidgets/shimmerEffectlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:KGlam/View/CustomWidgets/CustomTextField.dart';
import 'package:KGlam/View/Login%20&%20signup/service_inforamtion.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class Editprofileinformation extends StatefulWidget {
  @override
  State<Editprofileinformation> createState() => _EditprofileinformationState();
}

class _EditprofileinformationState extends State<Editprofileinformation> {
  File? selectedImage;
  File? SecondImage;
  String? profileImageUrl;
  String? coverImageUrl;
  TextEditingController saloonName = TextEditingController();
  TextEditingController saloonAddress = TextEditingController();
  TextEditingController saloonContact = TextEditingController();
  TextEditingController saloonHours = TextEditingController();
  TextEditingController saloonDescription = TextEditingController();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchsalonDetails();
  }

  Future<void> fetchsalonDetails() async {
    final data = await SalonApiProvider().getspecificSalon();

    if (data != null && data.isNotEmpty) {
      setState(() {
        saloonName.text = data['salon_name'];
        saloonAddress.text = data['salon_address'];
        saloonContact.text = data['salon_contact'];
        saloonHours.text = data['hours_of_operation'];
        saloonDescription.text = data['salon_desc'];
        profileImageUrl = data['salon_profile_image'];
        coverImageUrl = data['salon_cover_image'];
        isLoading = false;
      });
    } else {
      print('data is null or empty');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    saloonName.dispose();
    saloonAddress.dispose();
    saloonContact.dispose();
    saloonHours.dispose();
    saloonDescription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final salonApi = Provider.of<SalonApiProvider>(context);
    Utils.instance.initToast(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return ModalProgressHUD(
      inAsyncCall: salonApi.isLoading,
      child: Scaffold(
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
                    top: 50.h,
                    left: 20.w,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          iconSize: 18,
                          padding: EdgeInsets.zero,
                          color: Colors.black,
      
                          icon: Icon(Icons.arrow_back_ios_sharp),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: screenHeight * 0.05 + 20,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/Logo.png',
                          width: 120,
                          height: 120,
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
                          child: isLoading
                              ? ShimmerEffectlist(itemCount: 7, height: 50)
                              : Column(
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
                                      text: "Upload Profile image",
                                      title: 'Upload Profile Image',
                                      initialImageUrl: profileImageUrl,
                                      onImageSelected: (image) {
                                        selectedImage = image;
                                      },
                                    ),
                                    SizedBox(height: 10),
                                    UploadImageCard(
      
                                     text: "Upload Cover image",
                                     title: 'Upload Profile Image',
                                      initialImageUrl: coverImageUrl,
                                      onImageSelected: (image) {
                                        SecondImage = image;
                                      },
                                    ),
                                    SizedBox(height: 30),
                                    ElevatedButton(
                                      onPressed: () async {
                                        final result = await salonApi
                                            .updateSolonDetails(
                                              saloonName.text,
                                              saloonAddress.text,
                                              saloonContact.text,
                                              saloonHours.text,
                                              saloonDescription.text,
                                              selectedImage,
                                              SecondImage,
      
                                            );
                                        if (result['success'] == true) {
                                          Navigator.pop(context, true);
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        backgroundColor: Color(0xFF01ABAB),
                                        minimumSize: Size(
                                          MediaQuery.sizeOf(context).width * 0.96,
                                          50,
                                        ),
                                      ),
                                      child: salonApi.isLoading
                                          ? Center(
                                              child: LoadingAnimationWidget.progressiveDots(
                                                size: 50,
                                                color: Colors.white,
                                              ),
                                            )
                                          : Text(
                                              'Save',
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
      ),
    );
  }
}
