import 'package:KGlam/Services/clientApi.dart';
import 'package:KGlam/View/user_side/waitingResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:KGlam/View/CustomWidgets/fluttertoast.dart';
import 'package:KGlam/View/user_side/Request_Sent.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Time_Slots extends StatefulWidget {
  final String bookingDate;
  //final String Servicename;
  //final String description;
  final int service_id;
  // final String saloonName;

  const Time_Slots({
    super.key,
    required this.bookingDate,
    // required this.Servicename,
    required this.service_id,
    // required this.description,
    //required this.saloonName,
  });

  @override
  State<Time_Slots> createState() => _Time_SlotsState();
}

class _Time_SlotsState extends State<Time_Slots> {
  String? selectedTime;

  bool isloading = true;
  @override
  void initState() {
    super.initState();

    fetchService();
  }

  Map<String, dynamic>? specificService;

  String convertToBackendTime(String selectedTime) {
    DateTime parsedTime = DateFormat("hh:mm").parse(selectedTime);

    String backendTime = DateFormat("HH:mm").format(parsedTime);

    return backendTime;
  }

  Future<void> fetchService() async {
    final response = await client_Api().viewpecificerviceCleint(
      widget.service_id,
    );

    setState(() {
      specificService = response;
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final clientApi = Provider.of<client_Api>(context);
    Utils.instance.initToast(context);
    List<String> timeSlots = [
      "10:00 AM",
      "10:30 AM",
      "11:00 AM",
      "11:30 AM",
      "12:00 PM",
      "12:30 PM",
      "01:00 PM",
      "01:30 PM",
      "02:00 PM",
      "02:30 PM",
      "03:00 PM",
      "03:30 PM",
      "04:00 PM",
      "04:30 PM",
      "05:00 PM",
    ];

    return Scaffold(
      body: isloading
          ? Center(child: LoadingAnimationWidget.hexagonDots(color: Color(0xFF01ABAB), size: 50))
          : Stack(
              children: [
                Image(
                  image:
                      (specificService?['service_image'] != null &&
                          specificService!['service_image']
                              .toString()
                              .isNotEmpty)
                      ? NetworkImage(specificService!['service_image'])
                      : const AssetImage('assets/images/unsplash.jpg')
                            as ImageProvider,
                  width: double.infinity,
                  height: 400.h,
                  fit: BoxFit.cover,
                ),

                LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
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
                                "By: ${specificService!['salon_name']}",
                                style: GoogleFonts.poppins(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              
                              Text(
                                'Available Time Slots',
                                style: GoogleFonts.poppins(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              //SizedBox(height: 15.h),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 15,
                                  bottom: 20,
                                  right: 15,
                                ),
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount:
                                            MediaQuery.of(context).size.width <
                                                350
                                            ? 2
                                            : 3,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                        childAspectRatio: 2.2,
                                      ),
                                  itemCount: timeSlots.length,
                                  itemBuilder: (context, index) {
                                    final time = timeSlots[index];
                                    final isSelected = selectedTime == time;

                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedTime = time;
                                        });
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? const Color(0xFF01ABAB)
                                              : Colors.white,
                                          border: Border.all(
                                            color: isSelected
                                                ? const Color(0xFF01ABAB)
                                                : Colors.grey,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(
                                                0.1,
                                              ),
                                              blurRadius: 4,
                                              spreadRadius: 1,
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          time,
                                          style: GoogleFonts.poppins(
                                            fontSize: 13,
                                            color: isSelected
                                                ? Colors.white
                                                : Colors.black87,
                                            fontWeight: isSelected
                                                ? FontWeight.bold
                                                : FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),

                              SizedBox(height: 15.h),

                              ElevatedButton(
                                onPressed: () async {
                                  if (selectedTime == null) {
                                    Utils.instance.toastMessage(
                                      "Please select a time first",
                                    );
                                    return;
                                  }

                                  String formattedTime = convertToBackendTime(
                                    selectedTime!,
                                  );
                                  print(formattedTime);

                                  final result = await clientApi.createBooking(
                                    bookingDate: widget.bookingDate,
                                    bookingTime: formattedTime,
                                    id: widget.service_id,
                                  );
                                  if (result.success == true) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => waitingResponse(
                                          serviceID: widget.service_id,
                                          
                                        ),
                                      ),
                                    );
                                  } else {
                                    Utils.instance.toastMessage(
                                      "booking failed",
                                    );
                                  }
                                },

                                style: ElevatedButton.styleFrom(
                                  backgroundColor: selectedTime != null
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
                                child: clientApi.isLoading ? Center(
                                  child: CircularProgressIndicator(),
                                ) 
                                : Text(
                                  "Send Booking",
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
                    );
                  },
                ),

                Positioned(
                  top: 50,
                  left: 16,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.white.withOpacity(0.8),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black,
                          size: 14,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
