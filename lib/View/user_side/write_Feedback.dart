import 'package:KGlam/Services/clientApi.dart';
import 'package:KGlam/View/CustomWidgets/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:KGlam/View/CustomWidgets/CustomTextField.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class WriteFeedback extends StatefulWidget {
  final int feedback;

  WriteFeedback({required this.feedback});
  @override
  State<WriteFeedback> createState() => _WriteFeedbackState();
}

class _WriteFeedbackState extends State<WriteFeedback> {
  int selectedStarCount = 0;
  List<bool> selectedStars = List.generate(5, (_) => false);
  final TextEditingController feed_back = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cleintApi = Provider.of<client_Api>(context);
    Utils.instance.initToast(context);
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
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Feed Back',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.008),
                Text(
                  'Give your honest feedback about\n our service.',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 50),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Container(
                    width: screenWidth,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Text(
                                'Rate Our Service',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: List.generate(5, (index) {
                                  bool isSelected = index < selectedStarCount;

                                  return IconButton(
                                    icon: Icon(
                                      isSelected
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: isSelected
                                          ? Colors.orange
                                          : Colors.grey,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        selectedStarCount = index + 1;
                                        print(selectedStarCount);
                                      });
                                    },
                                  );
                                }),
                              ),
                              const SizedBox(height: 15),

                              CustomTextField(
                                length: 6,
                                controller: feed_back,
                                labelText: "Appointment Feedback",
                                hintText:
                                    'Give your honest feedback about us....',
                              ),

                              SizedBox(height: 30),
                              ElevatedButton(
                                onPressed: () async {
                                  final result = await cleintApi
                                      .customerGivefeedback(
                                        selectedStarCount,
                                        feed_back.text,
                                        widget.feedback,
                                      );
                                  if (result['success']) {

                                    Navigator.pop(context);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(screenWidth * 0.96, 50),
                                  backgroundColor: const Color(0xFF01ABAB),
                                  // padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: cleintApi.isLoading
                                    ? Center(
                                        child:
                                            LoadingAnimationWidget.progressiveDots(
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                      )
                                    : Text(
                                        "Submit",
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
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
