import 'package:KGlam/Services/clientApi.dart' show client_Api;
import 'package:KGlam/View/CustomWidgets/videoPlayerWidget.dart';
import 'package:KGlam/View/user_side/UserNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:KGlam/View/user_side/user_appointmnets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class waitingResponse extends StatefulWidget {
  // final String imagePath;
  // final String serviceName;
  // final String description;
  final int serviceID;
  // final String saloonName;
  const waitingResponse({
    super.key,
    // required this.imagePath,
    // required this.serviceName,
    required this.serviceID,
    // required this.description,
    // required this.saloonName,
  });

  @override
  State<waitingResponse> createState() => _waitingResponseState();
}

class _waitingResponseState extends State<waitingResponse> {
  bool isloading = true;
  PageController pageController = PageController();
  int currentIndex = 0;
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
    return Scaffold(
      body: isloading
          ? Center(
              child: LoadingAnimationWidget.hexagonDots(
                color: Color(0xFF01ABAB),
                size: 50,
              ),
            )
          : Stack(
              children: [
               SizedBox(
                  height: 600,
                  width: double.infinity,
                  child: _imageVideoscroll(specificService),
                ),
                
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 25,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "By: ${specificService!['salon_name']}",
                            style: GoogleFonts.poppins(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Request Sent",
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "The service you sent to your barber will take a little time to be accepted, so please wait.",
                            style: GoogleFonts.poppins(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          const CircleAvatar(
                            backgroundImage: AssetImage(
                              'assets/images/Request.png',
                            ),
                            radius: 50,
                          ),
                          SizedBox(height: 25.h),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => Usernavigationbar(),
                                ),
                                (route) => false,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 52),
                              backgroundColor: const Color(0xFF01ABAB),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
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
                ),

                /// Back Button
                Positioned(
                  top: 50,
                  left: 16,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white.withOpacity(0.8),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, size: 14),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
  Widget _imageVideoscroll(Map<String, dynamic>? service) {
    List<Widget> media = [];

    media.add(
      Image(
        image:
            (service?['service_image'] != null &&
                service!['service_image'].toString().isNotEmpty)
            ? NetworkImage(service['service_image'])
            : const AssetImage('assets/images/unsplash.jpg') as ImageProvider,
        width: double.infinity,
        height: 400,
        fit: BoxFit.cover,
      ),
    );

    if (service?['service_video'] != null &&
        service!['service_video'].toString().isNotEmpty) {
      media.add(VideoPlayerWidget(url: service['service_video']));
    }

    if (media.length == 1) return media[0];
    return Stack(
      alignment: Alignment.bottomCenter, 
      children: [
        PageView.builder(
          controller: pageController,
          itemCount: media.length,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return media[index];
          },
        ),
        Positioned(
          top: 460,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(media.length, (index) {
              return AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 4),
                width: currentIndex == index ? 12 : 8,
                height: currentIndex == index ? 12 : 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: currentIndex == index
                      ? Color(0xFF01ABAB)
                      : Colors.grey,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
