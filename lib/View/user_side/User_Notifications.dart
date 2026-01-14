import 'package:KGlam/Services/clientApi.dart';
import 'package:KGlam/View/CustomWidgets/shimmerEffect.dart';
import 'package:KGlam/View/user_side/write_Feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UserNotifications extends StatefulWidget {
  final VoidCallback onMarkAllRead;
  final VoidCallback? onBack;
  const UserNotifications({
    super.key,
    this.onBack,
    required this.onMarkAllRead,
  });

  @override
  State<UserNotifications> createState() => _UserNotificationsState();
}

class _UserNotificationsState extends State<UserNotifications> {
  bool isLoading = true;
  List<dynamic> Notifications = [];
  bool? updated;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    final data = await client_Api().customerNotifications();

    if (data != null) {
      setState(() {
        Notifications = data;
        isLoading = false;
      });
    }
  }

  String formatTime(String dateTimeString) {
    final DateTime dateTime = DateTime.parse(dateTimeString).toLocal();

    return TimeOfDay.fromDateTime(dateTime).format(context);
  }

  @override
  Widget build(BuildContext context) {
    final clientapi = Provider.of<client_Api>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: -0.05 * screenHeight,
            left: -10,
            child: Image.asset(
              'assets/images/Eclipse2.png',
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
                color: Color(0xFF01ABAB),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: IconButton(
                  onPressed: () {
                    if (widget.onBack != null) {
                      widget.onBack!();
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  iconSize: 18,
                  padding: EdgeInsets.zero,
                  color: Colors.white,

                  icon: Icon(Icons.arrow_back_ios_sharp),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 115.h),
                Text(
                  "Notifications",
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Stay updated with every important alert.",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF717680),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () async {
                        final result = await clientapi
                            .markallnotificationasRead();
                        if (result['success']) {
                          setState(() {
                            Notifications = Notifications.map((notif) {
                              notif['is_read'] = true;
                              return notif;
                            }).toList();
                          });
                          widget.onMarkAllRead();
                        }
                      },
                      child: Text(
                        'Mark all as read',
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                Expanded(
                  child: isLoading
                      ? shimmerEffect(itemCount: 5, height: 130)
                      : Notifications.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.notifications,
                                size: 60,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 12),
                              Text(
                                "No Notifications.",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.only(bottom: 70.h, top: 0),
                          itemCount: Notifications.length,
                          itemBuilder: (context, index) {
                            final notify = Notifications[index];
                            bool isHighlighted = index % 2 == 0;
                            return Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: notify['is_read'] == true
                                    ? const Color(0xFFE9FAFA)
                                    : Colors.black12,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF00AFA0),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.notifications_none_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          notify['message'],
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.black,
                                            height: 1.4,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Row(
                                          children: [
                                            Text(
                                              formatTime(notify['created_at']),
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: Color(0xFF717680),
                                              ),
                                            ),
                                            Spacer(),
                                            if (notify['notification_type'] ==
                                                'BOOKING_COMPLETED') 
                                            
                                                InkWell(
                                                  onTap: () async {
                                                    
                                                    updated = await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            WriteFeedback(
                                                              feedback:
                                                                  notify['booking_id'],
                                                            ),
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color:
                                                              const Color.fromARGB(
                                                                31,
                                                                104,
                                                                96,
                                                                96,
                                                              ),
                                                          blurRadius: 4,
                                                          offset: const Offset(
                                                            0,
                                                            2,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Text(
                                                      'FeedBack',
                                                      style:
                                                          GoogleFonts.poppins(
                                                            fontSize: 14,
                                                            color: Color(
                                                              0xFF01ABAB,
                                                            ),
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
