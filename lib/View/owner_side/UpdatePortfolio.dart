import 'dart:io';

import 'package:KGlam/Services/salon_Api_provider.dart';
import 'package:KGlam/View/CustomWidgets/fluttertoast.dart';
import 'package:KGlam/View/CustomWidgets/shimmerEffectlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:KGlam/View/CustomWidgets/CustomImagePicker.dart';
import 'package:KGlam/View/CustomWidgets/CustomTextField.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class Updateportfolio extends StatefulWidget {
  final int portfolioId;

  const Updateportfolio({super.key, required this.portfolioId});
  @override
  State<Updateportfolio> createState() => _UpdateportfolioState();
}

class _UpdateportfolioState extends State<Updateportfolio> {
  String BASE_URL = "https://unsurviving-snuffier-marylyn.ngrok-free.dev";
  String? existingImageUrl;
  File? selectedImage;
  TextEditingController serviceName = TextEditingController();
  TextEditingController serviceDescription = TextEditingController();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    portofolioDetails();
    print(widget.portfolioId);
  }

  Future<void> portofolioDetails() async {
    final data = await SalonApiProvider().viewPortfolio();

    if (data != null && data.isNotEmpty) {
      final Portfolios = data[widget.portfolioId];
      setState(() {
        serviceName.text = Portfolios['item_name'];
        serviceDescription.text = Portfolios['description'];
        existingImageUrl = Portfolios['image'];
        selectedImage = null;
        isLoading = false;
      });
    }
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

                          icon: Icon(Icons.arrow_back_ios_sharp),
                        ),
                      ),
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
                    'Update Portfolio',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: screenWidth * 0.065,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.008),
                  Text(
                    'Update your service images into\n your portfolio. ',
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
                          child: isLoading
                              ? ShimmerEffectlist(itemCount: 3, height: 50)
                              : Column(
                                  children: [
                                    CustomTextField(
                                      controller: serviceName,
                                      hintText: "Enter Service Name",
                                      labelText: 'Service Name',
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
                                    text: "Upload Profile image",
                                    initialImageUrl:existingImageUrl ,
                                    title: "Upload Service Image Or Video",
                                    onImageSelected: (image) {
                                    
                                      selectedImage = image;
                                    },
                                  ),
                               

                                    SizedBox(height: 20),
                                    ElevatedButton(
                                      onPressed: () async {
                                        final result = await salonApi
                                            .updatePortfolio(
                                              widget.portfolioId,
                                              serviceName.text,
                                              serviceDescription.text,
                                              selectedImage,
                                            );
                                        if (result['success']) {
                                          Navigator.pop(context,true);
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
                                          48,
                                        ),
                                      ),
                                      child: salonApi.isLoading
                                          ? CircularProgressIndicator(
                                              color: Colors.white,
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
