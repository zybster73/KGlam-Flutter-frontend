import 'package:KGlam/View/user_side/write_Feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class UserNotifications extends StatefulWidget {
  final VoidCallback? onBack;
  const UserNotifications({super.key, this.onBack});

  @override
  State<UserNotifications> createState() => _UserNotificationsState();
}

class _UserNotificationsState extends State<UserNotifications> {
  @override
  Widget build(BuildContext context) {
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
                const SizedBox(height: 24),

                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(bottom: 70.h, top: 0),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      bool isHighlighted = index % 2 == 0;
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE9FAFA),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Your service is complete! We hope you enjoyed your Facial Massage. We hope to see you again! Share your feedback to help us improve!",
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
                                        "2 hours ago",
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: Color(0xFF717680),
                                        ),
                                      ),
                                      Spacer(),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  WriteFeedback(),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            // color: Colors.blueGrey,
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color.fromARGB(
                                                  31,
                                                  104,
                                                  96,
                                                  96,
                                                ),
                                                blurRadius: 4,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Text(
                                            'FeedBack',
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              color: Color(0xFF01ABAB),
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
