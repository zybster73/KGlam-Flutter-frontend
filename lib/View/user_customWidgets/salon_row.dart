import 'package:KGlam/View/user_side/bookTopservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class salonRow extends StatefulWidget {
  const salonRow({super.key});

  @override
  State<salonRow> createState() => _salonRowState();
}

class _salonRowState extends State<salonRow> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildServiceCard('Haircut',
             'assets/images/haircutFreepik.jpg', 
             
             ),
            SizedBox(width: 10.w),
            _buildServiceCard(
              'Nail Styling',
              'assets/images/nailstylingFreepik.jpg',
            
              
            ),
            SizedBox(width: 10.w),
            _buildServiceCard('Facial',
             'assets/images/facialFreepik.jpg',
             
            
            ),
            SizedBox(width: 10.w),
            _buildServiceCard('Beard', 
            'assets/images/beard.jpg',
           
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(String title, String imagePath,) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Booktopservice(Btitle: title, Bimage: imagePath,  ),
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
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
