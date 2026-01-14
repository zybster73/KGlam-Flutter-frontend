import 'package:KGlam/Services/clientApi.dart';
import 'package:KGlam/View/CustomWidgets/videoPlayerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:KGlam/View/CustomWidgets/fluttertoast.dart';
import 'package:KGlam/View/user_side/Time_Slots.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Selected_Date extends StatefulWidget {
  final int serviceId;

  const Selected_Date({super.key, required this.serviceId});

  @override
  State<Selected_Date> createState() => _Selected_DateState();
}

class _Selected_DateState extends State<Selected_Date> {
  double sheetPosition = -300;

  int? selectedDay;
  String formattedBookingDate = '';
  bool showToast = true;

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
      widget.serviceId,
    );

    setState(() {
      specificService = response;
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Utils.instance.initToast(context);
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
                  height: 400,
                  width: double.infinity,
                  child: _imageVideoscroll(specificService),
                ),
                
              Column(

                children: [
                  Expanded(
                    child: Container(
                      //height: MediaQuery.sizeOf(context).height,
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 400 - 30),
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
                        vertical: 10,
                      ),
                    
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "By: ${specificService!['salon_name']}",
                              style: GoogleFonts.poppins(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Select Date',
                              style: GoogleFonts.poppins(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                                            
                            SizedBox(height: 10.h),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20.0,
                                bottom: 10,
                              ),
                              child: Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: List.generate(31, (index) {
                                  final DateTime today = DateTime.now();
                                  final DateTime todayDate = DateTime(
                                    today.year,
                                    today.month,
                                    today.day,
                                  );
                                            
                                  final day = index + 1;
                                  final now = DateTime.now();
                                  final date = DateTime(
                                    now.year,
                                    now.month,
                                    day,
                                  );
                                            
                                  final isPastDate = date.isBefore(
                                    DateTime(now.year, now.month, now.day),
                                  );
                                  final isSelected = selectedDay == day;
                                  return GestureDetector(
                                    onTap: isPastDate
                                        ? null
                                        : () {
                                            setState(() {
                                              selectedDay = day;
                                              showToast = false;
                                              final now = DateTime.now();
                                              final selectedDate = DateTime(
                                                now.year,
                                                now.month,
                                                selectedDay!,
                                              );
                                              formattedBookingDate =
                                                  "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
                                            
                                              print(
                                                "Booking Date: $formattedBookingDate",
                                              );
                                            });
                                          },
                                    child: Container(
                                      width: 50.w,
                                      height: 50.w,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: isPastDate
                                            ? Colors.grey.shade200
                                            : isSelected
                                            ? const Color(0xFF01ABAB)
                                            : Colors.white,
                                        border: Border.all(
                                          color: isPastDate
                                              ? Colors.grey.shade300
                                              : isSelected
                                              ? const Color(0xFF01ABAB)
                                              : Colors.grey.shade400,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          10,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(
                                              0.15,
                                            ),
                                            blurRadius: 6,
                                            spreadRadius: 2,
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        "$day",
                                        style: GoogleFonts.poppins(
                                          fontSize: 16.sp,
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : FontWeight.w500,
                                          color: isPastDate
                                              ? Colors.grey
                                              : isSelected
                                              ? Colors.white
                                              : Colors.black87,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                                            
                            SizedBox(height: 20.h),
                                            
                            ElevatedButton(
                              onPressed: () {
                                if (selectedDay == null) {
                                  Utils.instance.toastMessage(
                                    "Please select a date first",
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Time_Slots(
                                        bookingDate: formattedBookingDate,
                                        service_id: widget.serviceId,
                                        // imagePath: widget.imagePath,
                                        // Servicename: widget.Servicename,
                                        // imageheight: widget.imageheight,
                                        //description: widget.description,
                                        //saloonName: widget.saloonName,
                                      ),
                                    ),
                                  );
                                }
                              },
                                            
                              style: ElevatedButton.styleFrom(
                                backgroundColor: selectedDay != null
                                    ? Color(0xFF01ABAB)
                                    : Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                minimumSize: Size(double.infinity, 52),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                              ),
                              child: Text(
                                "Next",
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
                ],
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
          top: 350,
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
