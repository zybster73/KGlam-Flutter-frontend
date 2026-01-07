import 'package:KGlam/Services/clientApi.dart';
import 'package:KGlam/Services/salon_Api_provider.dart';
import 'package:KGlam/View/CustomWidgets/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:KGlam/View/user_side/Selected_Service.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class UserPortfolio extends StatefulWidget {
  final int id;
  const UserPortfolio({super.key, required this.id});

  @override
  State<UserPortfolio> createState() => _UserPortfolioState();
}

class _UserPortfolioState extends State<UserPortfolio> {
  late int id;
  List<dynamic> services = [];
  TextEditingController searchController = TextEditingController();
  bool isServicesLoading = true;

  @override
  void initState() {
    super.initState();
    id = widget.id;
    fetchServices();
  }

  Future<void> fetchServices() async {
    final response = await client_Api().viewservicesofspecificSalonClient(id);

    if (response != null) {
      setState(() {
        services = response;
        isServicesLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Utils.instance.initToast(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return  Scaffold(
            backgroundColor: Colors.white,
            body: isServicesLoading
        ? Center(child: LoadingAnimationWidget.hexagonDots(
          color: Color(0xFF01ABAB),
          size: 50,
        ))
        :
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 250.h,
                    child: Stack(
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
                                  Navigator.pop(context);
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
                          padding: EdgeInsets.only(
                            top: 95.h,
                            left: 15.w,
                            right: 20.w,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Portfolio',
                                      style: GoogleFonts.poppins(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      'View our portfolio so you can get the better idea of their services.',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Positioned(
                          top: 180.h,
                          left: 20.w,
                          right: 20.w,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: searchController,
                                  decoration: InputDecoration(
                                    hintText: 'Search',
                                    hintStyle: GoogleFonts.poppins(
                                      fontSize: 14.sp,
                                      color: const Color(0xFF717680),
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.search_outlined,
                                      color: Color(0xFF717680),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: const Color(0xFF717680),
                                        width: 0.7,
                                      ),
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: const Color(0xFF01ABAB),
                                        width: 1.4,
                                      ),
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 14.w,
                                      vertical: 10.h,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 240,
                    child: services.isEmpty
                        ? Center(
                            child: Text(
                              'No Portfolio created yet!',
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          )
                        : GridView.builder(
                            padding: EdgeInsets.only(top: 10,left: 10),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 0.55,
                                ),
                            itemCount: services.length,
                            itemBuilder: (context, index) {
                              final item = services[index];
                              final id = item['id'];
                              final serviceName = item['service_name'] ?? '';
                              final description = item['service_desc'] ?? '';
                              final imagePath = item['service_image'] ?? '';

                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Selected_Service(service: item, id : widget.id),
                                    ),
                                  );
                                },
                                child: IntrinsicHeight(
                                  child: Container(
                                    width: 176.w,
                                    margin: EdgeInsets.only(bottom: 12.h),
                                    padding: EdgeInsets.all(5.r),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 5,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            15.r,
                                          ),
                                          child: Image(
                                            image: (imagePath.isNotEmpty)
                                                ? NetworkImage(imagePath)
                                                : AssetImage(
                                                        'assets/images/unsplash.jpg',
                                                      )
                                                      as ImageProvider,
                                            width: double.infinity,
                                            height: 200.h,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(height: 8.h),

                                        Text(
                                          serviceName,
                                          style: GoogleFonts.poppins(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        SizedBox(height: 4.h),

                                        Flexible(
                                          child: Text(
                                            description,
                                            style: GoogleFonts.poppins(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w300,
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
                  ),
                ],
              ),
            ),
          );
  }
}
