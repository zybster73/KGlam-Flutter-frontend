import 'dart:io';

import 'package:KGlam/Services/salon_Api_provider.dart';
import 'package:KGlam/View/CustomWidgets/UploadVideo.dart';
import 'package:KGlam/View/CustomWidgets/shimmerEffectlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:KGlam/View/CustomWidgets/CustomImagePicker.dart';
import 'package:KGlam/View/CustomWidgets/CustomTextField.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class Editprofileservices extends StatefulWidget {
  final Map<String, dynamic> service;
  Editprofileservices({required this.service});
  @override
  State<Editprofileservices> createState() => _EditprofileservicesState();
}

class _EditprofileservicesState extends State<Editprofileservices> {
  String? profileImageUrl;
  File? selectedImage;
  File? selectedVideo;
  String? profileVideoUrl;
  bool isloading = true;
  TextEditingController serviceName = TextEditingController();
  TextEditingController saloonPrice = TextEditingController();
  //TextEditingController saloonContact = TextEditingController();
  TextEditingController serviceHours = TextEditingController();
  TextEditingController serviceDescription = TextEditingController();
  @override
  void initState() {
    super.initState();

    final services = widget.service;

    serviceName.text = services['service_name'];
    saloonPrice.text = services['service_price'];
    serviceHours.text = services['service_duration'];
    serviceDescription.text = services['service_desc'];
    profileImageUrl = services['service_image'];
    profileVideoUrl = services['service_video'];
    isloading = false;
  }

  @override
  Widget build(BuildContext context) {
    final salonApi = Provider.of<SalonApiProvider>(context);
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
                    'Saloon Services',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: screenWidth * 0.065,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.008),
                  Text(
                    'Enter your saloon services. ',
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
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
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
                          child: isloading
                              ? ShimmerEffectlist(itemCount: 5, height: 50)
                              : Column(
                                  children: [
                                    CustomTextField(
                                      controller: serviceName,
                                      hintText: "Enter Service Name",
                                      labelText: 'Service Name',
                                    ),
                                    SizedBox(height: 10),
                                    CustomTextField(
                                      controller: saloonPrice,
                                      labelText: 'Service Price',
                                      hintText: 'Enter Service Price',
                                    ),
                                    SizedBox(height: 10),
                                    // CustomTextField(
                                    //   controller: saloonContact,
                                    //   labelText: "Saloon Contact",
                                    //   hintText: "Saloon Contact",
                                    // ),
                                    // SizedBox(height: 10),
                                    CustomTextField(
                                      controller: serviceHours,
                                      labelText: "Service Estimated Duration",
                                      hintText: "Enter Duration",
                                    ),
                                    SizedBox(height: 10),
                                    CustomTextField(
                                      controller: serviceDescription,
                                      labelText: 'Service Description',
                                      hintText: 'Enter Description...',
                                      length: 4,
                                    ),
                                    SizedBox(height: 10),

                                    UploadImageCard(
                                      text: "Upload Service image",
                                      title: "Upload Service Image",
                                      initialImageUrl: profileImageUrl,
                                      onImageSelected: (image) {
                                        selectedImage = image;
                                      },
                                    ),
                                    SizedBox(height: 10),

                                    UploadVideoCard(
                                      text: "Upload Service video",
                                      title: "Upload Service video (Optional)",
                                       initialVideoUrl: profileImageUrl,
                                      onVideoSelected: (video) {
                                        selectedVideo = video;
                                      },
                                    ),
                                    SizedBox(height: 20),
                                    ElevatedButton(
                                      onPressed: () async {
                                        final result = await salonApi
                                            .updateService(
                                              widget.service['id'],
                                              serviceName.text,
                                              saloonPrice.text,
                                              serviceHours.text,
                                              serviceDescription.text,
                                              selectedImage,
                                              selectedVideo,
                                            );
                                        if (result['success'] == true) {
                                          Navigator.pop(context, true);
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        backgroundColor: Color(0xFF01ABAB),
                                        minimumSize: Size(
                                          MediaQuery.sizeOf(context).width *
                                              0.96,
                                          50,
                                        ),
                                      ),
                                      child: salonApi.isLoading
                                          ? Center(
                                              child:
                                                  LoadingAnimationWidget.progressiveDots(
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
