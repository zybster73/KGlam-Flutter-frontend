import 'package:KGlam/Services/salon_Api_provider.dart';
import 'package:KGlam/View/CustomWidgets/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:KGlam/View/owner_side/UpdatePortfolio.dart';
import 'package:KGlam/View/owner_side/Upload_portfolio.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class portfolio extends StatefulWidget {
  const portfolio({super.key});

  @override
  State<portfolio> createState() => _portfolioState();
}

class _portfolioState extends State<portfolio> {
  String BASE_URL = "https://unsurviving-snuffier-marylyn.ngrok-free.dev";

  List<dynamic> portfolios = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    fetchPortfolio();
  }

  Future<void> fetchPortfolio() async {
    final data = await SalonApiProvider().viewPortfolio();

    if (data != null) {
      setState(() {
        portfolios = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final salonApi = Provider.of<SalonApiProvider>(context);
    Utils.instance.initToast(context);
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
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 10),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 90.h),
                SizedBox(height: 20),
                Text(
                  'Portfolio',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Creative visions crafted into meaningful\n designs.',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: 'Search ',
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
                    SizedBox(width: 12.w),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Upload_portfolio(),
                          ),
                        );
                      },
                      child: Container(
                        height: 49,
                        width: 54,
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF717680),
                            width: 0.7,
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Image.asset('assets/images/Add.png'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Expanded(
                  child: portfolios.isEmpty
                      ? Center(
                          child: AnimatedOpacity(
                            opacity: 1.0,
                            duration: const Duration(seconds: 5),
                            curve: Curves.easeInOut,
                            child: Text(
                              'No Portfolio created yet!',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        )
                      : portfolios.isNotEmpty ? Center(
                        child: LoadingAnimationWidget.hexagonDots(color:Color(0xFF01ABAB),  size: 50),
                      ) :
                      GridView.builder(
                          padding: EdgeInsets.only(top: 10),
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                //crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                // childAspectRatio: 0.65,
                              ),
                          itemCount: portfolios.length,
                          itemBuilder: (context, index) {
                            final item = portfolios[index];
                            final serviceName = item['item_name'] ?? '';
                            final description = item['description'] ?? '';
                            final imagePath = item['image'] ?? '';

                            return GestureDetector(
                              onTap: () {},
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
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            15.r,
                                          ),
                                          child: Container(
                                            height: 160.h,
                                            width: double.infinity,
                                            child: Image.network(
                                              "$imagePath",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 8.h,
                                          left: 8.w,
                                          child: Row(
                                            children: [
                                              // Edit Button
                                              Container(
                                                height: 30.h,
                                                width: 30.h,
                                                decoration: BoxDecoration(
                                                  color: Colors.white
                                                      .withOpacity(0.7),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: IconButton(
                                                  padding: EdgeInsets.zero,
                                                  icon: Icon(
                                                    Icons.edit,
                                                    size: 16.sp,
                                                    color: Color(0xFF01ABAB),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            Updateportfolio(
                                                              portfolioId:
                                                                  index,
                                                            ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              SizedBox(width: 8.w),

                                              Container(
                                                height: 30.h,
                                                width: 30.h,
                                                decoration: BoxDecoration(
                                                  color: Colors.white
                                                      .withOpacity(0.7),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: IconButton(
                                                  padding: EdgeInsets.zero,
                                                  icon: Icon(
                                                    Icons.delete,
                                                    size: 16.sp,
                                                    color: Colors.red,
                                                  ),
                                                  onPressed: () async {
                                                    final result =
                                                        await salonApi
                                                            .deletePortfolio(
                                                              item['id'],
                                                            );
                                                    if (result['success']) {
                                                      setState(() {
                                                        portfolios.removeAt(
                                                          index,
                                                        );
                                                      });
                                                    }
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
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

                                    Text(
                                      maxLines: 3,
                                      description,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
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
