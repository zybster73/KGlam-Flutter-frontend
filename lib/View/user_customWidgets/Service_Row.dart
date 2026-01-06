import 'package:KGlam/Services/clientApi.dart';
import 'package:KGlam/View/CustomWidgets/ShimmerEffectRow.dart';
import 'package:KGlam/View/CustomWidgets/shimmerEffect.dart';
import 'package:KGlam/View/user_side/bookTopservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Service_Row extends StatefulWidget {
  const Service_Row({super.key});

  @override
  State<Service_Row> createState() => _Service_RowState();
}

class _Service_RowState extends State<Service_Row> {
  List<dynamic> topServices = [];
  bool isloading = true;

  @override
  void initState() {
    super.initState();
    fetchTopservices();
  }

  Future<void> fetchTopservices() async {
    final result = await client_Api().getTopServices();
    if (result != null) {
      setState(() {
        topServices = result;
        isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: SizedBox(
        height: 170,
        child: isloading ? Center(
          child: LoadingAnimationWidget.hexagonDots(color: Color(0xFF01ABAB), size: 50),
        ) :
         ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: topServices.length,
          itemBuilder: (context, index) {
            final item = topServices[index];
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildServiceCard(
                  item['id'],
                  item['service_name'],
                  item['service_image'] ?? '',
                  item['salon_name'],
                ),
                SizedBox(width: 10.w),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildServiceCard(
    int id,
    String title,
    String imagePath,
    String title2,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Booktopservice(serviceId: id),
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
                image: imagePath.startsWith('http')
                    ? NetworkImage(imagePath)
                    : const AssetImage('assets/images/unsplash.jpg')
                          as ImageProvider,
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
