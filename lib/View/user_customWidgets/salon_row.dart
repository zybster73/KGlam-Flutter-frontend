import 'package:KGlam/Services/clientApi.dart';
import 'package:KGlam/View/user_side/bookTopservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class salonRow extends StatefulWidget {
  final int salonId;
  const salonRow({super.key, required this.salonId});

  @override
  State<salonRow> createState() => _salonRowState();
}

class _salonRowState extends State<salonRow> {
  List<dynamic> servicesss = [];
  bool isloading = true;

  @override
  void initState() {
    super.initState();
    fetchservices();
  }

  Future<void> fetchservices() async {
    final response = await client_Api().viewservicesofspecificSalonClient(
      widget.salonId,
    );

    setState(() {
      servicesss = response ?? [];
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isloading
        ? Center(
            child: LoadingAnimationWidget.hexagonDots(
              color: Color(0xFF01ABAB),
              size: 50,
            ),
          )
        : servicesss.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.design_services_sharp, size: 60, color: Colors.grey),
                SizedBox(height: 12),
                Text(
                  "All services will be shown here",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.grey.shade500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: SizedBox(
              height: 170,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: servicesss?.length,
                itemBuilder: (context, index) {
                  final item = servicesss![index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildServiceCard(
                        item['id'],
                        item['service_name'],
                        item['service_image'],
                      ),
                      SizedBox(width: 10.w),
                    ],
                  );
                },
              ),
            ),
          );
  }

  Widget _buildServiceCard(int id, String title, String? imagePath) {
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
                image: (imagePath != null && imagePath.isNotEmpty)
                    ? NetworkImage(imagePath)
                    : const AssetImage('assets/images/unsplash.jpg')
                          as ImageProvider,
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
