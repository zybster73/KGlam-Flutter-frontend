import 'package:KGlam/Services/clientApi.dart';
import 'package:KGlam/View/user_side/bookTopservice.dart';
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
            _buildServiceCard(
              'Haircut',
              'assets/images/haircutFreepik.jpg',
              'Hicks Salon',
            ),
            SizedBox(width: 10.w),
            _buildServiceCard(
              'Nail Styling',
              'assets/images/nailstylingFreepik.jpg',
              'Royal Salon',
            ),
            SizedBox(width: 10.w),
            _buildServiceCard(
              'Facial',
              'assets/images/facialFreepik.jpg',
              'Stylish Cut Salon',
            ),
            SizedBox(width: 10.w),
            _buildServiceCard(
              'Beard',
              'assets/images/beard.jpg',
              'Crown Salon',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(String title, String imagePath, String title2) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Booktopservice(
              serviceId: 1,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 100.h,
            width: 120.w,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'By : $title2',

                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
