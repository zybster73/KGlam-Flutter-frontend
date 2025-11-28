import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Service_Row extends StatefulWidget {
  const Service_Row({super.key});

  @override
  State<Service_Row> createState() => _Service_RowState();
}

class _Service_RowState extends State<Service_Row> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildServiceCard('Haircut', 'assets/images/hairstyle.png'),
            SizedBox(width: 10.w),
            _buildServiceCard('Facial', 'assets/images/nail.png'),
            SizedBox(width: 10.w),
            _buildServiceCard('Facial', 'assets/images/beard.png'),
            SizedBox(width: 10.w),
            _buildServiceCard('Haircut', 'assets/images/hairstyle.png'),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(String title, String imagePath) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 100.h,
          width: 100.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 6.r,
                spreadRadius: 3.r,
              ),
            ],
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
